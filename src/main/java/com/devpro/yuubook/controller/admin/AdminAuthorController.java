package com.devpro.yuubook.controller.admin;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.devpro.yuubook.dto.AjaxResponse;
import com.devpro.yuubook.entities.Author;
import com.devpro.yuubook.services.AuthorService;

@Controller
@RequestMapping("admin")
public class AdminAuthorController {
	@Autowired
	private AuthorService authorService;

	@GetMapping("/author")
	public String index(ModelMap model) {
		model.addAttribute("authors", authorService.getAllAuthors());
		return "admin/author/index";
	} 

	@GetMapping("/author/add")
	public String add(ModelMap model) {
		model.addAttribute("isAdd", true);
		model.addAttribute("author", new Author());
		return "admin/author/save-author";
	}

	@GetMapping("/author/edit")
	public String edit(ModelMap model, @RequestParam("id") Integer id) {
		model.addAttribute("isAdd", false);
		model.addAttribute("author", authorService.findAuthorByAuthorId(id).get());
		return "admin/author/save-author";
	}

	@PostMapping("/author/save")
	public String save(ModelMap model, @ModelAttribute("author") Author author,
			@RequestParam("authorImage") MultipartFile authorImage, RedirectAttributes redirectAttributes)
			throws IllegalStateException, IOException {
		Boolean c = true;
		if(author.getId() != null)
			c = false;
			
		author.setFile(authorImage);
		Author authorDB = authorService.save(author);
		if (authorDB != null && c) {
			redirectAttributes.addFlashAttribute("success", "Thêm tác giả thành công.");
		} else if (authorDB != null && !c) {
			redirectAttributes.addFlashAttribute("success", "Sửa tác giả thành công.");
		} else {
			redirectAttributes.addFlashAttribute("error", "Xảy ra lỗi. Vui lòng thử lại.");
		}
		return "redirect:/admin/author";
	}

	@GetMapping("/author/delete")
	private String delete(ModelMap model, @RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
		authorService.deleteAuthorByAuthorId(id);
		redirectAttributes.addFlashAttribute("success", "Xóa tác giả thành công.");
		return "redirect:/admin/author";
	}
	
	@PutMapping("/author/show")
	public ResponseEntity<AjaxResponse>  showHome(ModelMap model, @RequestParam("id") Integer id){
		authorService.updateShowHomeByAuthorId(id);
		return ResponseEntity.ok(new AjaxResponse("Thành công.", 200));
	}
}
