package com.devpro.yuubook.controllers.clients;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.devpro.yuubook.utils.FuncUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.devpro.yuubook.utils.Constant;
import com.devpro.yuubook.models.entities.Author;
import com.devpro.yuubook.models.entities.Book;
import com.devpro.yuubook.models.entities.Comment;
import com.devpro.yuubook.services.AuthorService;
import com.devpro.yuubook.services.BookService;

@Controller
@RequestMapping("/tac-gia")
public class AuthorController extends BaseController {
    @Autowired
    private AuthorService authorService;

    @Autowired
    private BookService bookService;

    @GetMapping("/{slug}")
    public String index(ModelMap model, @PathVariable("slug") String slug,
                        @RequestParam(value = "page", defaultValue = "1") Integer currentPage,
                        @RequestParam(value = "sort", defaultValue = "newest") String sortBy, HttpServletRequest request) {
        HttpSession httpSession = request.getSession();
        httpSession.setAttribute("SORT", sortBy);
        Author author = authorService.getBySlug(slug);

        Page<Book> books = bookService.getAllByAuthorAndSort(author, currentPage, sortBy, Constant.LIMITED_PRODUCT_AUTHOR);

        List<Book> bookList = books.getContent();
        for (Book book : bookList)
            FuncUtils.calculatorStar(book);

        model.addAttribute("books", books.getContent());
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", books.getTotalPages());
        model.addAttribute("authorSelected", author);
        model.addAttribute("authors", authorService.getAll());
        return "author";
    }
}
