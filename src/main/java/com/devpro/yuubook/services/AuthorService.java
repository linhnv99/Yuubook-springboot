package com.devpro.yuubook.services;

import java.io.IOException;
import java.util.List;

import com.devpro.yuubook.models.dto.AuthorDTO;
import com.devpro.yuubook.models.entities.Author;

public interface AuthorService {
    List<Author> getAll();

    Author getById(int id);

    Author save(Author author) throws IllegalStateException, IOException;

    void delete(int id);

    void updateShowHomeByAuthorId(int id);

    List<AuthorDTO> getAuthorWithLimitedProduct(int l);

    Author getBySlug(String slug);
}
