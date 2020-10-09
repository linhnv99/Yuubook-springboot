package com.devpro.yuubook.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.devpro.yuubook.entities.Contact;

@Repository
public interface ContactRepo extends JpaRepository<Contact, Integer> {
	
}
