package com.devpro.yuubook.controller.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.devpro.yuubook.services.BookService;
import com.devpro.yuubook.services.OrderService;
import com.devpro.yuubook.services.UserService;

@Controller
@RequestMapping(value = { "/admin" })
public class AdminHomeController {
	@Autowired
	private OrderService orderService;
	@Autowired
	private UserService userService;
	@Autowired
	private BookService bookService;

	@GetMapping("/dashboard")
	public String index(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		model.addAttribute("orders", orderService.getOrdersNeedConfirm());
		model.addAttribute("totalNumberOfOrders", orderService.getTotalNumberOfOrders());
		model.addAttribute("totalNumberOfUsers", userService.getTotalNumberOfUsers());
		model.addAttribute("totalNumberOfProducts", bookService.getTotalNumberOfProducts(true));
		model.addAttribute("totalSales", orderService.getTotalSales());
		return "admin/index";
	}
}
