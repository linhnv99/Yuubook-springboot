package com.devpro.yuubook.services.mappers;

import com.devpro.yuubook.models.dto.BookDTO;
import com.devpro.yuubook.models.entities.Book;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class BookMapper {
    public List<BookDTO> toDTO(List<Book> books, int limit) {
        return books.stream()
                .map(book -> BookDTO.builder()
                        .id(book.getId())
                        .name(book.getName())
                        .avatar(book.getAvatar())
                        .authorName(book.getAuthor().getName())
                        .status(book.isStatus())
                        .slug(book.getSlug())
                        .build()).limit(limit).collect(Collectors.toList());
    }
}
