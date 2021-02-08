package com.devpro.yuubook.services;

import java.util.List;

import com.devpro.yuubook.models.entities.Contact;

public interface ContactService {
	Contact save(Contact contact);

	List<Contact> getAll();

	void deleteById(Integer id);
}
