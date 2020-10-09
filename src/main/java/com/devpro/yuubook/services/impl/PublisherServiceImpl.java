package com.devpro.yuubook.services.impl;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devpro.yuubook.entities.Publisher;
import com.devpro.yuubook.repositories.PublisherRepo;
import com.devpro.yuubook.services.PublisherService;
@Service
public class PublisherServiceImpl implements PublisherService{
	@Autowired PublisherRepo publiserRepo;

	public List<Publisher> getAllPublishers() {
		return publiserRepo.findAll();
	}

	public Optional<Publisher> findBublisherByPublisherId(Integer id) {
		return publiserRepo.findById(id);
	}

	public void deletePublisherByPublisherId(Integer id) {
		publiserRepo.deleteById(id);
	}

	public Publisher save(Publisher publisher) {
		if(publisher.getId()!=null) {
			Optional<Publisher> publisherInDB = publiserRepo.findById(publisher.getId());
			publisher.setUpdatedDate(LocalDateTime.now());
			publisher.setCreatedDate(publisherInDB.get().getCreatedDate());
		}else {
			publisher.setCreatedDate(LocalDateTime.now());
		}
		return publiserRepo.save(publisher);
	}
	
}
