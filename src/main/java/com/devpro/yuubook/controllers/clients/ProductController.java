package com.devpro.yuubook.controllers.clients;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.devpro.yuubook.utils.Constant;
import com.devpro.yuubook.models.entities.Book;
import com.devpro.yuubook.models.entities.Category;
import com.devpro.yuubook.models.entities.Comment;
import com.devpro.yuubook.services.AuthorService;
import com.devpro.yuubook.services.BookService;
import com.devpro.yuubook.services.CategoryService;

@Controller
public class ProductController extends BaseController implements Constant {
	@Autowired
	private BookService bookService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private AuthorService authorService;

	@RequestMapping(value = "/author", method = RequestMethod.GET)
	public String author(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		return "author";
	}

	@GetMapping("/product/cate/{id}")
	public String getProductsByCategory(ModelMap model, HttpServletRequest request, HttpServletResponse response,
			@PathVariable("id") int  id, @RequestParam(value = "page", defaultValue = "1") int currentPage,
			@RequestParam(value = "sort", defaultValue = "newest") String sortBy) {
		HttpSession httpSession = request.getSession();
		httpSession.setAttribute("SORT", sortBy);
		
		Category cateSelected = categoryService.getById(id);
		if (cateSelected.getParentId() != null) { // chọn danh mục con
			model.addAttribute("parentCateSelected", cateSelected.getParentId());
			httpSession.setAttribute("CATALOG_SELECTED", cateSelected);
			Page<Book> books = bookService.getAllByCategoryAndSort(cateSelected, currentPage,sortBy, LIMITED_PRODUCT_CATEGORY);
			List<Book> bookList = books.getContent();
			for (Book book : bookList) {
				book.setStarAvg(calculatorStar(book));
			}
			model.addAttribute("books", bookList);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("totalPages", books.getTotalPages());
		} else {// chọn danh mục cha
			httpSession.removeAttribute("CATALOG_SELECTED");
			model.addAttribute("parentCateSelected", cateSelected);
			model.addAttribute("subCategoriesWithProducts",
					categoryService.getSubCategoryWithLimitedProduct(LIMITED_PRODUCT_EACHCATEGORY));
		}
		model.addAttribute("author", authorService.getAll());
		return "product-list";
	}
	
	@RequestMapping(value = "/product/detail/{id}", method = RequestMethod.GET)
	public String singleProduct(ModelMap model, HttpServletRequest request, HttpServletResponse response,
			@PathVariable("id") Integer id) {
		model.addAttribute("categories", categoryService.getAllParentCategories());
		model.addAttribute("book", bookService.getById(id));
		return "single-product";
	}
	
	public Integer calculatorStar(Book book) {
		Integer starAvg = 0;
		if(book.getComments().size() != 0) {
			for (Comment comment : book.getComments()) {
				starAvg += comment.getStar();
			}
			return starAvg/book.getComments().size();
		}
		return 0;
	}
}
