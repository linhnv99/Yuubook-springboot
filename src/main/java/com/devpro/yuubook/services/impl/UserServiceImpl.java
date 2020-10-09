package com.devpro.yuubook.services.impl;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.devpro.yuubook.entities.Book;
import com.devpro.yuubook.entities.BookFavorite;
import com.devpro.yuubook.entities.Role;
import com.devpro.yuubook.entities.User;
import com.devpro.yuubook.repositories.BookFavoriteRepo;
import com.devpro.yuubook.repositories.RoleRepo;
import com.devpro.yuubook.repositories.UserRepo;
import com.devpro.yuubook.services.BookService;
import com.devpro.yuubook.services.UserService;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserRepo userRepo;
	@Autowired
	private RoleRepo roleRepo;
	@Autowired
	private PasswordEncoder passwordEncoder;
	@Autowired
	private BookService bookService;
	@Autowired
	private BookFavoriteRepo bookFavoriteRepo;
	
	@Override
	public User findUserByEmail(String email) {
		return userRepo.findUserByEmail(email);
	}

	@Override
	public User save(User user) {
		user.setAvatar(null);
		user.setPassword(passwordEncoder.encode(user.getPassword()));

		List<Role> roles = new ArrayList<Role>();
		roles.add(roleRepo.findRoleByName("ROLE_USER"));
		user.setRoles(roles);

		user.setCreatedDate(LocalDateTime.now());
		return userRepo.save(user);
	}

	@Override
	public List<User> getAllUsers() {
		return userRepo.findAll();
	}

	@Override
	public void deleteUserById(Integer id) {
		userRepo.deleteUserById(id);;
	}

	@Override
	public User update(User user) throws IllegalStateException, IOException {
		User userInDB = userRepo.findById(user.getId()).get();
		if(user.getFile()!=null) {
			saveImage(user);
		}else {
			user.setAvatar(userInDB.getAvatar());
		}
		if(user.getPassword().trim().isEmpty()) {
			user.setPassword(userInDB.getPassword());
		}else {
			user.setPassword(passwordEncoder.encode(user.getPassword()));
		}
//		user.setEmail(userInDB.getEmail());
		user.setRoles(userInDB.getRoles());
		
		user.setCreatedDate(userInDB.getCreatedDate());
		user.setUpdatedDate(LocalDateTime.now());
		return userRepo.save(user);
	}
	public void saveImage(User user) throws IllegalStateException, IOException {
		String fullPath = "F:\\JavaDev\\Lesson\\Phan3_Backend\\yuubook\\upload\\users\\"
				+ user.getFile().getOriginalFilename();
		user.getFile().transferTo(new File(fullPath));
		user.setAvatar("users/" + user.getFile().getOriginalFilename());
	}

	@Override
	public Integer getTotalNumberOfUsers() {
		return userRepo.getTotalNumberOfUsers();
	}

	@Override
	public void addFavoritedBookByUserLogin(User userLogin, Integer id) {
		Book book = bookService.findBookById(id);
		BookFavorite bookFavorite = new BookFavorite();
		bookFavorite.setBook(book);
		bookFavorite.setUser(userLogin);
		bookFavoriteRepo.save(bookFavorite);
	}

	@Override
	public void removeFavoritedBookByUserLogin(User userLogin, Integer id) {
		bookFavoriteRepo.deleteByUserAndBook(userLogin.getId(), id); 
	}
}
