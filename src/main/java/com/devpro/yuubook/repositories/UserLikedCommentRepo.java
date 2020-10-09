package com.devpro.yuubook.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.devpro.yuubook.entities.UserLikedComment;

@Repository
public interface UserLikedCommentRepo extends JpaRepository<UserLikedComment, Integer>{

	@Query(value = "delete from user_liked_comment where user_id = ?1 and comment_id = ?2", nativeQuery = true)
	void deleteUserLikedByUserIdAndCommentId(Integer id, Integer cmtId);

	@Query("select u from UserLikedComment u where u.user_id = ?1 and u.comment.id = ?2")
	UserLikedComment findUserLikedByUserIdAndCommentId(Integer id, Integer cmtId);
	
}
