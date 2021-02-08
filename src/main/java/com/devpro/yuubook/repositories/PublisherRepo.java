package com.devpro.yuubook.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.devpro.yuubook.models.entities.Publisher;

@Repository
public interface PublisherRepo extends JpaRepository<Publisher, Integer> {
	
}
