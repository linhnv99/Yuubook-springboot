package com.devpro.yuubook.services.impl;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.devpro.yuubook.dto.BookDTO;
import com.devpro.yuubook.entities.Author;
import com.devpro.yuubook.entities.Book;
import com.devpro.yuubook.entities.BookFavorite;
import com.devpro.yuubook.entities.BookImage;
import com.devpro.yuubook.entities.Category;
import com.devpro.yuubook.entities.Comment;
import com.devpro.yuubook.entities.User;
import com.devpro.yuubook.repositories.BookImageRepo;
import com.devpro.yuubook.repositories.BookRepo;
import com.devpro.yuubook.services.BookService;

@Service
public class BookServiceImpl implements BookService {
	@Autowired
	private BookRepo bookRepo;
	@Autowired
	private BookImageRepo bookImageRepo;

	public List<Book> getAllBooks() {
		return bookRepo.getAllBooks();
	}

	@Override
	public List<Book> getAllBooksDeleted() {
		return bookRepo.getAllBooksDeleted();
	}

	public Book findBookById(Integer id) {
		Book book = bookRepo.findById(id).get();
		book.setStarAvg(calculatorStar(book));
		return book;
	}

	public Integer calculatorStar(Book book) {
		Integer starAvg = 0;
		if (book.getComments().size() != 0) {
			for (Comment comment : book.getComments()) {
				starAvg += comment.getStar();
			}
			return starAvg / book.getComments().size();
		}
		return 0;
	}

	public Book save(Book book) throws IllegalStateException, IOException {
		String path = "F:\\JavaDev\\Lesson\\Phan3_Backend\\yuubook\\upload\\products\\";
		if (book.getId() != null) {// update
			Book bookInDB = bookRepo.findById(book.getId()).get();
			if (book.getCategory() == null) {
				book.setCategory(bookInDB.getCategory());
			}
			if (book.getFile().isEmpty()) {// k có file gửi lên
				book.setAvatar(bookInDB.getAvatar());// gán lại file cũ
			} else {
				saveFile(book, path);
			}
			if (book.getFiles() != null && book.getFiles().length > 0) {
				updateFiles(book, path, bookInDB);
			}
			book.setCreatedDate(bookInDB.getCreatedDate());
			book.setUpdatedDate(LocalDateTime.now());
		} else {// new
			if (!book.getFile().isEmpty()) {// one image
				saveFile(book, path);
			}
			if (book.getFiles() != null && book.getFiles().length > 0) {
				saveFiles(book, path);
			}
			book.setCreatedDate(LocalDateTime.now());
		}
		book.setStatus(true);
		return bookRepo.save(book);
	}

	private void updateFiles(Book book, String path, Book bookInDB) throws IllegalStateException, IOException {
		int k = 0;
		for (MultipartFile file : book.getFiles()) {
			if (file.isEmpty()) {
				k++;
			}
		}
		if (k != 0) {// TH: file gửi lên tất cả đều rỗng
			book.setBookImages(bookInDB.getBookImages());// gán lại file cũ
		} else {
			bookImageRepo.deleteBookImageByBookId(book.getId());// xóa tất cả ảnh có bookId tương ứng
			saveFiles(book, path);// lưu file vừa gửi lên
		}
	}

	public void saveFile(Book book, String path) throws IllegalStateException, IOException {
		String fullPath = path + book.getFile().getOriginalFilename();
		book.getFile().transferTo(new File(fullPath));
		book.setAvatar("products/" + book.getFile().getOriginalFilename());
	}

	public void saveFiles(Book book, String path) throws IllegalStateException, IOException {
		for (MultipartFile file : book.getFiles()) {
			if (!file.isEmpty()) {
				String fullPath = path + "/extraProducts/" + file.getOriginalFilename();
				file.transferTo(new File(fullPath));
				BookImage bookImage = new BookImage();
				bookImage.setName(file.getOriginalFilename());
				bookImage.setBook(book);
				bookImage.setPath("products/extraProducts/" + file.getOriginalFilename());
				bookImage.setCreatedDate(LocalDateTime.now());
				book.getBookImages().add(bookImage);
			}
		}
	}

	@Override
	public void deleteOrRestoreBookById(Integer id, boolean b) {
		bookRepo.deleteOrRestoreBookById(id, b);
	}

	@Override
	public List<Book> getLimitedProductsHot(int limit) {
		return bookRepo.getLimitedProductsHot(limit);
	}

	@Override
	public Page<Book> getAllBooksByCategoryAndSort(Category category, Integer currentPage, String sortBy,
			Integer recordsPerPage) {
		Pageable pageable = PageRequest.of(currentPage - 1, recordsPerPage, setSort(sortBy));
		return bookRepo.getAllBooksByCategory(category.getId(), pageable);
	}

	@Override
	public Page<Book> getAllBooksByAuthorAndSort(Author author, Integer currentPage, String sortBy,
			Integer recordsPerPage) {
		Pageable pageable = PageRequest.of(currentPage - 1, recordsPerPage, setSort(sortBy));
		return bookRepo.getAllBooksByAuthor(author.getId(), pageable);
	}

	public Sort setSort(String sortBy) {
		Sort sort = null;
		if (sortBy.equals("az")) {
			sort = Sort.by("name").ascending();
		} else if (sortBy.equals("za")) {
			sort = Sort.by("name").descending();
		} else if (sortBy.equals("minmax")) {
			sort = Sort.by("price").ascending();
		} else if (sortBy.equals("maxmin")) {
			sort = Sort.by("price").descending();
		} else {
			sort = Sort.by("created_date").descending();
		}
		return sort;
	}

	@Override
	public Integer getTotalNumberOfProducts(boolean b) {
		return bookRepo.getTotalNumberOfProducts(b);
	}

	@Override
	public List<Book> getBookFavoritesByUserLogin(User userLogin) {
		List<Book> books = new ArrayList<Book>();
		for (BookFavorite bookFavorite : userLogin.getBookFavorites()) {
			Book book = bookRepo.findById(bookFavorite.getBook().getId()).get();
			books.add(book);
		}
		return books;
	}

	@Override
	public List<Book> searchBooksByKeyword(String keyword) {
		return bookRepo.getAllBookByKeyword(keyword.trim());
	}

	@Override
	public List<BookDTO> ajaxSearchBooksByKeyword(String keyword) {
		List<Book> books = bookRepo.getAllBookByKeyword(keyword.trim());
		List<BookDTO> bookDTOs = new ArrayList<BookDTO>();
		int i = 0;
		for (Book book : books) {
			if(i == 10) break;
			BookDTO bookDTO = new BookDTO();
			bookDTO.setId(book.getId());
			bookDTO.setName(book.getName());
			bookDTO.setAvatar(book.getAvatar());
			bookDTO.setAuthorName(book.getAuthor().getName());
			bookDTO.setStatus(book.getStatus());
			bookDTOs.add(bookDTO);
			i++;
		}
		return bookDTOs;
	}

}
