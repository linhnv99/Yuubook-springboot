package com.devpro.yuubook.controllers.admins;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.devpro.yuubook.models.entities.User;
import com.devpro.yuubook.services.UserService;

@Controller
@RequestMapping("/admin")
public class AdminUserController {
	@Autowired
	private UserService userService;

	@GetMapping("/user")
	public String index(ModelMap model) {
		model.addAttribute("users", userService.getAll());
		return "admin/user";
	}

	@GetMapping("/user/delete")
	public String deleteUser(ModelMap model, @RequestParam("id") Integer id) {
		userService.deleteById(id);
		return "redirect:/admin/user";
	}

	@GetMapping("/profile")
	public String profile(ModelMap model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User userLogin = (User) authentication.getPrincipal();
		model.addAttribute("user", userService.getUserByEmail(userLogin.getEmail()));
		return "admin/profile";
	}

	@PostMapping("/profile/save-profile")
	public String saveProfile(ModelMap model, @ModelAttribute("user") User user,
			@RequestParam("uavatar") MultipartFile avatar, @RequestParam("password") String password,
			RedirectAttributes redirectAttributes) throws IllegalStateException, IOException {
		if (!avatar.isEmpty())
			user.setFile(avatar);

		user.setPassword(password);
		userService.update(user);
		redirectAttributes.addFlashAttribute("success", "Cập nhật thành công.");
		return "redirect:/admin/profile";
	}
}
