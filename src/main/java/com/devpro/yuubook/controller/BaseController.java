package com.devpro.yuubook.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.devpro.yuubook.entities.Book;
import com.devpro.yuubook.entities.Category;
import com.devpro.yuubook.entities.User;
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
	public List<Book> getFavoriteBooksByUserLogin(){
		User user = userLogin();
		if(user != null) {
			return bookService.getBookFavoritesByUserLogin(user);
		}
		return null;
	}
	
	@ModelAttribute("userLogin")
	public User userLogin() {
		User user = null;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
			User u = (User) authentication.getPrincipal();
			user = userService.findUserByEmail(u.getEmail());
		}
		return user;
	}
}
