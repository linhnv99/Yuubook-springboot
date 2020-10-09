package com.devpro.yuubook.repositories;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.devpro.yuubook.entities.Comment;

@Repository
@Transactional
public interface CommentRepo extends JpaRepository<Comment, Integer> {
	
	@Modifying
	@Query("delete from Comment cmt where cmt.user.id = ?1 and cmt.id = ?2")
	void deleteCommentByUserLogin(Integer id, Integer cmtId);

	@Query("select c from Comment c where c.user.id = ?1 order by c.createdDate desc")
	List<Comment> getCommentsByUserLogin(Integer id);

	@Query("select c from Comment c order by c.createdDate desc")
	List<Comment> getAllComments();
	
}
