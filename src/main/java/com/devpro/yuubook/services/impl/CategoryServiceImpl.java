package com.devpro.yuubook.services.impl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devpro.yuubook.dto.CategoryDTO;
import com.devpro.yuubook.entities.Book;
import com.devpro.yuubook.entities.Category;
import com.devpro.yuubook.entities.Comment;
import com.devpro.yuubook.repositories.CategoryRepo;
import com.devpro.yuubook.services.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService {
	@Autowired
	private CategoryRepo categoryRepo;

	public List<Category> getAllParentCategories() {
		return categoryRepo.findAllParentCategories();
	}

	public Optional<Category> findCategoryBy(Integer id) {
		return categoryRepo.findById(id);
	}

	public Category save(Category category) {
		if (category.getId() != null) {
			Optional<Category> categoryInDB = categoryRepo.findById(category.getId());
			category.setShowHome(categoryInDB.get().getShowHome());
			category.setCreatedDate(categoryInDB.get().getCreatedDate());
			category.setUpdatedDate(LocalDateTime.now());
		} else {
			category.setShowHome(false);
			category.setCreatedDate(LocalDateTime.now());
		}
		category.setStatus(true);
		return categoryRepo.save(category);
	}

	public void deleteCategoryById(Integer id) {
		categoryRepo.deleteCategoryById(id);// k xóa trong db
//		categoryRepo.deleteById(id);
	}

	public void updateShowHomeById(Integer id) {
		Optional<Category> categoryInDB = categoryRepo.findById(id);
		if (categoryInDB.get().getShowHome()) {
			categoryInDB.get().setShowHome(false);
		} else {
			categoryInDB.get().setShowHome(true);
		}
		categoryRepo.save(categoryInDB.get());
	}

	public List<Category> getAllSubCategoriesById(Integer id) {
		return categoryRepo.findAllSubcategoriesById(id);
	}

	@Override
	public List<CategoryDTO> getSubCategoryWithLimitedProduct(int limit) {
		List<CategoryDTO> categoryDTOs = new ArrayList<CategoryDTO>();
		List<Category> categories = categoryRepo.getAllSubCategoryWithProduct();

		for (Category category : categories) {
			CategoryDTO categoryDTO = new CategoryDTO();
			categoryDTO.setCategory(category);
			List<Book> books = new ArrayList<Book>();
			for (int i = 0; i < category.getBooks().size(); i++) {
				if (i < limit) {
					books.add(category.getBooks().get(i));
				}
			}
			categoryDTO.setBooks(books);
			categoryDTOs.add(categoryDTO);
		}
		// tính star
		for (CategoryDTO categoryDTO : categoryDTOs) {
			for (Book book : categoryDTO.getBooks()) {
				book.setStarAvg(calculatorStar(book));
			}
		}

		return categoryDTOs;
	}

	public Integer calculatorStar(Book book) {
		Integer starAvg = 0;
		if (book.getComments().size() != 0) {
			for (Comment comment : book.getComments()) {
				starAvg += comment.getStar();
			}
			return starAvg / book.getComments().size();
		}
		return 0;
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
}
