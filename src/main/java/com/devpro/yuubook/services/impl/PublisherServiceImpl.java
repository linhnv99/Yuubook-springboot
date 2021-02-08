package com.devpro.yuubook.services.impl;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devpro.yuubook.models.entities.Publisher;
import com.devpro.yuubook.repositories.PublisherRepo;
import com.devpro.yuubook.services.PublisherService;

@Service
public class PublisherServiceImpl implements PublisherService {
    @Autowired
    PublisherRepo publisherRepo;

    public List<Publisher> getAll() {
        return publisherRepo.findAll();
    }

    public Publisher getById(int id) {
        return publisherRepo.findById(id).orElse(null);
    }

    public void deleteById(int id) {
        publisherRepo.deleteById(id);
    }

    public Publisher save(Publisher publisherIn) {
        Publisher publisher = publisherRepo.findById(publisherIn.getId()).orElse(null);
        if (publisher != null) {
            publisherIn.setStatus(publisher.isStatus());
            publisherIn.setUpdatedDate(LocalDateTime.now());
            publisherIn.setCreatedDate(publisher.getCreatedDate());
        } else {
            publisherIn.setStatus(true);
            publisherIn.setCreatedDate(LocalDateTime.now());
        }
        return publisherRepo.save(publisherIn);
    }

}
