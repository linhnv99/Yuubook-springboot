package com.devpro.yuubook.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.devpro.yuubook.models.entities.Author;

@Repository
public interface AuthorRepo extends JpaRepository<Author, Integer> {

	@Query("select distinct a from Author a left join fetch a.books b  where a.id = b.author.id order by b.createdDate desc")
	List<Author> getAllAuthorWithProductOrderByCreateDateDesc();
}
