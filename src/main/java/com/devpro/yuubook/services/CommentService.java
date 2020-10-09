package com.devpro.yuubook.services;

import java.util.List;

import com.devpro.yuubook.dto.CommentDTO;
import com.devpro.yuubook.entities.Comment;
import com.devpro.yuubook.entities.User;

public interface CommentService {

	void saveCommentByUserLogin(User userLogin, CommentDTO commentDTO);

	void deleteCommentByUserLogin(User userLogin, Integer cmtId);

	Comment likeComment(User userLogin, Integer cmtId);

	Comment dislikeComment(User userLogin, Integer cmtId);

	List<Comment> getCommentsByUserLogin(User userLogin);

	List<Comment> getAllComments();

	void deleteCommentByid(Integer id);

}
