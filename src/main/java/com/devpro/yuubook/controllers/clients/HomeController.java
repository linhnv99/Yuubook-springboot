package com.devpro.yuubook.controllers.clients;

import java.net.URI;
import java.util.List;

import com.devpro.yuubook.utils.ExternalApi;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.devpro.yuubook.utils.Constant;
import com.devpro.yuubook.models.dto.AjaxResponse;
import com.devpro.yuubook.models.dto.BookDTO;
import com.devpro.yuubook.services.AuthorService;
import com.devpro.yuubook.services.BookService;
import com.devpro.yuubook.services.CategoryService;


@Controller
public class HomeController extends BaseController {
    @Autowired
    private AuthorService authorService;
    @Autowired
    private BookService bookService;
    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ExternalApi externalApi;

    @Value("${external.api.url}")
    private String baseUrl;

    @Value("${external.api.key}")
    private String apiKey;

    @GetMapping({"/", "/home"})
    public String index(ModelMap model) throws Exception {
        model.addAttribute("authors",
                authorService.getAuthorWithLimitedProduct(Constant.HOME_LIMITED_PRODUCT_AUTHOR));
        model.addAttribute("bookHot",
                bookService.getLimitedProductsHot(Constant.HOME_LIMITED_PRODUCT_HOT));
        model.addAttribute("subCateShowHome",
                categoryService.getSubCategoryWithLimitedProduct(Constant.HOME_LIMITED_PRODUCT_SUBCATEGORY));
        model.addAttribute("parentCateShowHome",
                categoryService.getParentCategoryWithLimitedProduct(Constant.HOME_LIMITED_PRODUCT_CATEGORY));
        return "index";
    }

    @GetMapping("/search")
    public String searchProduct(ModelMap model, @RequestParam("q") String keyword) {
        model.addAttribute("books", bookService.searchBooksByKeyword(keyword));
        model.addAttribute("keyword", keyword);
        return "product-search";
    }

    @GetMapping("/search-suggest")
    public ResponseEntity<AjaxResponse> searchProductByAjax(ModelMap model, @RequestParam("q") String keyword) {

        MultiValueMap<String, String> headers = new LinkedMultiValueMap<>();
        headers.add("API_KEY", apiKey);

        RequestEntity<BookDTO> requestEntity = new RequestEntity<>(headers, HttpMethod.GET,
                URI.create(baseUrl + "/searchElastic/book?searchKey=" + keyword));

        ResponseEntity<List<BookDTO>> responseEntity = externalApi.exchange(requestEntity,
                new ParameterizedTypeReference<List<BookDTO>>() {
                });
//        List<BookDTO> books = bookService.ajaxSearchBooksByKeyword(keyword, 10);
        return ResponseEntity.ok(new AjaxResponse(responseEntity.getBody(), 200));
    }

}
