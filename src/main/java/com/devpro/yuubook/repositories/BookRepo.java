package com.devpro.yuubook.repositories;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.devpro.yuubook.entities.Book;

public interface BookRepo extends JpaRepository<Book, Integer> {
	@Query(value = "select * from book where status = 1 order by created_date desc", nativeQuery = true)
	List<Book> getAllBooks();

	@Query(value = "select * from book where status = 0 order by created_date desc", nativeQuery = true)
	List<Book> getAllBooksDeleted();

	@Transactional
	@Modifying
	@Query("Update Book b set b.status = ?2 where b.id = ?1 ")
	void deleteOrRestoreBookById(Integer id, boolean b);

	@Query(value = "select * from book where hot = 1 and status = 1 order by created_date desc limit ?1", nativeQuery = true)
	List<Book> getLimitedProductsHot(int limit);

	@Query(value = "select * from book where category_id = ?1 and status = 1", nativeQuery = true)
	Page<Book> getAllBooksByCategory(Integer id, Pageable pageable);

	@Query(value = "select * from book where author_id = ?1 and status = 1", nativeQuery = true)
	Page<Book> getAllBooksByAuthor(Integer id, Pageable pageable);

	@Query(value = "select count(*) from book where status = ?1", nativeQuery = true)
	Integer getTotalNumberOfProducts(boolean b);

	@Query("select b from Book b inner join Author a on b.author.id = a.id"
			+ " where concat(b.name, ' ', a.name, ' ') like %?1% and b.status = 1")
	List<Book> getAllBookByKeyword(String keyword);

}
