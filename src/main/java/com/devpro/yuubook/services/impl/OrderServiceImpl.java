package com.devpro.yuubook.services.impl;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.devpro.yuubook.dto.CartItem;
import com.devpro.yuubook.dto.CustomerAddress;
import com.devpro.yuubook.entities.Order;
import com.devpro.yuubook.entities.OrderDetail;
import com.devpro.yuubook.entities.User;
import com.devpro.yuubook.repositories.OrderRepo;
import com.devpro.yuubook.services.BookService;
import com.devpro.yuubook.services.OrderService;
import com.devpro.yuubook.services.UserService;

@Service
public class OrderServiceImpl implements OrderService {
	@Autowired
	private OrderRepo orderRepo;
	@Autowired
	private UserService userService;
	@Autowired
	private BookService bookService;

	@Override
	public void saveOrder(List<CartItem> cartItems, CustomerAddress customerAddress) {
		User user = null;
		// kiểm tra có tài khoản hay không?
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
			User userLogin = (User) authentication.getPrincipal();
			user = userService.findUserByEmail(userLogin.getEmail());
		}

		Order order = new Order();
		order.setUser(user);
		order.setBuyDate(LocalDateTime.now());
		order.setFullname(customerAddress.getFullname());
		order.setPhone(customerAddress.getPhone());
		order.setProvince(customerAddress.getProvince());
		order.setDistrict(customerAddress.getDistrict());
		order.setWards(customerAddress.getWards());
		order.setAddressDetail(customerAddress.getAddressDetail());
		order.setNote(customerAddress.getNote());
		order.setOrderStatus(0);
		order.setCreatedDate(LocalDateTime.now());

		List<OrderDetail> orderDetails = new ArrayList<OrderDetail>();
		for (CartItem cartItem : cartItems) {
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setBook(bookService.findBookById(cartItem.getBookId()));
			orderDetail.setOrder(order);
			orderDetail.setQuantity(cartItem.getQuantity());
			orderDetail.setUnitPrice(cartItem.getPrice());
			orderDetails.add(orderDetail);
		}
		order.setOrderDetails(orderDetails);
		order.setStatus(true);
		orderRepo.save(order);
	}

	@Override
	public List<Order> getOrdersConfirmed() {
		List<Order> orders = orderRepo.getOrdersConfirmed();
		return getOrders(orders);
	}

	@Override
	public List<Order> getOrdersNeedConfirm() {
		List<Order> orders = orderRepo.getOrdersNeedConfirm();
		return getOrders(orders);
	}

	private List<Order> getOrders(List<Order> orders) {
		for (Order order : orders) {
			BigDecimal totalPrice = BigDecimal.ZERO;
			for (OrderDetail orderDetail : order.getOrderDetails()) {
				totalPrice = totalPrice.add(orderDetail.getUnitPrice().multiply(new BigDecimal(orderDetail.getQuantity())));
			}
			order.setTotalPriceOrder(totalPrice);
		}
		return orders;
	}

	@Override
	public Integer getTotalNumberOfOrders() {
		return orderRepo.getTotalNumberOfOrders();
	}

	@Override
	public BigDecimal getTotalSales() {
		List<Order> orders = orderRepo.getOrdersCompleted();
		BigDecimal itemPrice = BigDecimal.ZERO;
		BigDecimal totalSale = BigDecimal.ZERO;
		for (Order order : orders) {
			for (OrderDetail orderDetail : order.getOrderDetails()) {
				itemPrice = itemPrice.add(orderDetail.getUnitPrice().multiply(new BigDecimal(orderDetail.getQuantity())));
			}
			totalSale = totalSale.add(itemPrice);
		}
		return totalSale;
	}

	@Override
	public void confirmOrderById(Integer id) {
		orderRepo.confirmOrderById(id);
	}

	@Override
	public void setOrderStatusById(Integer id, Integer val) {
		orderRepo.setOrderStatusById(id, val);
	}

	@Override
	public List<Order> getOrdersByUserLogin(User userLogin) {
		List<Order> orders = orderRepo.getOrdersByUserLogin(userLogin.getId());
		return getOrders(orders);
	}

	@Override
	public Order getOrderById(Integer id) {
		Order order = orderRepo.findById(id).get();
		BigDecimal totalPrice = BigDecimal.ZERO;
		for (OrderDetail orderDetail : order.getOrderDetails()) {
			totalPrice = totalPrice.add(orderDetail.getUnitPrice().multiply(new BigDecimal(orderDetail.getQuantity())));
		}
		order.setTotalPriceOrder(totalPrice);
		return order;
	}

	@Override
	public void deleteOrderById(Integer id) {
		orderRepo.deleteOrderById(id);
	}

	@Override
	public List<Order> getOrdersDeletedByUserLogin(User userLogin) {
		List<Order> orders = orderRepo.getOrdersDeletedByUserLogin(userLogin.getId());
		return getOrders(orders);
	}
}
