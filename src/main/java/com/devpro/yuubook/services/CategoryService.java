package com.devpro.yuubook.services;

import java.util.List;
import java.util.Optional;

import com.devpro.yuubook.models.dto.CategoryDTO;
import com.devpro.yuubook.models.entities.Category;

public interface CategoryService {

	List<Category> getAllParentCategories();

	Category getById(int id);

	Category save(Category category);

	void deleteCategoryById(int id);

	void updateShowHomeById(int id);

	List<Category> getAllSubCategoriesByParentId(int id);

	List<CategoryDTO> getSubCategoryWithLimitedProduct(int limit);
	
	List<CategoryDTO> getParentCategoryWithLimitedProduct(int limit);

    Category getBySlug(String slug);
}
