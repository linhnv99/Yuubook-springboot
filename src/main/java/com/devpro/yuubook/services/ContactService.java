package com.devpro.yuubook.services;

import java.util.List;

import com.devpro.yuubook.entities.Contact;

public interface ContactService {
	Contact save(Contact contact);

	List<Contact> getAllContacts();

	void deleteContactById(Integer id);
}
