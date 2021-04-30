package com.devpro.yuubook.services;

import java.io.IOException;
import java.util.List;

import com.devpro.yuubook.models.entities.User;
import org.springframework.web.multipart.MultipartFile;

public interface UserService {
	
	User getUserByEmail(String email);

	User save(User user);
	
	List<User> getAll();

	void deleteById(int id);

	User update(User user) throws IllegalStateException, IOException;

	int getTotalNumberOfUsers();

	void addFavoriteBookByUserLogin(User userLogin, int id);

	void removeFavoriteBookByUserLogin(User userLogin, int id);

    User updateAvatar(MultipartFile file, User userLogin) throws IOException;
}
