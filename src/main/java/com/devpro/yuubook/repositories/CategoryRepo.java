package com.devpro.yuubook.repositories;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.devpro.yuubook.entities.Category;

@Repository
public interface CategoryRepo extends JpaRepository<Category, Integer> {

	@Query("From Category c where c.parentId.id is null")
	List<Category> findAllParentCategories();

	@Query("From Category c where c.parentId.id = ?1")
	List<Category> findAllSubcategoriesById(Integer id);

	@Transactional
	@Modifying
	@Query("Update Category c set c.status = false where c.id = ?1") // false là xóa
	void deleteCategoryById(Integer id);

	@Query("select distinct c from Category c left join fetch c.books b where c.id = b.category.id "
			+ "order by c.createdDate asc, b.createdDate desc")
	List<Category> getAllSubCategoryWithProduct();

}
