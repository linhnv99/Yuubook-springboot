package com.devpro.yuubook.services.impl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devpro.yuubook.dto.CommentDTO;
import com.devpro.yuubook.entities.Comment;
import com.devpro.yuubook.entities.User;
import com.devpro.yuubook.entities.UserLikedComment;
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

	@Override
	public void saveCommentByUserLogin(User userLogin, CommentDTO commentDTO) {
		Comment comment = new Comment();
		comment.setUser(userLogin);
		comment.setBook(bookRepo.findById(commentDTO.getBookId()).get());
		comment.setTitle(commentDTO.getTitle());
		comment.setContent(commentDTO.getContent());
		comment.setStar(commentDTO.getStar());
		comment.setLikeComment(0);
		comment.setDate(LocalDateTime.now());
		comment.setCreatedDate(LocalDateTime.now());
		commentRepo.save(comment);
	}

	@Override
	public void deleteCommentByUserLogin(User userLogin, Integer cmtId) {
		commentRepo.deleteCommentByUserLogin(userLogin.getId(), cmtId);
	}

	@Override
	public Comment likeComment(User userLogin, Integer cmtId) {
		Comment commentInDB = commentRepo.findById(cmtId).get();
		if (userLogin != null && commentInDB.getId() != null) {
			commentInDB.setLikeComment(commentInDB.getLikeComment() + 1);
			List<UserLikedComment> userLikedComments = new ArrayList<UserLikedComment>();

			UserLikedComment userLikedComment = new UserLikedComment();
			userLikedComment.setUser_id(userLogin.getId());
			userLikedComment.setComment(commentInDB);
			userLikedComments.add(userLikedComment);

			commentInDB.setUserLikedComments(userLikedComments);
			commentRepo.save(commentInDB);
		}
		return commentInDB;
	}

	@Override
	public Comment dislikeComment(User userLogin, Integer cmtId) {
		Comment commentInDB = commentRepo.findById(cmtId).get();
		if (userLogin != null && commentInDB.getId() != null) {
			commentInDB.setLikeComment(commentInDB.getLikeComment() - 1);
			
			UserLikedComment userLikedComment = userLikedCommentRepo.findUserLikedByUserIdAndCommentId(userLogin.getId(), cmtId);
			userLikedCommentRepo.deleteById(userLikedComment.getId());
			commentRepo.save(commentInDB);
		}
		return commentInDB;
	}

	@Override
	public List<Comment> getCommentsByUserLogin(User userLogin) {
		return commentRepo.getCommentsByUserLogin(userLogin.getId());
	}

	@Override
	public List<Comment> getAllComments() {
		return commentRepo.getAllComments();
	}

	@Override
	public void deleteCommentByid(Integer id) {
		commentRepo.deleteById(id);
	}
}
