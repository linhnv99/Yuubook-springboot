package com.devpro.yuubook.controller.admin;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.devpro.yuubook.entities.Publisher;
import com.devpro.yuubook.services.PublisherService;

@Controller
@RequestMapping("admin")
public class AdminPublisherController {
	@Autowired
	private PublisherService publisherService;

	@GetMapping("/publisher")
	public String index(ModelMap model) {
		model.addAttribute("publishers", publisherService.getAllPublishers());
		return "admin/publisher/index";
	}

	@GetMapping("/publisher/add")
	public String add(ModelMap model) {
		model.addAttribute("isAdd", true);
		model.addAttribute("publisher", new Publisher());
		return "admin/publisher/save-publisher";
	}

	@GetMapping("/publisher/edit")
	public String edit(ModelMap model, @RequestParam("id") Integer id) {
		model.addAttribute("isAdd", false);
		model.addAttribute("publisher", publisherService.findBublisherByPublisherId(id).get());
		return "admin/publisher/save-publisher";
	}

	@PostMapping("/publisher/save")
	public String save(ModelMap model, @ModelAttribute("publisher") Publisher publisher,
			RedirectAttributes redirectAttributes) throws IllegalStateException, IOException {
		Boolean c = true;
		if (publisher.getId() != null)
			c = false;
		Publisher publisherDB = publisherService.save(publisher);
		if(publisherDB!=null && c) {
			redirectAttributes.addFlashAttribute("success", "Thêm nhà xuất bản thành công");
		}else if(publisherDB!=null && !c) {
			redirectAttributes.addFlashAttribute("success", "Sửa nhà xuất bản thành công");
		}else {
			redirectAttributes.addFlashAttribute("error", "Xảy ra lỗi. Vui lòng thử lại.");
		}
		return "redirect:/admin/publisher";
	}

	@GetMapping("/publisher/delete")
	private String delete(ModelMap model, @RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
		publisherService.deletePublisherByPublisherId(id);
		redirectAttributes.addFlashAttribute("success", "Xóa nhà xuất bản thành công.");
		return "redirect:/admin/publisher";
	}
}
