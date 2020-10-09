package com.devpro.yuubook.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;

@Entity
@Table(name = "contact")
public class Contact extends BaseEntity {
	@Column(name = "name", nullable = false)
	private String name;

	@Column(name = "phone", nullable = false)
	private String phone;

	@Column(name = "subject", nullable = false)
	private String subject;

	@Lob
	@Column(name = "content", nullable = false, columnDefinition = "text")
	private String content;

	public Contact() {
	}

	public Contact(String name, String phone, String subject, String content) {
		super();
		this.name = name;
		this.phone = phone;
		this.subject = subject;
		this.content = content;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}
