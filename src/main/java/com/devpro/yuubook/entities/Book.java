package com.devpro.yuubook.entities;

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

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "book")
public class Book extends BaseEntity {

	@JsonIgnore // bỏ qua trong quá trình serialize
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "category_id") // ten khoa ngoai
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

	public void addBookImages(BookImage _bookImages) {
		bookImages.add(_bookImages);
		_bookImages.setBook(this);
	}

	public void removeBookImages(BookImage _bookImages) {
		bookImages.remove(_bookImages);
		_bookImages.setBook(null);
	}
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "book", cascade = CascadeType.ALL)
	private List<Comment> comments = new ArrayList<Comment>();

	public void addComments(Comment _comments) {
		comments.add(_comments);
		_comments.setBook(this);
	}

	public void removeComments(Comment _comments) {
		comments.remove(_comments);
		_comments.setBook(null);
	}
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "book", cascade = CascadeType.ALL)
	private List<OrderDetail> orderDetails = new ArrayList<OrderDetail>();

	public void addOrderDetail(OrderDetail orderDetail) {
		orderDetails.add(orderDetail);
		orderDetail.setBook(this);
	}

	public void removeOrderDetail(OrderDetail orderDetail) {
		orderDetails.remove(orderDetail);
		orderDetail.setBook(null);
	}
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "book", cascade = CascadeType.ALL)
	private List<BookFavorite> bookFavorites = new ArrayList<BookFavorite>();
	
	@Column(name = "name", nullable = false)
	private String name;

	@Column(name = "avatar")
	private String avatar;

	@Column(name = "price", nullable = false, precision = 13, scale = 2)
	private BigDecimal price;

	@Column(name = "dimension")
	private String dimension;

	@Column(name = "format")
	private String format;

	@Column(name = "total_page")
	private Integer totalPage;

	@Column(name = "language")
	private String language;

	@Column(name = "publication_date")
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime publicationDate;

	@Column(name = "discount")
	private Integer discount;

	@Column(name = "hot")
	private Boolean hot;

	@Column(name = "act")
	private Boolean act;

	@Lob
	@Column(name = "description", columnDefinition = "text")
	private String desc;

	@Transient
	private MultipartFile file;

	@Transient
	private MultipartFile[] files;

	public MultipartFile getFile() {
		return file;
	}
	@Transient
	private Integer starAvg;
	
	public Integer getStarAvg() {
		return starAvg;
	}

	public void setStarAvg(Integer starAvg) {
		this.starAvg = starAvg;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public MultipartFile[] getFiles() {
		return files;
	}

	public void setFiles(MultipartFile[] files) {
		this.files = files;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Author getAuthor() {
		return author;
	}

	public void setAuthor(Author author) {
		this.author = author;
	}

	public Publisher getPublisher() {
		return publisher;
	}

	public void setPublisher(Publisher publisher) {
		this.publisher = publisher;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public String getDimension() {
		return dimension;
	}

	public void setDimension(String dimension) {
		this.dimension = dimension;
	}

	public String getFormat() {
		return format;
	}

	public void setFormat(String format) {
		this.format = format;
	}

	public Integer getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public LocalDateTime getPublicationDate() {
		return publicationDate;
	}

	public void setPublicationDate(LocalDateTime publicationDate) {
		this.publicationDate = publicationDate;
	}

	public Integer getDiscount() {
		return discount;
	}

	public void setDiscount(Integer discount) {
		this.discount = discount;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public List<OrderDetail> getOrderDetails() {
		return orderDetails;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public void setOrderDetails(List<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}

	public List<BookImage> getBookImages() {
		return bookImages;
	}

	public void setBookImages(List<BookImage> bookImages) {
		this.bookImages = bookImages;
	}

	public Boolean getHot() {
		return hot;
	}

	public void setHot(Boolean hot) {
		this.hot = hot;
	}

	public Boolean getAct() {
		return act;
	}

	public void setAct(Boolean act) {
		this.act = act;
	}

	public List<BookFavorite> getBookFavorites() {
		return bookFavorites;
	}

	public void setBookFavorites(List<BookFavorite> bookFavorites) {
		this.bookFavorites = bookFavorites;
	}
	
}
