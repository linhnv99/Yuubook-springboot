package com.devpro.yuubook.models.entities;

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
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "category")
public class Category extends BaseEntity{
	@JsonIgnore
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "category", fetch = FetchType.LAZY)
	private List<Book> books = new ArrayList<Book>();

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name="parent_id")
	private Category parentId;
	
	@JsonIgnore
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "parentId", fetch = FetchType.LAZY)
	private List<Category> subCategories = new ArrayList<Category>();
	
	private String name;

	@Column(name = "description", nullable = true)
	private String desc;

	@Column(name = "show_home")
	private boolean showHome;

	private String slug;
}
