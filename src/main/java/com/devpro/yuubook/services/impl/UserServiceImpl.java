package com.devpro.yuubook.services.impl;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.devpro.yuubook.utils.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.devpro.yuubook.models.entities.Book;
import com.devpro.yuubook.models.entities.BookFavorite;
import com.devpro.yuubook.models.entities.Role;
import com.devpro.yuubook.models.entities.User;
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
    public User getUserByEmail(String email) {
        return userRepo.getUserByEmail(email);
    }

    @Override
    public User save(User user) {
        user.setAvatar(null);
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        List<Role> roles = new ArrayList<Role>();
        roles.add(roleRepo.findRoleByName("ROLE_USER"));
        user.setRoles(roles);

        user.setStatus(true);
        user.setCreatedDate(LocalDateTime.now());
        return userRepo.save(user);
    }

    @Override
    public List<User> getAll() {
        return userRepo.findAllByStatus(true);
    }

    @Override
    public void deleteById(int id) {
        userRepo.deleteById(id);
    }

    @Override
    public User update(User userIn) throws IllegalStateException, IOException {
        User user = userRepo.findById(userIn.getId()).orElse(null);
        if (user == null) return null;
        if (userIn.getFile() != null) {
            saveImage(userIn);
        }
        if (!userIn.getPassword().trim().isEmpty()) {
            userIn.setPassword(passwordEncoder.encode(userIn.getPassword()));
        }else {
            userIn.setPassword(user.getPassword());
        }
//        userIn.setAvatar(user.getAvatar());
        userIn.setRoles(user.getRoles());
        userIn.setStatus(true);
        userIn.setCreatedDate(user.getCreatedDate());
        userIn.setUpdatedDate(LocalDateTime.now());
        return userRepo.save(userIn);
    }

    public void saveImage(User user) throws IllegalStateException, IOException {
        String fullPath = FileUtils.SAVE_PATH + "users/"
                + user.getFile().getOriginalFilename();
        user.getFile().transferTo(new File(fullPath));
        user.setAvatar("users/" + user.getFile().getOriginalFilename());
    }

    @Override
    public int getTotalNumberOfUsers() {
        return userRepo.getTotalNumberOfUsers();
    }

    @Override
    public void addFavoriteBookByUserLogin(User userLogin, int id) {
        Book book = bookService.getById(id);
        BookFavorite bookFavorite = new BookFavorite();
        bookFavorite.setBook(book);
        bookFavorite.setUser(userLogin);
        bookFavoriteRepo.save(bookFavorite);
    }

    @Override
    public void removeFavoriteBookByUserLogin(User userLogin, int id) {
        bookFavoriteRepo.deleteByUserAndBook(userLogin.getId(), id);
    }
}
