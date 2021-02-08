package com.devpro.yuubook.models.dto;

import java.util.List;

import com.devpro.yuubook.models.entities.Author;
import com.devpro.yuubook.models.entities.Book;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class AuthorDTO {
	private Author author;
	private List<Book> books;
}
