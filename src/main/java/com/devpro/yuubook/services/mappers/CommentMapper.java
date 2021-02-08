package com.devpro.yuubook.services.mappers;

import com.devpro.yuubook.models.dto.CommentDTO;
import com.devpro.yuubook.models.entities.Book;
import com.devpro.yuubook.models.entities.Comment;
import com.devpro.yuubook.models.entities.User;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
public class CommentMapper {
    public Comment toEntity(User userLogin, CommentDTO commentDTO, Book book) {
        Comment comment = new Comment();
        comment.setUser(userLogin);
        comment.setBook(book);
        comment.setTitle(commentDTO.getTitle());
        comment.setContent(commentDTO.getContent());
        comment.setStar(commentDTO.getStar());
        comment.setLikeComment(0);
        comment.setStatus(true);
        comment.setDate(LocalDateTime.now());
        comment.setCreatedDate(LocalDateTime.now());
        return comment;
    }
}
