package com.devpro.yuubook.models.dto;

import java.util.List;

import com.devpro.yuubook.models.entities.Book;
import com.devpro.yuubook.models.entities.Category;

public class CategoryDTO {
	private Category category;
	private List<Book> books;
	
	public CategoryDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CategoryDTO(Category category, List<Book> books) {
		super();
		this.category = category;
		this.books = books;
	}
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	public List<Book> getBooks() {
		return books;
	}
	public void setBooks(List<Book> books) {
		this.books = books;
	}
}
