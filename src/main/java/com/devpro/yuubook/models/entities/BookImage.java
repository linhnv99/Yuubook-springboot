package com.devpro.yuubook.models.entities;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "book_images")
public class BookImage extends BaseEntity {

	@ManyToOne(fetch = FetchType.EAGER)
	private Book book;

	@Column(name = "name")
	private String name;

	@Column(name = "path", nullable = false)
	private String path;
}
