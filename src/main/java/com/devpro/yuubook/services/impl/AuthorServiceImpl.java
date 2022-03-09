package com.devpro.yuubook.services.impl;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

import com.devpro.yuubook.models.dto.BookDTO;
import com.devpro.yuubook.services.mappers.AuthorMapper;
import com.devpro.yuubook.utils.AuthorKafkaDTO;
import com.devpro.yuubook.utils.FileUtils;
import com.devpro.yuubook.utils.FuncUtils;
import com.devpro.yuubook.utils.KafkaUtils;
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
    @Autowired
    private KafkaUtils kafkaUtils;

    public List<Author> getAll() {
        return authorRepo.findAll();
    }

    public Author getById(int id) {
        return authorRepo.findById(id).orElse(null);
    }

    public void delete(int id) {
        Author author = authorRepo.findById(id).get();
        new Thread(() -> {
            kafkaUtils.pushKafka("author", "delete", AuthorKafkaDTO.builder()
                    .name(author.getName()).build());
        }, "Thread push kafka with action delete author").start();
        authorRepo.deleteById(id);
    }

    public Author save(Author authorIn) throws IllegalStateException, IOException {
        Author authorExist = authorRepo.findById(authorIn.getId()).orElse(null);
        if (authorExist != null) {
            if (authorIn.getFile().isEmpty()) {
                authorIn.setAvatar(authorExist.getAvatar());
            }
            authorIn.setShowHome(authorExist.getShowHome());
            authorIn.setCreatedDate(authorExist.getCreatedDate());
            authorIn.setStatus(authorExist.isStatus());
            authorIn.setUpdatedDate(LocalDateTime.now());
            if (!authorExist.getName().equals(authorIn.getName())) {
                new Thread(() -> {
                    kafkaUtils.pushKafka("author", "update", AuthorKafkaDTO.builder()
                            .prevName(authorExist.getName())
                            .nextName(authorIn.getName()).build());
                }, "Thread push kafka with action update author name").start();
            }
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
