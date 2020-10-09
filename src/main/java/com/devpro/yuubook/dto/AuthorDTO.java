package com.devpro.yuubook.dto;

import java.util.List;

import com.devpro.yuubook.entities.Author;
import com.devpro.yuubook.entities.Book;

public class AuthorDTO {
	private Author author;
	private List<Book> books;

	public AuthorDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AuthorDTO(Author author, List<Book> books) {
		super();
		this.author = author;
		this.books = books;
	}

	public Author getAuthor() {
		return author;
	}

	public void setAuthor(Author author) {
		this.author = author;
	}

	public List<Book> getBooks() {
		return books;
	}

	public void setBooks(List<Book> books) {
		this.books = books;
	}

}
