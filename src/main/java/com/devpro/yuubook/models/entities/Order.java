package com.devpro.yuubook.models.entities;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

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
@Getter
@Setter
@NoArgsConstructor
@Table(name = "`order`")
public class Order extends BaseEntity {

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "order")
    private List<OrderDetail> orderDetails = new ArrayList<>();

    @Column(name = "buy_date")
    private LocalDateTime buyDate;

    private String fullName;
    private String phone;
    private String province;
    private String district;
    private String wards;

    @Column(name = "address_detail")
    private String addressDetail;

    @Column(columnDefinition = "text")
    private String note;

    @Column(name = "order_status")
    private int orderStatus;

    @Transient
    private BigDecimal totalPriceOrder;
}
