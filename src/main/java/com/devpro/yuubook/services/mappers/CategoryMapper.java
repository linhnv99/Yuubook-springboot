package com.devpro.yuubook.services.mappers;

import com.devpro.yuubook.models.dto.CategoryDTO;
import com.devpro.yuubook.models.entities.Book;
import com.devpro.yuubook.models.entities.Category;
import com.devpro.yuubook.utils.FuncUtils;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class CategoryMapper {
    public List<CategoryDTO> toDTO(List<Category> subCategories, int limit) {
        return subCategories.stream()
                .map(category -> {
                    CategoryDTO categoryDTO = new CategoryDTO();
                    categoryDTO.setCategory(category);
                    List<Book> books = category.getBooks().stream()
                            .limit(limit)
                            .peek(book -> book.setStarAvg(FuncUtils.calculatorStar(book)))
                            .collect(Collectors.toList());
                    categoryDTO.setBooks(books);
                    return categoryDTO;
                }).collect(Collectors.toList());
    }
}
