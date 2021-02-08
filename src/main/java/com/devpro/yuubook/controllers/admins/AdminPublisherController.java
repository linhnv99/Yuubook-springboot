package com.devpro.yuubook.controllers.admins;

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

import com.devpro.yuubook.models.entities.Publisher;
import com.devpro.yuubook.services.PublisherService;

@Controller
@RequestMapping("admin")
public class AdminPublisherController {
    @Autowired
    private PublisherService publisherService;

    @GetMapping("/publisher")
    public String index(ModelMap model) {
        model.addAttribute("publishers", publisherService.getAll());
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
        model.addAttribute("publisher", publisherService.getById(id));
        return "admin/publisher/save-publisher";
    }

    @PostMapping("/publisher/save")
    public String save(@ModelAttribute("publisher") Publisher publisherIn,
                       RedirectAttributes redirectAttributes) throws IllegalStateException, IOException {
        Publisher publisherExist = publisherService.getById(publisherIn.getId());
        Publisher publisher = publisherService.save(publisherIn);
        if (publisher != null && publisherExist == null) {
            redirectAttributes.addFlashAttribute("success", "Thêm nhà xuất bản thành công");
        } else if (publisher != null) {
            redirectAttributes.addFlashAttribute("success", "Sửa nhà xuất bản thành công");
        } else {
            redirectAttributes.addFlashAttribute("error", "Xảy ra lỗi. Vui lòng thử lại.");
        }
        return "redirect:/admin/publisher";
    }

    @GetMapping("/publisher/delete")
    private String delete(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        publisherService.deleteById(id);
        redirectAttributes.addFlashAttribute("success", "Xóa nhà xuất bản thành công.");
        return "redirect:/admin/publisher";
    }
}
