package com.devpro.yuubook.services.mappers;

import com.devpro.yuubook.models.dto.AuthorDTO;
import com.devpro.yuubook.models.entities.Author;
import com.devpro.yuubook.models.entities.Book;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class AuthorMapper {
    public List<AuthorDTO> toDTO(List<Author> authors, int limit) {
        return authors.stream()
                .map(author -> {
                    AuthorDTO authorDTO = new AuthorDTO();
                    List<Book> books = author.getBooks().stream().limit(limit).collect(Collectors.toList());
                    authorDTO.setBooks(books);
                    authorDTO.setAuthor(author);
                    return authorDTO;
                }).collect(Collectors.toList());
    }
}
