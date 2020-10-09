package com.devpro.yuubook.services.impl;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devpro.yuubook.entities.Contact;
import com.devpro.yuubook.repositories.ContactRepo;
import com.devpro.yuubook.services.ContactService;
@Service
public class ContactServiceImpl implements ContactService{
	@Autowired
	private ContactRepo contactRepo;

	@Override
	public Contact save(Contact contact) {
		contact.setCreatedDate(LocalDateTime.now());
		return contactRepo.save(contact);
	}

	@Override
	public List<Contact> getAllContacts() {
		return contactRepo.findAll();
	}

	@Override
	public void deleteContactById(Integer id) {
		contactRepo.deleteById(id);
	}
		
}
