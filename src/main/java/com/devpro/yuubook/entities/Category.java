package com.devpro.yuubook.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "category")
public class Category extends BaseEntity{
	@JsonIgnore
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "category", fetch = FetchType.LAZY)
	private List<Book> books = new ArrayList<Book>();

	public void addBook(Book book) {
		books.add(book);
		book.setCategory(this);
	}

	public void removeBook(Book book) {
		books.add(book);
		book.setCategory(null);
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="parent_id")
	private Category parentId;
	
	@JsonIgnore //bỏ qua trong quá trình serialize
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "parentId", fetch = FetchType.LAZY)
	private List<Category> subCategories = new ArrayList<Category>();
	
	@Column(name = "name", nullable = false)
	private String name;
	
	@Column(name = "description", nullable = true)
	private String desc;
		
	@Column(name="show_home")
	private Boolean showHome;
	
	public List<Book> getBooks() {
		return books;
	}

	public void setBooks(List<Book> books) {
		this.books = books;
	}

	public Category getParentId() {
		return parentId;
	}

	public void setParentId(Category parentId) {
		this.parentId = parentId;
	}

	public List<Category> getSubCategories() {
		return subCategories;
	}

	public void setSubCategories(List<Category> subCategories) {
		this.subCategories = subCategories;
	}

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

	public Boolean getShowHome() {
		return showHome;
	}

	public void setShowHome(Boolean showHome) {
		this.showHome = showHome;
	}
}
