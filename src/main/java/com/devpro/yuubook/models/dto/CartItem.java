package com.devpro.yuubook.models.dto;

import java.math.BigDecimal;

public class CartItem {
    private int bookId;
    private String bookName;
    private String avatar;
    private BigDecimal price;
    private BigDecimal originPrice;
    private Integer discount;
    private int quantity;
    private String slug;

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public BigDecimal getPrice() {
        this.price = BigDecimal.ZERO;
        BigDecimal qty = new BigDecimal(this.getQuantity());
        BigDecimal priceDown = BigDecimal.ZERO;
        if (this.discount != null) {
            priceDown = this.originPrice.multiply(new BigDecimal((float) this.discount / 100));
            this.price = this.originPrice.subtract(priceDown);
        } else {
            this.price = this.originPrice.multiply(qty);
        }
        return this.price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getOriginPrice() {
        return originPrice;
    }

    public void setOriginPrice(BigDecimal originPrice) {
        this.originPrice = originPrice;
    }

    public Integer getDiscount() {
        return discount;
    }

    public void setDiscount(Integer discount) {
        this.discount = discount;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }
}
