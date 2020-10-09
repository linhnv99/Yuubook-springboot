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
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

@Entity
@Table(name = "author")
public class Author extends BaseEntity {

	@OneToMany(cascade = CascadeType.ALL, mappedBy = "author", fetch = FetchType.LAZY)
	private List<Book> books = new ArrayList<Book>();

	public void addBook(Book book) {
		books.add(book);
		book.setAuthor(this);
	}

	public void removeBook(Book book) {
		books.add(book);
		book.setAuthor(null);
	}
 
	@Column(name = "name", nullable = false)
	private String name;

	@Column(name = "show_home")
	private Boolean showHome;

	@Column(name = "avatar", nullable = false)
	private String avatar;

	@Lob
	@Column(name = "description", columnDefinition = "text")
	private String desc;

	@Transient
	private MultipartFile file;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Boolean getShowHome() {
		return showHome;
	}

	public void setShowHome(Boolean showHome) {
		this.showHome = showHome;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
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
