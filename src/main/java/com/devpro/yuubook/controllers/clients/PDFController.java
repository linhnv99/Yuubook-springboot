package com.devpro.yuubook.controllers.clients;

import com.devpro.yuubook.services.OrderService;
import com.devpro.yuubook.services.impl.PDFService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class PDFController {

    @Autowired
    private PDFService service;

    @Autowired
    private OrderService orderService;

    @GetMapping("/exports/{id}")
    public String export(ModelMap model, @PathVariable("id") int id) {
        model.addAttribute("order", orderService.getOrderById(id));
        return "user/export-order";
    }

}
