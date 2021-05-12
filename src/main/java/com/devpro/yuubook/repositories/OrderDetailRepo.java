package com.devpro.yuubook.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.devpro.yuubook.models.entities.OrderDetail;

import java.util.List;

public interface OrderDetailRepo extends JpaRepository<OrderDetail, Integer> {
    List<OrderDetail> findByOrderId(int id);
}
