package com.devpro.yuubook.services;

import java.math.BigDecimal;
import java.util.List;

import com.devpro.yuubook.dto.CartItem;
import com.devpro.yuubook.dto.CustomerAddress;
import com.devpro.yuubook.entities.Order;
import com.devpro.yuubook.entities.User;

public interface OrderService {

	void saveOrder(List<CartItem> cartItems, CustomerAddress customerAddress);

	List<Order> getOrdersConfirmed();

	List<Order> getOrdersNeedConfirm();

	Integer getTotalNumberOfOrders();

	BigDecimal getTotalSales();

	void confirmOrderById(Integer id);

	void setOrderStatusById(Integer id, Integer val);

	List<Order> getOrdersByUserLogin(User userLogin);

	Order getOrderById(Integer id);

	void deleteOrderById(Integer id);

	List<Order> getOrdersDeletedByUserLogin(User userLogin);

}
