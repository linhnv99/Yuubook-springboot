package com.devpro.yuubook.services.impl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.devpro.yuubook.services.mappers.CategoryMapper;
import com.devpro.yuubook.utils.FuncUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devpro.yuubook.models.dto.CategoryDTO;
import com.devpro.yuubook.models.entities.Book;
import com.devpro.yuubook.models.entities.Category;
import com.devpro.yuubook.models.entities.Comment;
import com.devpro.yuubook.repositories.CategoryRepo;
import com.devpro.yuubook.services.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService {
    @Autowired
    private CategoryRepo categoryRepo;
    @Autowired
    private CategoryMapper categoryMapper;

    public List<Category> getAllParentCategories() {
        return categoryRepo.findAllParentCategories();
    }

    public Category getById(int id) {
        return categoryRepo.findById(id).orElse(null);
    }

    public Category save(Category categoryIn) {
        Category category = categoryRepo.findById(categoryIn.getId()).orElse(null);
        if (category != null) {
            categoryIn.setShowHome(category.isShowHome());
            categoryIn.setStatus(category.isStatus());
            categoryIn.setCreatedDate(category.getCreatedDate());
            categoryIn.setUpdatedDate(LocalDateTime.now());
        } else {
            categoryIn.setShowHome(false);
            categoryIn.setStatus(true);
            categoryIn.setCreatedDate(LocalDateTime.now());
        }
        categoryIn.setSlug(FuncUtils.toSlug(categoryIn.getName()));
        return categoryRepo.save(categoryIn);
    }

    public void deleteCategoryById(int id) {
        categoryRepo.deleteCategoryById(id);
    }

    public void updateShowHomeById(int id) {
        Category category = categoryRepo.findById(id).orElse(null);
        if(category == null) return;
        category.setShowHome(!category.isShowHome());
        categoryRepo.save(category);
    }

    public List<Category> getAllSubCategoriesByParentId(int id) {
        return categoryRepo.findAllSubcategoriesByParentId(id);
    }

    @Override
    public List<CategoryDTO> getSubCategoryWithLimitedProduct(int limit) {
        List<Category> subCategories = categoryRepo.getAllSubCategoryWithProduct();
        return categoryMapper.toDTO(subCategories, limit);
    }

    @Override
    public List<CategoryDTO> getParentCategoryWithLimitedProduct(int limit) {
        List<CategoryDTO> categoryDTOs = new ArrayList<CategoryDTO>();
        List<CategoryDTO> parentCateWithProduct = new ArrayList<CategoryDTO>();
        List<Category> subCategories = categoryRepo.getAllSubCategoryWithProduct();
        List<Category> parentCategories = categoryRepo.findAllParentCategories();

        for (Category category : parentCategories) {
            CategoryDTO categoryDTO = new CategoryDTO();
            categoryDTO.setCategory(category);
            List<Book> books = new ArrayList<Book>();
            for (Category cate : subCategories) {
                if (cate.getParentId() != null && cate.getParentId().getId() == category.getId()) {
                    for (int i = 0; i < cate.getBooks().size(); i++) {
                        if (i < limit) {
                            books.add(cate.getBooks().get(i));
                        }
                    }
                }
            }
            categoryDTO.setBooks(books);
            parentCateWithProduct.add(categoryDTO);
        }
        // limit product by parentCategory
        for (CategoryDTO category : parentCateWithProduct) {
            CategoryDTO categoryDTO = new CategoryDTO();
            categoryDTO.setCategory(category.getCategory());
            List<Book> booksLimited = new ArrayList<Book>();
            for (int i = 0; i < category.getBooks().size(); i++) {
                if (i < limit) {
                    booksLimited.add(category.getBooks().get(i));
                }
            }
            categoryDTO.setBooks(booksLimited);
            categoryDTOs.add(categoryDTO);
        }
        return categoryDTOs;
    }

    @Override
    public Category getBySlug(String slug) {
        return categoryRepo.findBySlug(slug);
    }
}
