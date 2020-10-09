package com.devpro.yuubook.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="publisher")
public class Publisher extends BaseEntity{
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "category", fetch = FetchType.LAZY)
	private List<Book> books = new ArrayList<Book>();
	
	public void addBook(Book book) {
		books.add(book);
		book.setPublisher(this);;
	}
	
	public void removeBook(Book book) {
		books.add(book);
		book.setPublisher(null);
	}
	
	@Column(name="name", nullable = false)
	private String name;
	
	@Lob
	@Column(name="description", columnDefinition = "text")
	private String desc;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public List<Book> getBooks() {
		return books;
	}

	public void setBooks(List<Book> books) {
		this.books = books;
	}
}
