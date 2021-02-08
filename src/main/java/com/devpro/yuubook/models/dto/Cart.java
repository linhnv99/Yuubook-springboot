package com.devpro.yuubook.models.dto;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class Cart {
	private List<CartItem> cartItems = new ArrayList<CartItem>();
	private BigDecimal totalPriceCart;
	public List<CartItem> getCartItems() {
		return cartItems;
	}

	public void setCartItems(List<CartItem> cartItems) {
		this.cartItems = cartItems;
	}

	public BigDecimal getTotalPriceCart() {
		return totalPriceCart;
	}

	public void setTotalPriceCart(BigDecimal totalPriceCart) {
		this.totalPriceCart = totalPriceCart;
	}
	public void calTotalPrice() {
		BigDecimal totalPrice = new BigDecimal(0);
		for (CartItem cartItem : cartItems) {
			totalPrice = totalPrice.add(cartItem.getPrice().multiply(new BigDecimal(cartItem.getQuantity())));
		}
		this.setTotalPriceCart(totalPrice);
	}
}
