package com.devpro.yuubook.controllers.admins;

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

import com.devpro.yuubook.models.dto.AjaxResponse;
import com.devpro.yuubook.models.entities.Author;
import com.devpro.yuubook.services.AuthorService;

@Controller
@RequestMapping("admin")
public class AdminAuthorController {
    @Autowired
    private AuthorService authorService;

    @GetMapping("/author")
    public String index(ModelMap model) {
        model.addAttribute("authors", authorService.getAll());
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
        model.addAttribute("author", authorService.getById(id));
        return "admin/author/save-author";
    }

    @PostMapping("/author/save")
    public String save(@ModelAttribute("author") Author authorIn,
                       @RequestParam("authorImage") MultipartFile authorImage,
                       RedirectAttributes redirectAttributes) throws IllegalStateException, IOException {
        Author authorExist = authorService.getById(authorIn.getId());
        authorIn.setFile(authorImage);
        Author author = authorService.save(authorIn);
        if (author != null && authorExist == null) {
            redirectAttributes.addFlashAttribute("success", "Thêm tác giả thành công.");
        } else if (author != null) {
            redirectAttributes.addFlashAttribute("success", "Sửa tác giả thành công.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Xảy ra lỗi. Vui lòng thử lại.");
        }
        return "redirect:/admin/author";
    }

    @GetMapping("/author/delete")
    private String delete(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        authorService.delete(id);
        redirectAttributes.addFlashAttribute("success", "Xóa tác giả thành công.");
        return "redirect:/admin/author";
    }

    @PutMapping("/author/show")
    public ResponseEntity<AjaxResponse> showHome(@RequestParam("id") Integer id) {
        authorService.updateShowHomeByAuthorId(id);
        return ResponseEntity.ok(new AjaxResponse("Thành công.", 200));
    }
}
