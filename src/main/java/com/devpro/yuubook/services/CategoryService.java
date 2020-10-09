package com.devpro.yuubook.services;

import java.util.List;
import java.util.Optional;

import com.devpro.yuubook.dto.CategoryDTO;
import com.devpro.yuubook.entities.Category;

public interface CategoryService {

	List<Category> getAllParentCategories();

	Optional<Category> findCategoryBy(Integer id);

	Category save(Category category);

	void deleteCategoryById(Integer id);

	void updateShowHomeById(Integer id);

	List<Category> getAllSubCategoriesById(Integer id);

	List<CategoryDTO> getSubCategoryWithLimitedProduct(int limit);
	
	List<CategoryDTO> getParentCategoryWithLimitedProduct(int limit);
}
