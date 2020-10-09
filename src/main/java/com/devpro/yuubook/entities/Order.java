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

@Entity
@Table(name = "`order`")
public class Order extends BaseEntity {

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id")
	private User user;

	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "order")
	private List<OrderDetail> orderDetails = new ArrayList<OrderDetail>();

	public void addOrderDetail(OrderDetail orderDetail) {
		orderDetails.add(orderDetail);
		orderDetail.setOrder(this);
	}

	public void removeOrderDetail(OrderDetail orderDetail) {
		orderDetails.remove(orderDetail);
		orderDetail.setOrder(null);
	}

	@Column(name = "buy_date", nullable = false)
	private LocalDateTime buyDate;

	@Column(name = "fullname", nullable = false)
	private String fullname;

	@Column(name = "phone", nullable = false)
	private String phone;

	@Column(name = "province", nullable = false)
	private String province;

	@Column(name = "district", nullable = false)
	private String district;

	@Column(name = "wards", nullable = false)
	private String wards;

	@Column(name = "address_detail", nullable = false)
	private String addressDetail;

	@Lob
	@Column(name = "note", columnDefinition = "text")
	private String note;

	@Column(name = "order_status", nullable = false)
	private Integer orderStatus;
	
	@Transient
	private BigDecimal totalPriceOrder;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public LocalDateTime getBuyDate() {
		return buyDate;
	}

	public void setBuyDate(LocalDateTime buyDate) {
		this.buyDate = buyDate;
	}

	public List<OrderDetail> getOrderDetails() {
		return orderDetails;
	}

	public void setOrderDetails(List<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getWards() {
		return wards;
	}

	public void setWards(String wards) {
		this.wards = wards;
	}

	public String getAddressDetail() {
		return addressDetail;
	}

	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public Integer getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(Integer orderStatus) {
		this.orderStatus = orderStatus;
	}

	public BigDecimal getTotalPriceOrder() {
		return totalPriceOrder;
	}

	public void setTotalPriceOrder(BigDecimal totalPriceOrder) {
		this.totalPriceOrder = totalPriceOrder;
	}
}
