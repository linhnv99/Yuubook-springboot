package com.devpro.yuubook.controllers.admins;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.devpro.yuubook.models.dto.AjaxResponse;
import com.devpro.yuubook.services.OrderService;

@Controller
@RequestMapping("/admin")
public class AdminOrderController {
	@Autowired
	private OrderService orderService;

	@GetMapping("/order")
	public String index(ModelMap model) {
		model.addAttribute("orders", orderService.getOrdersConfirmed());
		return "admin/order";
	}

	@GetMapping("/order/confirm")
	public String confirmOrder(ModelMap model, @RequestParam("id") Integer id) {
		orderService.confirmOrderById(id);
		return "redirect:/admin/dashboard";
	}

	@PostMapping("/order/{id}/status/{val}")
	public ResponseEntity<AjaxResponse> setStatus(ModelMap model, @PathVariable("id") Integer id,
			@PathVariable("val") Integer val) {
		orderService.setOrderStatusById(id, val);
		return ResponseEntity.ok(new AjaxResponse("Thành công", 200));
	}
}
