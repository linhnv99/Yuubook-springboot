package com.devpro.yuubook.services;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;

import com.devpro.yuubook.entities.Book;
import com.devpro.yuubook.entities.Category;

@Service
public class Template {
	@PersistenceContext 
	protected EntityManager entityManager;// thực thi sql == prepareStatement

	@SuppressWarnings("unchecked")
	public List<Category> findSubCategories(Integer parentId) {
		 String jpql = "From Category c Where c.parentId.id =" + parentId;
//		String sql = "select * from category where parent_id=" + parentId;
		Query query = entityManager.createQuery(jpql, Category.class);
//		Query query = entityManager.createNativeQuery(sql, Category.class);
		return query.getResultList();
	}
	
	public List<Category>  getAllCategoryWithProducts() {
		try {
			List<Category> categories = entityManager
					.createQuery(
					    "select distinct c " +
					    "from Category c " +
					    "inner join fetch c.books b "
					    + "order by c.id asc, b.id desc"
					    , Category.class)
					.getResultList();
			for(Category category : categories) {
				System.out.println("Category: "+ category.getName());
				for (Book b : category.getBooks()) {
					System.out.println("==> "+ b.getId());
				}
			}
			return categories;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public List<Category> getListCategory(){
		
		List<Category> list = entityManager
				.createQuery(
						"select distinct c "
						+ "from Category c inner join "
						+ "fetch c.books b",Category.class)
				.getResultList();
		list = entityManager
				.createQuery(
						"select distinct c "
						+ "from Category c left join"
						+ " fetch c.subCategories sub ", Category.class)
				.setParameter("cate", list)
				.getResultList();
		return list;
	}
}
