package com.devpro.yuubook.controllers.clients;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.devpro.yuubook.utils.Constant;
import com.devpro.yuubook.models.entities.Author;
import com.devpro.yuubook.models.entities.Book;
import com.devpro.yuubook.models.entities.Comment;
import com.devpro.yuubook.services.AuthorService;
import com.devpro.yuubook.services.BookService;

@Controller
public class AuthorController extends BaseController implements Constant {
	@Autowired
	private AuthorService authorService;

	@Autowired
	private BookService bookService;

	@GetMapping("/author/{id}")
	public String index(ModelMap model, @PathVariable("id") Integer id,
			@RequestParam(value = "page", defaultValue = "1") Integer currentPage,
			@RequestParam(value = "sort", defaultValue = "newest") String sortBy, HttpServletRequest request) {
		HttpSession httpSession = request.getSession();
		httpSession.setAttribute("SORT", sortBy);
		Author author = authorService.getById(id);
		Page<Book> books = bookService.getAllByAuthorAndSort(author, currentPage, sortBy, LIMITED_PRODUCT_AUTHOR);
		
		List<Book> bookList = books.getContent();
		for (Book book : bookList) {
			book.setStarAvg(calculatorStar(book));
		}
		model.addAttribute("books", books.getContent());
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPages", books.getTotalPages());
		model.addAttribute("authorSelected", author);
		model.addAttribute("authors", authorService.getAll());
		return "author";
	}

	public Integer calculatorStar(Book book) {
		Integer starAvg = 0;
		if (book.getComments().size() != 0) {
			for (Comment comment : book.getComments()) {
				starAvg += comment.getStar();
			}
			return starAvg / book.getComments().size();
		}
		return 0;
	}
}
