package com.devpro.yuubook.repositories;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.devpro.yuubook.models.entities.Book;

public interface BookRepo extends JpaRepository<Book, Integer> {
	@Query(value = "select * from book where status = 1 order by created_date desc", nativeQuery = true)
	List<Book> getAll();

	@Query(value = "select * from book where status = 0 order by created_date desc", nativeQuery = true)
	List<Book> getAllDeleted();

	@Transactional
	@Modifying
	@Query("Update Book b set b.status = ?2 where b.id = ?1 ")
	void deleteOrRestoreBookById(int id, boolean b);

	@Query(value = "select * from book where hot = 1 and status = 1 order by created_date desc limit ?1", nativeQuery = true)
	List<Book> getLimitedProductsHot(int limit);

	@Query(value = "select * from book where category_id = ?1 and status = 1", nativeQuery = true)
	Page<Book> getAllByCategory(int id, Pageable pageable);

	@Query(value = "select * from book where author_id = ?1 and status = 1", nativeQuery = true)
	Page<Book> getAllByAuthor(int id, Pageable pageable);

	@Query(value = "select count(*) from book where status = ?1", nativeQuery = true)
	Integer getTotalNumberOfProducts(boolean b);

	@Query("select b from Book b inner join Author a on b.author.id = a.id"
			+ " where concat(b.name, ' ', a.name, ' ') like %?1% and b.status = true")
	List<Book> getAllBookByKeyword(String keyword);

	@Query(value = "select * from book where hot = 1 and status = 1", nativeQuery = true)
	Page<Book> getAllByHot(Pageable pageable);

	@Query(value = "select * from book where status = 1 and DATE(created_date) = ?1", nativeQuery = true)
	List<Book> findByCreateDate(LocalDate today);

    Book findBySlug(String slug);
}
