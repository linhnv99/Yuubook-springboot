package com.devpro.yuubook.services;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import com.devpro.yuubook.dto.AuthorDTO;
import com.devpro.yuubook.entities.Author;

public interface AuthorService {
	List<Author> getAllAuthors();

	Optional<Author> findAuthorByAuthorId(Integer authorId);
	
	Author save(Author author) throws IllegalStateException, IOException;
	
	void deleteAuthorByAuthorId(Integer authorId);

	void updateShowHomeByAuthorId(Integer id);

	List<AuthorDTO> getAuthorWithLimitedProduct(int limitSizeProduct);
}
