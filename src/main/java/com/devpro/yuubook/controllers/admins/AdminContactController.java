package com.devpro.yuubook.controllers.admins;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.devpro.yuubook.services.ContactService;

@Controller
@RequestMapping("/admin")
public class AdminContactController {
	@Autowired
	private ContactService contactService;

	@GetMapping("/contact")
	public String index(ModelMap model) {
		model.addAttribute("contacts", contactService.getAll());
		return "admin/contact/contact";
	}
	@GetMapping("/contact/delete")
	public String deleteContact(ModelMap model, @RequestParam("id") Integer id) {
		contactService.deleteById(id);
		return "redirect:/admin/contact";
	}
}
