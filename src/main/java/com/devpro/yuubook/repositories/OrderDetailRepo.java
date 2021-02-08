package com.devpro.yuubook.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.devpro.yuubook.models.entities.OrderDetail;

public interface OrderDetailRepo extends JpaRepository<OrderDetail, Integer>{

}
