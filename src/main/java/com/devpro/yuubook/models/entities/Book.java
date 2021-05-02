package com.devpro.yuubook.models.entities;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "book")
public class Book extends BaseEntity {

    @JsonIgnore
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "category_id")
    private Category category;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "author_id")
    private Author author;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "publisher_id")
    private Publisher publisher;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "book", cascade = CascadeType.ALL)
    private List<BookImage> bookImages = new ArrayList<BookImage>();

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "book", cascade = CascadeType.ALL)
    private List<Comment> comments = new ArrayList<Comment>();

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "book", cascade = CascadeType.ALL)
    private List<OrderDetail> orderDetails = new ArrayList<OrderDetail>();

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "book", cascade = CascadeType.ALL)
    private List<BookFavorite> bookFavorites = new ArrayList<BookFavorite>();

    private String name;
    private String avatar;

    @Column(name = "price", nullable = false, precision = 13, scale = 2)
    private BigDecimal price;

    private String dimension;
    private String format;

    @Column(name = "total_page")
    private int totalPage;

    private String language;

    @Column(name = "publication_date")
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime publicationDate;

    private int discount;
    private boolean hot;
    private boolean act;

    @Column(name = "buy_count", columnDefinition = "int default 0")
    private int buyCount;

    @Lob
    @Column(name = "description", columnDefinition = "text")
    private String desc;

    private String slug;

    @Transient
    private MultipartFile file;

    @Transient
    private MultipartFile[] files;

    @Transient
    private int starAvg;
}
