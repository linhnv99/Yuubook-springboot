package com.devpro.yuubook.services.impl;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.devpro.yuubook.models.dto.OrderFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.devpro.yuubook.models.dto.CartItem;
import com.devpro.yuubook.models.dto.CustomerAddress;
import com.devpro.yuubook.models.entities.Order;
import com.devpro.yuubook.models.entities.OrderDetail;
import com.devpro.yuubook.models.entities.User;
import com.devpro.yuubook.repositories.OrderRepo;
import com.devpro.yuubook.services.BookService;
import com.devpro.yuubook.services.OrderService;
import com.devpro.yuubook.services.UserService;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

@Service
public class OrderServiceImpl implements OrderService {
	@Autowired
	private OrderRepo orderRepo;
	@Autowired
	private UserService userService;
	@Autowired
	private BookService bookService;

	@PersistenceContext
	private EntityManager entityManager;

	@Override
	public void saveOrder(List<CartItem> cartItems, CustomerAddress customerAddress) {
		User user = null;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
			User userLogin = (User) authentication.getPrincipal();
			user = userService.getUserByEmail(userLogin.getEmail());
		}

		Order order = new Order();
		order.setUser(user);
		order.setBuyDate(LocalDateTime.now());
		order.setFullName(customerAddress.getFullname());
		order.setPhone(customerAddress.getPhone());
		order.setProvince(customerAddress.getProvince());
		order.setDistrict(customerAddress.getDistrict());
		order.setWards(customerAddress.getWards());
		order.setAddressDetail(customerAddress.getAddressDetail());
		order.setNote(customerAddress.getNote());
		order.setOrderStatus(0);
		order.setCreatedDate(LocalDateTime.now());

		List<OrderDetail> orderDetails = new ArrayList<>();
		for (CartItem cartItem : cartItems) {
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setBook(bookService.getById(cartItem.getBookId()));
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
		return calculatePricedOrders(orders);
	}

	@Override
	public List<Order> getOrdersNeedConfirm() {
		List<Order> orders = orderRepo.getOrdersNeedConfirm();
		return calculatePricedOrders(orders);
	}

	private List<Order> calculatePricedOrders(List<Order> orders) {
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
		BigDecimal totalSale = BigDecimal.ZERO;
		for (Order order : orders) {
			BigDecimal itemPrice = BigDecimal.ZERO;
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
		return calculatePricedOrders(orders);
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
		return calculatePricedOrders(orders);
	}

	@Override
	public List<Order> filter(OrderFilter filter) {
		String sql = "select * from `order` where 1 = 1 and status = 1 and not order_status = 0 ";

		if(filter.getFromDate() != null){
			sql += "and buy_date >= '" + filter.getFromDate() + "'";
		}
		if(filter.getToDate() != null){
			sql += "and buy_date <= '" + filter.getToDate() + "'";
		}

		if(filter.getFromDate() != null && filter.getToDate() != null && filter.getFromDate().isAfter(filter.getToDate()))
			return null;

		sql += " order by buy_date desc ";
		System.out.println(sql);
		Query query = entityManager.createNativeQuery(sql, Order.class);
		List<Order> orders = query.getResultList();
		return calculatePricedOrders(orders);
	}
}
