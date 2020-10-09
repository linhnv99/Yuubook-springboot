package com.devpro.yuubook.controller.admin;

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
		model.addAttribute("contacts", contactService.getAllContacts());
		return "admin/contact/contact";
	}
	@GetMapping("/contact/delete")
	public String deleteContact(ModelMap model, @RequestParam("id") Integer id) {
		contactService.deleteContactById(id);
		return "redirect:/admin/contact";
	}
}
