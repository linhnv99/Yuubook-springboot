package com.devpro.yuubook.services.impl;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.devpro.yuubook.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devpro.yuubook.dto.AuthorDTO;
import com.devpro.yuubook.entities.Author;
import com.devpro.yuubook.entities.Book;
import com.devpro.yuubook.repositories.AuthorRepo;
import com.devpro.yuubook.services.AuthorService;

@Service
public class AuthorServiceImpl implements AuthorService{
	@Autowired
	private AuthorRepo authorRepo;

	public List<Author> getAllAuthors() {
		return authorRepo.findAll();
	}

	public Optional<Author> findAuthorByAuthorId(Integer authorId) {
		return authorRepo.findById(authorId);
	}

	public void deleteAuthorByAuthorId(Integer authorId) {
		authorRepo.deleteById(authorId);
	}

	public Author save(Author author) throws IllegalStateException, IOException {
		if (author.getId() != null) {// update
			Optional<Author> authorInDB = authorRepo.findById(author.getId());
			if (author.getFile().isEmpty()) {
				author.setAvatar(authorInDB.get().getAvatar());
			} else {
				saveImage(author);
			}
			author.setShowHome(authorInDB.get().getShowHome());
			author.setCreatedDate(authorInDB.get().getCreatedDate());
			author.setUpdatedDate(LocalDateTime.now());
		} else {
			author.setCreatedDate(LocalDateTime.now());
			author.setShowHome(false);// default: false; don't show home
			if (!author.getFile().isEmpty()) {
				saveImage(author);
			}
		}
		return authorRepo.save(author);
	}

	public void saveImage(Author author) throws IllegalStateException, IOException {
		String fullPath = FileUtils.SAVE_PATH + "authors/"
				+ author.getFile().getOriginalFilename();
		author.getFile().transferTo(new File(fullPath));
		author.setAvatar("authors/" + author.getFile().getOriginalFilename());
	}

	public void updateShowHomeByAuthorId(Integer id) {
		Optional<Author> authorInDB = authorRepo.findById(id);
		if (authorInDB.get().getShowHome()) {
			authorInDB.get().setShowHome(false);
		} else {
			authorInDB.get().setShowHome(true);
		}
		authorRepo.save(authorInDB.get());
	}

	@Override
	public List<AuthorDTO> getAuthorWithLimitedProduct(int limitSizeProduct) {
		
		List<AuthorDTO> authorDTOs = new ArrayList<AuthorDTO>();
		List<Author> authors = authorRepo.getAllAuthorWithProductOrderByCreateDateDesc();
		
		for(Author author : authors) {
			AuthorDTO authorDTO = new AuthorDTO();
			List<Book> books = new ArrayList<Book>();
			authorDTO.setAuthor(author);
			for (int i = 0; i < author.getBooks().size(); i++) {
				if(i < limitSizeProduct) {
					books.add(author.getBooks().get(i));
				}
			}
			authorDTO.setBooks(books);
			authorDTOs.add(authorDTO);
		}
		return authorDTOs; 
	}
}
