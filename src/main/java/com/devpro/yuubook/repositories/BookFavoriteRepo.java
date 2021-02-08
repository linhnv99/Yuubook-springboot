package com.devpro.yuubook.repositories;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.devpro.yuubook.models.entities.BookFavorite;

@Repository
public interface BookFavoriteRepo extends JpaRepository<BookFavorite, Integer> {
	
	@Transactional
	@Modifying
	@Query(value = "delete from book_favorite where user_id = ?1 and book_id = ?2", nativeQuery = true)
	void deleteByUserAndBook(int id, int id2);
}
