package com.devpro.yuubook.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "comments")
public class Comment extends BaseEntity {
	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	private Book book;
	
	@JsonIgnore
	@ManyToOne(fetch = FetchType.EAGER)
	private User user;
	
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "comment")
	private List<UserLikedComment> userLikedComments = new ArrayList<UserLikedComment>();
	
	@Column(name = "star")
	private Integer star;

	@Column(name = "title")
	private String title;

	@Lob
	@Column(name = "content", columnDefinition = "text", nullable = false)
	private String content;

	@Column(name = "date", nullable = false)
	private LocalDateTime date;

	@Column(name = "like_comment")
	private Integer likeComment;

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public LocalDateTime getDate() {
		return date;
	}

	public void setDate(LocalDateTime date) {
		this.date = date;
	}

	public Integer getStar() {
		return star;
	}

	public void setStar(Integer star) {
		this.star = star;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getLikeComment() {
		return likeComment;
	}

	public void setLikeComment(Integer likeComment) {
		this.likeComment = likeComment;
	}

	public List<UserLikedComment> getUserLikedComments() {
		return userLikedComments;
	}

	public void setUserLikedComments(List<UserLikedComment> userLikedComments) {
		this.userLikedComments = userLikedComments;
	}


}
