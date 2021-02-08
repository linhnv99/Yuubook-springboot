package com.devpro.yuubook.repositories;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.devpro.yuubook.models.entities.Order;

@Repository
public interface OrderRepo extends JpaRepository<Order, Integer> {

	@Query(value = "select * from `order` where order_status = 0 and status = 1 order by buy_date desc", nativeQuery = true)
	List<Order> getOrdersNeedConfirm();

	@Query(value = "select * from `order` where not order_status = 0 and status = 1 order by buy_date desc", nativeQuery = true)
	List<Order> getOrdersConfirmed();

	@Query(value = "select count(*) from `order` where not order_status = 0 and status = 1", nativeQuery = true)
	Integer getTotalNumberOfOrders();
	
	@Query(value = "select * from `order` where order_status = 3", nativeQuery = true)
	List<Order> getOrdersCompleted();
	
	@Transactional
	@Modifying
	@Query(value = "update `order` set order_status = 1 where id = ?1", nativeQuery = true)
	void confirmOrderById(int id);
	
	@Transactional
	@Modifying
	@Query(value = "update `order` set order_status = ?2 where id = ?1", nativeQuery = true)
	void setOrderStatusById(Integer id, int val);

	@Query(value = "select * from `order` where user_id = ?1 and status = 1 order by buy_date desc", nativeQuery = true)
	List<Order> getOrdersByUserLogin(int id);
	
	@Transactional
	@Modifying
	@Query(value = "update `order` set status = 0 where id = ?1", nativeQuery = true)
	void deleteOrderById(int id);

	@Query(value = "select * from `order` where status = 0 and user_id = ?1", nativeQuery = true)
	List<Order> getOrdersDeletedByUserLogin(int id);
}
