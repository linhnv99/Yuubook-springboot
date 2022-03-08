package com.devpro.yuubook.services.impl;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.devpro.yuubook.services.mappers.BookMapper;
import com.devpro.yuubook.utils.FileUtils;
import com.devpro.yuubook.utils.FuncUtils;

import org.hibernate.annotations.SourceType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.devpro.yuubook.models.dto.BookDTO;
import com.devpro.yuubook.models.entities.Author;
import com.devpro.yuubook.models.entities.Book;
import com.devpro.yuubook.models.entities.BookFavorite;
import com.devpro.yuubook.models.entities.BookImage;
import com.devpro.yuubook.models.entities.Category;
import com.devpro.yuubook.models.entities.User;
import com.devpro.yuubook.repositories.BookImageRepo;
import com.devpro.yuubook.repositories.BookRepo;
import com.devpro.yuubook.services.BookService;

@Service
public class BookServiceImpl implements BookService {
    @Autowired
    private BookRepo bookRepo;
    @Autowired
    private BookImageRepo bookImageRepo;
    @Autowired
    private BookMapper bookMapper;

    public List<Book> getAll() {
        return bookRepo.getAll();
    }

    @Override
    public List<Book> getAllDeleted() {
        return bookRepo.getAllDeleted();
    }

    public Book getById(Integer id) {
        Book book = bookRepo.findById(id).orElse(null);
        if (book == null) return null;
        book.setStarAvg(FuncUtils.calculatorStar(book));
        return book;
    }

    public Book save(Book bookIn) throws IllegalStateException, IOException {
        Book book = bookRepo.findById(bookIn.getId()).orElse(null);
        if (book != null) {
            if (bookIn.getCategory() == null) {
                bookIn.setCategory(book.getCategory());
            }
            if (bookIn.getFile().isEmpty()) {
                bookIn.setAvatar(book.getAvatar());
            }
            if (bookIn.getFiles() != null && bookIn.getFiles().length > 0) {
                updateFiles(bookIn, book);
            }
            bookIn.setStatus(book.isStatus());
            bookIn.setCreatedDate(book.getCreatedDate());
            bookIn.setUpdatedDate(LocalDateTime.now());
        } else {
            if (bookIn.getFiles() != null && bookIn.getFiles().length > 0) {
                saveFiles(bookIn);
            }
            bookIn.setStatus(true);
            bookIn.setCreatedDate(LocalDateTime.now());
        }
        if (!bookIn.getFile().isEmpty()) {// one image
            saveFile(bookIn);
        }
        bookIn.setStatus(true);
        bookIn.setSlug(FuncUtils.toSlug(bookIn.getName()));
        return bookRepo.save(bookIn);
    }

    private void updateFiles(Book bookIn, Book book) throws IllegalStateException, IOException {
        int k = 0;
        for (MultipartFile file : bookIn.getFiles()) {
            if (file.isEmpty()) {
                k++;
            }
        }
        if (k != 0) {
            book.setBookImages(book.getBookImages());
        } else {
            bookImageRepo.deleteBookImageByBookId(bookIn.getId());
            saveFiles(bookIn);
        }
    }

    public void saveFile(Book book) throws IllegalStateException, IOException {
        String fullPath = FileUtils.SAVE_PATH + "products/" + book.getFile().getOriginalFilename();
        book.getFile().transferTo(new File(fullPath));
        book.setAvatar("products/" + book.getFile().getOriginalFilename());
    }

    public void saveFiles(Book book) throws IllegalStateException, IOException {
        for (MultipartFile file : book.getFiles()) {
            if (!file.isEmpty()) {
                String fullPath = FileUtils.SAVE_PATH + "products/" + "extraProducts/" + file.getOriginalFilename();
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
    public Page<Book> getAllByCategoryAndSort(Category category,
                                              int currentPage,
                                              String sortBy,
                                              int recordsPerPage) {
        Pageable pageable = PageRequest.of(currentPage - 1, recordsPerPage, setSort(sortBy));

        if (category == null)
            return bookRepo.getAllByHot(pageable);

        return bookRepo.getAllByCategory(category.getId(), pageable);
    }

    @Override
    public Page<Book> getAllByAuthorAndSort(Author author,
                                            int currentPage,
                                            String sortBy,
                                            int recordsPerPage) {
        Pageable pageable = PageRequest.of(currentPage - 1, recordsPerPage, setSort(sortBy));
        return bookRepo.getAllByAuthor(author.getId(), pageable);
    }

    public Sort setSort(String sortBy) {
        Sort sort;
        switch (sortBy) {
            case "az":
                sort = Sort.by("name").ascending();
                break;
            case "za":
                sort = Sort.by("name").descending();
                break;
            case "minmax":
                sort = Sort.by("price").ascending();
                break;
            case "maxmin":
                sort = Sort.by("price").descending();
                break;
            default:
                sort = Sort.by("created_date").descending();
                break;
        }
        return sort;
    }

    @Override
    public int getTotalNumberOfProducts(boolean b) {
        return bookRepo.getTotalNumberOfProducts(b);
    }

    @Override
    public List<Book> getBookFavoritesByUserLogin(User userLogin) {
        List<Book> books = new ArrayList<Book>();
        for (BookFavorite bookFavorite : userLogin.getBookFavorites()) {
            Book book = bookRepo.findById(bookFavorite.getBook().getId()).orElse(null);
            books.add(book);
        }
        return books;
    }

    @Override
    public List<Book> searchBooksByKeyword(String keyword) {
        return bookRepo.getAllBookByKeyword(keyword.trim());
    }

    @Override
    public List<BookDTO> ajaxSearchBooksByKeyword(String keyword, int limit) {
        List<Book> books = bookRepo.getAllBookByKeyword(keyword.trim());
        // TODO: get from elastic
        return bookMapper.toDTO(books, limit);
    }

    @Override
    public Book getBySlug(String slug) {
        Book book = bookRepo.findBySlug(slug);
        book.setStarAvg(FuncUtils.calculatorStar(book));
        return book;
    }

    @Override
    public List<Book> getMostPurchasedProduct() {
        return bookRepo.findByBuyCount();
    }
}
