package com.devpro.yuubook.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "book_images")
public class BookImage extends BaseEntity {

	@ManyToOne(fetch = FetchType.EAGER)
	private Book book;

	@Column(name = "name")
	private String name;

	@Column(name = "path", nullable = false)
	private String path;

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

}
