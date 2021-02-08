package com.devpro.yuubook.models.dto;

public class CommentDTO {
	private Integer id;
	private Integer bookId;
	private Integer star;
	private String title;
	private String content;
	private Integer likeComment;
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getBookId() {
		return bookId;
	}
	public void setBookId(Integer bookId) {
		this.bookId = bookId;
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
	
}
