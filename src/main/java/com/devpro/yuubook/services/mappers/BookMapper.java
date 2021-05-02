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
                .map(book -> {
                    BookDTO bookDTO = new BookDTO();
                    bookDTO.setId(book.getId());
                    bookDTO.setName(book.getName());
                    bookDTO.setAvatar(book.getAvatar());
                    bookDTO.setAuthorName(book.getAuthor().getName());
                    bookDTO.setStatus(book.isStatus());
                    bookDTO.setSlug(book.getSlug());
                    return bookDTO;
                }).limit(limit).collect(Collectors.toList());
    }
}
