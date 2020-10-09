package com.devpro.yuubook.controller.admin;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.devpro.yuubook.entities.Book;
import com.devpro.yuubook.entities.Category;
import com.devpro.yuubook.services.AuthorService;
import com.devpro.yuubook.services.BookService;
import com.devpro.yuubook.services.CategoryService;
import com.devpro.yuubook.services.PublisherService;

@Controller
@RequestMapping(value = "admin")
public class AdminProductController {
	@Autowired
	private BookService bookService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private AuthorService authorService;
	@Autowired
	private PublisherService publisherService;

	@GetMapping("/product")
	public String index(ModelMap model) {
		model.addAttribute("books", bookService.getAllBooks());
		return "admin/product/product";
	}

	@GetMapping("/product/add")
	public String add(ModelMap model) {
		model.addAttribute("isAdd", true);
		model.addAttribute("book", new Book());
		model.addAttribute("parentCategories", categoryService.getAllParentCategories());
		model.addAttribute("authors", authorService.getAllAuthors());
		model.addAttribute("publishers", publisherService.getAllPublishers());
		return "admin/product/save-product";
	}

	@GetMapping("/product/edit")
	public String edit(ModelMap model, @RequestParam("id") Integer id) {
		model.addAttribute("isAdd", false);
		model.addAttribute("book", bookService.findBookById(id));
		model.addAttribute("parentCategories", categoryService.getAllParentCategories());
		model.addAttribute("authors", authorService.getAllAuthors());
		model.addAttribute("publishers", publisherService.getAllPublishers());
		return "admin/product/save-product";
	}

	@GetMapping("/api/getSub/{id}")
	@ResponseBody
	public ResponseEntity<List<Category>> addSubCategory(ModelMap model, @PathVariable("id") Integer id) {
		List<Category> subCategories = categoryService.getAllSubCategoriesById(id);
		return new ResponseEntity<List<Category>>(subCategories, HttpStatus.OK);
	}

	@PostMapping("/product/save")
	public String save(ModelMap model, @ModelAttribute("book") Book book, RedirectAttributes redirectAttributes,
			@RequestParam("mainAvatar") MultipartFile mainAvatar,
			@RequestParam("extraAvatar") MultipartFile[] extraAvatar,
			@RequestParam(value = "subCategory", defaultValue = "-1") Integer id,
			@RequestParam(value = "act", defaultValue = "1") Integer val) throws IllegalStateException, IOException {
		Boolean c = true;
		if (book.getId() != null)
			c = false;

		Optional<Category> subCategory = categoryService.findCategoryBy(id);
		if (subCategory.isPresent()) {// exists subCategory
			book.setCategory(subCategory.get());
		}
		if (val == 1)
			book.setAct(true);
		else
			book.setAct(false);

		book.setFile(mainAvatar);
		book.setFiles(extraAvatar);
		Book BookResp = bookService.save(book);
		if (BookResp != null && c) {
			redirectAttributes.addFlashAttribute("success", "Thêm sản phẩm mới thành công.");
		} else if (BookResp != null && !c) {
			redirectAttributes.addFlashAttribute("success", "Sửa thông tin sản phẩm thành công.");
		} else {
			redirectAttributes.addFlashAttribute("error", "Xảy ra lỗi. Vui lòng thử lại.");
		}
		return "redirect:/admin/product";
	}

	@GetMapping("/book/delete")
	private String delete(ModelMap model, @RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
		bookService.deleteOrRestoreBookById(id, false);
		redirectAttributes.addFlashAttribute("success", "Xóa sản phẩm thành công.");
		return "redirect:/admin/product";
	}

	@GetMapping("/product-removed")
	private String listProductRemove(ModelMap model) {
		model.addAttribute("books", bookService.getAllBooksDeleted());
		return "admin/product/product-removed";
	}

	@GetMapping("/book/restore")
	private String restore(ModelMap model, @RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
		bookService.deleteOrRestoreBookById(id, true);
		redirectAttributes.addFlashAttribute("success", "Khôi phục sản phẩm thành công.");
		return "redirect:/admin/product-removed";
	}

}
