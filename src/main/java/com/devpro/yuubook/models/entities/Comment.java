package com.devpro.yuubook.models.entities;

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
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
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
	
	private int star;
	private String title;

	@Column(columnDefinition = "text")
	private String content;

	private LocalDateTime date;
	@Column(name = "like_comment")

	private int likeComment;
}
