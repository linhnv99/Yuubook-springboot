package com.devpro.yuubook.services;

import java.io.IOException;
import java.util.List;

import org.springframework.data.domain.Page;

import com.devpro.yuubook.models.dto.BookDTO;
import com.devpro.yuubook.models.entities.Author;
import com.devpro.yuubook.models.entities.Book;
import com.devpro.yuubook.models.entities.Category;
import com.devpro.yuubook.models.entities.User;

public interface BookService {
    List<Book> getAll();

    List<Book> getAllDeleted();

    Book getById(Integer id);

    Book save(Book book) throws IllegalStateException, IOException;

    void deleteOrRestoreBookById(Integer id, boolean b);

    List<Book> getLimitedProductsHot(int limit);

    Page<Book> getAllByCategoryAndSort(Category category, int currentPage, String sortBy, int recordsPerPage);

    Page<Book> getAllByAuthorAndSort(Author author, int currentPage, String sortBy, int recordsPerPage);

    int getTotalNumberOfProducts(boolean b);

    List<Book> getBookFavoritesByUserLogin(User userLogin);

    List<Book> searchBooksByKeyword(String keyword);

    List<BookDTO> ajaxSearchBooksByKeyword(String keyword, int limit);

}
