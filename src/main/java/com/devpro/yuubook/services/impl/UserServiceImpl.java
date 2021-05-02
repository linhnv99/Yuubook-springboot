package com.devpro.yuubook.services.impl;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.devpro.yuubook.models.bo.Provider;
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
import org.springframework.web.multipart.MultipartFile;

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
        return userRepo.findByEmail(email);
    }

    @Override
    public User save(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        List<Role> roles = new ArrayList<>();
        roles.add(roleRepo.findRoleByName("ROLE_USER"));
        user.setRoles(roles);

        user.setProvider(Provider.SYSTEM.name());
        user.setStatus(true);
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

        if (!userIn.getName().trim().isEmpty())
            user.setName(userIn.getName());
        if (!userIn.getSurname().trim().isEmpty())
            user.setSurname(userIn.getSurname());
        if (!userIn.getPhone().trim().isEmpty())
            user.setPhone(userIn.getPhone());
        if (!userIn.getPassword().trim().isEmpty())
            user.setPassword(passwordEncoder.encode(userIn.getPassword()));
        if (userIn.getFile() != null)
            saveImage(user, userIn.getFile());

        return userRepo.save(user);
    }

    public void saveImage(User user, MultipartFile file) throws IllegalStateException, IOException {
        String fullPath = FileUtils.SAVE_PATH + "users/"
                + file.getOriginalFilename();
        file.transferTo(new File(fullPath));
        user.setAvatar("http://yuubook.com.vn/files/users/" + file.getOriginalFilename());
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

    @Override
    public User updateAvatar(MultipartFile file, User userLogin) throws IOException {
        if (file.isEmpty()) return null;

        User user = userRepo.findById(userLogin.getId()).orElse(null);
        if (user == null) return null;

        saveImage(user, file);

        return userRepo.save(user);
    }
}
