package com.devpro.yuubook.controllers.admins;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.devpro.yuubook.services.CommentService;

@Controller
@RequestMapping("/admin")
public class AdminCommentController {
	@Autowired
	private CommentService commentService;
	
	@GetMapping("/comment")
	public String index(ModelMap model) {
		model.addAttribute("comments", commentService.getAll());
		return "admin/comment";
	}
	
	@GetMapping("/comment/delete")
	private String delete(ModelMap model, @RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
		commentService.deleteById(id);
		redirectAttributes.addFlashAttribute("success", "Xóa đánh giá thành công.");
		return "redirect:/admin/comment";
	}
}
