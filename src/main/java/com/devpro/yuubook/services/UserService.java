package com.devpro.yuubook.services;

import java.io.IOException;
import java.util.List;

import com.devpro.yuubook.entities.User;

public interface UserService {
	
	User findUserByEmail(String email);

	User save(User user);
	
	List<User> getAllUsers();

	void deleteUserById(Integer id);

	User update(User user) throws IllegalStateException, IOException;

	Integer getTotalNumberOfUsers();

	void addFavoritedBookByUserLogin(User userLogin, Integer id);

	void removeFavoritedBookByUserLogin(User userLogin, Integer id);

}
