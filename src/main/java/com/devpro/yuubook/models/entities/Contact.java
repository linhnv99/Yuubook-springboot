package com.devpro.yuubook.models.entities;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "contact")
public class Contact extends BaseEntity {
	private String name;
	private String phone;
	private String subject;
	@Column(columnDefinition = "text")
	private String content;
}
