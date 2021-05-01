package com.devpro.yuubook.controllers.clients;

import java.util.List;

import com.devpro.yuubook.models.bo.Oauth2UserDetail;
import com.devpro.yuubook.services.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.devpro.yuubook.models.entities.Book;
import com.devpro.yuubook.models.entities.Category;
import com.devpro.yuubook.models.entities.User;
import com.devpro.yuubook.services.BookService;
import com.devpro.yuubook.services.CategoryService;
import com.devpro.yuubook.services.UserService;

@Controller
public abstract class BaseController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private UserService userService;

    @Autowired
    private BookService bookService;

    @ModelAttribute("categories")
    public List<Category> getCategories() {
        return categoryService.getAllParentCategories();
    }

    @ModelAttribute("bookFavorites")
    public List<Book> getFavoriteBooksByUserLogin() {
        User user = userLogin();
        if (user != null) {
            return bookService.getBookFavoritesByUserLogin(user);
        }
        return null;
    }

    @ModelAttribute("userLogin")
    public User userLogin() {
        User user = null;
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication instanceof AnonymousAuthenticationToken) return null;

        if (authentication instanceof UsernamePasswordAuthenticationToken) {
            User u = (User) authentication.getPrincipal();
            user = userService.getUserByEmail(u.getEmail());
        }

        if (authentication instanceof OAuth2AuthenticationToken) {
            Oauth2UserDetail oauth2UserDetail = (Oauth2UserDetail) authentication.getPrincipal();
            user = userService.getUserByEmail(oauth2UserDetail.getEmail());
        }
        return user;
    }
    
}
