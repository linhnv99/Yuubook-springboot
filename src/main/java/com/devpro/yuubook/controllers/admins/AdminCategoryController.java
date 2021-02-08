package com.devpro.yuubook.controllers.admins;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.devpro.yuubook.models.dto.AjaxResponse;
import com.devpro.yuubook.models.entities.Category;
import com.devpro.yuubook.services.CategoryService;

@Controller
@RequestMapping("admin")
public class AdminCategoryController {
    @Autowired
    private CategoryService categoryService;

    @GetMapping("/category")
    private String category(ModelMap model) {
        model.addAttribute("parentCategories", categoryService.getAllParentCategories());
        return "admin/category/category";
    }

    @GetMapping("/category/add")
    private String add(ModelMap model) {
        model.addAttribute("isAdd", true);
        model.addAttribute("category", new Category());
        return "admin/category/save-category";
    }

    @GetMapping("/category/edit")
    private String edit(ModelMap model, @RequestParam("id") int id) {
        model.addAttribute("isAdd", false);
        model.addAttribute("category", categoryService.getById(id));
        return "admin/category/save-category";
    }

    @PostMapping("/category/save")
    private String save(ModelMap model, @ModelAttribute("category") Category categoryIn,
                        RedirectAttributes redirectAttributes) {
        boolean c = true;
        Category category = categoryService.getById(categoryIn.getId());
        if (category != null)
            c = false;

        Category categoryResp = categoryService.save(categoryIn);
        if (categoryResp != null && c) {
            redirectAttributes.addFlashAttribute("success", "Thêm danh mục thành công.");
        } else if (categoryResp != null && !c) {
            redirectAttributes.addFlashAttribute("success", "Sửa danh mục thành công.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Xảy ra lỗi. Vui lòng thử lại.");
        }
        if (categoryResp.getParentId() != null) {
            return "redirect:/admin/category/sub-category?pid=" + categoryResp.getParentId().getId();
        }
        return "redirect:/admin/category";
    }

    @GetMapping("/category/delete")
    private String delete(ModelMap model, @RequestParam("id") int id, RedirectAttributes redirectAttributes) {
        Category subCategory = categoryService.getById(id);
        categoryService.deleteCategoryById(id);
        redirectAttributes.addFlashAttribute("success", "Xóa danh mục thành công");
        if (subCategory.getParentId() != null) {
            return "redirect:/admin/category/sub-category?pid=" + subCategory.getParentId().getId();
        }
        return "redirect:/admin/category";
    }

    @PutMapping("/category/show")
    public ResponseEntity<AjaxResponse> showHome(ModelMap model, @RequestParam("id") Integer id) {
        categoryService.updateShowHomeById(id);
        return ResponseEntity.ok(new AjaxResponse("Thành công.", 200));
    }

    @GetMapping("/category/sub-category")
    public String subCategory(ModelMap model, @RequestParam("pid") int pid) {
        model.addAttribute("parentCate", categoryService.getById(pid));
        model.addAttribute("subCategories", categoryService.getAllSubCategoriesByParentId(pid));
        return "admin/category/sub-category";
    }

    @GetMapping("/category/sub-category/add")
    private String addSubCategoryint(ModelMap model, @RequestParam("pid") int pid) {
        Category parentCate = categoryService.getById(pid);
        Category subCategory = new Category();
        subCategory.setParentId(parentCate);
        model.addAttribute("isAdd", true);
        model.addAttribute("category", subCategory);
        return "admin/category/save-subcategory";
    }

    @GetMapping("/category/sub-category/edit")
    private String editSubCategory(ModelMap model, @RequestParam("sid") int sid) {
        model.addAttribute("isAdd", false);
        model.addAttribute("category", categoryService.getById(sid));
        return "admin/category/save-subcategory";
    }
}
