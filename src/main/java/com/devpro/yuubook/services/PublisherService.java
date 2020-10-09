package com.devpro.yuubook.services;

import java.util.List;
import java.util.Optional;

import com.devpro.yuubook.entities.Publisher;

public interface PublisherService {
	List<Publisher> getAllPublishers();

	Optional<Publisher> findBublisherByPublisherId(Integer id);

	void deletePublisherByPublisherId(Integer id);

	Publisher save(Publisher publisher);

}
