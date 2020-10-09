package com.devpro.yuubook.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.devpro.yuubook.constant.Constant;
import com.devpro.yuubook.dto.AjaxResponse;
import com.devpro.yuubook.dto.BookDTO;
import com.devpro.yuubook.services.AuthorService;
import com.devpro.yuubook.services.BookService;
import com.devpro.yuubook.services.CategoryService;


@Controller
public class HomeController extends BaseController implements Constant{
	@Autowired
	private AuthorService authorService;
	@Autowired
	private BookService bookService;
	@Autowired
	private CategoryService categoryService;

	@GetMapping({ "/", "/home" })
	public String index(ModelMap model) throws Exception {
		model.addAttribute("authors", authorService.getAuthorWithLimitedProduct(HOME_LIMITED_PRODUCT_AUTHOR));
		model.addAttribute("bookHot", bookService.getLimitedProductsHot(HOME_LIMITED_PRODUCT_HOT));
		model.addAttribute("subCateShowHome", categoryService.getSubCategoryWithLimitedProduct(HOME_LIMITED_PRODUCT_SUBCATEGORY));
		model.addAttribute("parentCateShowHome", categoryService.getParentCategoryWithLimitedProduct(HOME_LIMITED_PRODUCT_CATEGORY));
		return "index";
	}
	
	@GetMapping("/search")
	public String searchProduct(ModelMap model, @RequestParam("q") String keyword) {
		model.addAttribute("books", bookService.searchBooksByKeyword(keyword));
		model.addAttribute("keyword", keyword);
		return "product-search";
	}
	
	@GetMapping("/search-suggest")
	public ResponseEntity<AjaxResponse> searchProductByAjax(ModelMap model, @RequestParam("q") String keyword){
		List<BookDTO> books = bookService.ajaxSearchBooksByKeyword(keyword);
		return ResponseEntity.ok(new AjaxResponse(books, 200));
	}
}
