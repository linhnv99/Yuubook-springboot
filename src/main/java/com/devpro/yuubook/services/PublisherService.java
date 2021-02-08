package com.devpro.yuubook.services;

import java.util.List;
import java.util.Optional;

import com.devpro.yuubook.models.entities.Publisher;

public interface PublisherService {
	List<Publisher> getAll();

	Publisher getById(int id);

	void deleteById(int id);

	Publisher save(Publisher publisher);

}
