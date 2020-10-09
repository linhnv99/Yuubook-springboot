package com.devpro.yuubook.services;

import java.io.IOException;
import java.util.List;

import org.springframework.data.domain.Page;

import com.devpro.yuubook.dto.BookDTO;
import com.devpro.yuubook.entities.Author;
import com.devpro.yuubook.entities.Book;
import com.devpro.yuubook.entities.Category;
import com.devpro.yuubook.entities.User;

public interface BookService {

	List<Book> getAllBooks();
	
	List<Book> getAllBooksDeleted();

	Book findBookById(Integer id);

	Book save(Book book) throws IllegalStateException, IOException;

	void deleteOrRestoreBookById(Integer id, boolean b);

	List<Book> getLimitedProductsHot(int limit);
	
	Page<Book> getAllBooksByCategoryAndSort(Category category, Integer currentPage, String sortBy, Integer recordsPerPage);

	Page<Book> getAllBooksByAuthorAndSort(Author author, Integer currentPage, String sortBy, Integer recordsPerPage);

	Integer getTotalNumberOfProducts(boolean b);

	List<Book> getBookFavoritesByUserLogin(User userLogin);

	List<Book> searchBooksByKeyword(String keyword);

	List<BookDTO> ajaxSearchBooksByKeyword(String keyword);

}
