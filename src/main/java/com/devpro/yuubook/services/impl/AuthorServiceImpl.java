package com.devpro.yuubook.services.impl;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

import com.devpro.yuubook.services.mappers.AuthorMapper;
import com.devpro.yuubook.utils.FileUtils;
import com.devpro.yuubook.utils.FuncUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devpro.yuubook.models.dto.AuthorDTO;
import com.devpro.yuubook.models.entities.Author;
import com.devpro.yuubook.repositories.AuthorRepo;
import com.devpro.yuubook.services.AuthorService;

@Service
public class AuthorServiceImpl implements AuthorService {
    @Autowired
    private AuthorRepo authorRepo;
    @Autowired
    private AuthorMapper authorMapper;

    public List<Author> getAll() {
        return authorRepo.findAll();
    }

    public Author getById(int id) {
        return authorRepo.findById(id).orElse(null);
    }

    public void delete(int id) {
        authorRepo.deleteById(id);
    }

    public Author save(Author authorIn) throws IllegalStateException, IOException {
        Author author = authorRepo.findById(authorIn.getId()).orElse(null);
        if (author != null) {
            if (authorIn.getFile().isEmpty()) {
                authorIn.setAvatar(author.getAvatar());
            }
            authorIn.setShowHome(author.getShowHome());
            authorIn.setCreatedDate(author.getCreatedDate());
            authorIn.setStatus(author.isStatus());
            authorIn.setUpdatedDate(LocalDateTime.now());
        } else {
            authorIn.setCreatedDate(LocalDateTime.now());
            authorIn.setShowHome(false);
            authorIn.setStatus(true);
        }
        if (!authorIn.getFile().isEmpty()) {
            saveImage(authorIn);
        }
        authorIn.setSlug(FuncUtils.toSlug(authorIn.getName()));
        return authorRepo.save(authorIn);
    }

    public void saveImage(Author author) throws IllegalStateException, IOException {
        String fullPath = FileUtils.SAVE_PATH + "authors/" + author.getFile().getOriginalFilename();
        author.getFile().transferTo(new File(fullPath));
        author.setAvatar("authors/" + author.getFile().getOriginalFilename());
    }

    public void updateShowHomeByAuthorId(int id) {
        Author author = authorRepo.findById(id).orElse(null);
        if (author == null) return;
        author.setShowHome(!author.getShowHome());
        authorRepo.save(author);
    }

    @Override
    public List<AuthorDTO> getAuthorWithLimitedProduct(int limit) {
        List<Author> authors = authorRepo.getAllAuthorWithProductOrderByCreateDateDesc();
        return authorMapper.toDTO(authors, limit);
    }

    @Override
    public Author getBySlug(String slug) {
        return authorRepo.findBySlug(slug);
    }
}
