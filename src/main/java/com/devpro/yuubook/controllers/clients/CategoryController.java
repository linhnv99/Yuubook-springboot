package com.devpro.yuubook.controllers.clients;


import com.devpro.yuubook.models.entities.Book;
import com.devpro.yuubook.models.entities.Category;
import com.devpro.yuubook.services.AuthorService;
import com.devpro.yuubook.services.BookService;
import com.devpro.yuubook.services.CategoryService;
import com.devpro.yuubook.utils.Constant;
import com.devpro.yuubook.utils.FuncUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/the-loai")
public class CategoryController extends BaseController{

    @Autowired
    private BookService bookService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private AuthorService authorService;

    @GetMapping("/{slug}")
    public String getProductsByCategory(ModelMap model, HttpServletRequest request, @PathVariable("slug") String slug,
                                        @RequestParam(value = "page", defaultValue = "1") int currentPage,
                                        @RequestParam(value = "sort", defaultValue = "newest") String sortBy) {
        HttpSession httpSession = request.getSession();
        httpSession.setAttribute("SORT", sortBy);

        Category cateSelected = categoryService.getBySlug(slug);
        if (cateSelected.getParentId() != null) { // chọn danh mục con
            model.addAttribute("parentCateSelected", cateSelected.getParentId());
            httpSession.setAttribute("CATALOG_SELECTED", cateSelected);
            Page<Book> books = bookService.getAllByCategoryAndSort
                    (cateSelected, currentPage, sortBy, Constant.LIMITED_PRODUCT_CATEGORY);
            List<Book> bookList = books.getContent();

            for (Book book : bookList) {
                book.setStarAvg(FuncUtils.calculatorStar(book));
            }
            model.addAttribute("books", bookList);
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", books.getTotalPages());
        } else {// chọn danh mục cha
            httpSession.removeAttribute("CATALOG_SELECTED");
            model.addAttribute("parentCateSelected", cateSelected);
            model.addAttribute("subCategoriesWithProducts",
                    categoryService.getSubCategoryWithLimitedProduct(Constant.LIMITED_PRODUCT_EACH_CATEGORY));
        }
        model.addAttribute("author", authorService.getAll());
        return "product-list";
    }
}
