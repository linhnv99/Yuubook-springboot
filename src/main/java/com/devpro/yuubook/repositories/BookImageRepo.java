package com.devpro.yuubook.repositories;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.devpro.yuubook.models.entities.BookImage;

public interface BookImageRepo extends JpaRepository<BookImage, Integer> {
	@Transactional
	@Modifying
	@Query("delete from BookImage b where b.book.id = ?1")
	void deleteBookImageByBookId(int id);
}
