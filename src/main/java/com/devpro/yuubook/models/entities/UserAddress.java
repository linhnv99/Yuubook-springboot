package com.devpro.yuubook.models.entities;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "user_address")
public class    UserAddress extends BaseEntity {
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "province_id")
    private int provinceId;

    @Column(name = "district_id")
    private int districtId;

    @Column(name = "wards_id")
    private int wardsId;

    @Column(name = "address_detail")
    private String addressDetail;

    @Column(columnDefinition = "text")
    private String note;
}
