package com.devpro.yuubook.services.impl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.devpro.yuubook.models.entities.Book;
import com.devpro.yuubook.services.mappers.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devpro.yuubook.models.dto.CommentDTO;
import com.devpro.yuubook.models.entities.Comment;
import com.devpro.yuubook.models.entities.User;
import com.devpro.yuubook.models.entities.UserLikedComment;
import com.devpro.yuubook.repositories.BookRepo;
import com.devpro.yuubook.repositories.CommentRepo;
import com.devpro.yuubook.repositories.UserLikedCommentRepo;
import com.devpro.yuubook.services.CommentService;

@Service
public class CommentServiceimpl implements CommentService {
	@Autowired
	private CommentRepo commentRepo;
	@Autowired
	private BookRepo bookRepo;
	@Autowired
	private UserLikedCommentRepo userLikedCommentRepo;

	@Autowired
	private CommentMapper commentMapper;

	@Override
	public void saveCommentByUserLogin(User userLogin, CommentDTO commentDTO) {
		Book book = bookRepo.findById(commentDTO.getBookId()).orElse(null);
		Comment comment = commentMapper.toEntity(userLogin, commentDTO, book);
		commentRepo.save(comment);
	}

	@Override
	public void deleteCommentByUserLogin(User userLogin, int cmtId) {
		commentRepo.deleteCommentByUserLogin(userLogin.getId(), cmtId);
	}

	@Override
	public Comment likeComment(User userLogin, int cmtId) {
		Comment comment = commentRepo.findById(cmtId).orElse(null);
		if (userLogin != null && comment != null) {
			comment.setLikeComment(comment.getLikeComment() + 1);
			List<UserLikedComment> userLikedComments = new ArrayList<>();

			UserLikedComment userLikedComment = new UserLikedComment();
			userLikedComment.setUserId(userLogin.getId());
			userLikedComment.setComment(comment);
			userLikedComments.add(userLikedComment);
			comment.setUserLikedComments(userLikedComments);
			return commentRepo.save(comment);
		}
		return comment;
	}

	@Override
	public Comment dislikeComment(User userLogin, int cmtId) {
		Comment comment = commentRepo.findById(cmtId).orElse(null);
		if (userLogin != null && comment != null) {
			comment.setLikeComment(comment.getLikeComment() - 1);
			
			UserLikedComment userLikedComment = userLikedCommentRepo.findUserLikedByUserIdAndCommentId(userLogin.getId(), cmtId);
			userLikedCommentRepo.deleteById(userLikedComment.getId());
			return commentRepo.save(comment);
		}
		return comment;
	}

	@Override
	public List<Comment> getCommentsByUserLogin(User userLogin) {
		return commentRepo.getCommentsByUserLogin(userLogin.getId());
	}

	@Override
	public List<Comment> getAll() {
		return commentRepo.getAll();
	}

	@Override
	public void deleteById(int id) {
		commentRepo.deleteById(id);
	}
}
