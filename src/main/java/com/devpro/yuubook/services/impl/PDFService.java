package com.devpro.yuubook.services.impl;

import com.devpro.yuubook.models.entities.Order;
import com.devpro.yuubook.models.entities.OrderDetail;
import com.devpro.yuubook.repositories.OrderRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

@Service
public class PDFService {

    @Autowired
    private OrderRepo repo;

    public void export(int id, HttpServletResponse response) throws IOException {
        setHeader(response);

        Order order = repo.findOrderByIdAndStatus(id, true);
        calculatePricedOrder(order);

        PDFExporter exporter = new PDFExporter(order);
        exporter.exportPDF(response);
    }

    private void setHeader(HttpServletResponse response) {
        response.setContentType("application/pdf");
        DateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
        String currentDateTime = dateFormatter.format(new Date());

        String headerKey = "Content-Disposition";
        String headerValue = "inline; filename=order_" + currentDateTime + ".pdf";
        response.setHeader(headerKey, headerValue);
    }

    private void calculatePricedOrder(Order order) {
        BigDecimal totalPrice = BigDecimal.ZERO;
        for (OrderDetail orderDetail : order.getOrderDetails()) {
            totalPrice = totalPrice.add(orderDetail.getUnitPrice().multiply(new BigDecimal(orderDetail.getQuantity())));
        }
        order.setTotalPriceOrder(totalPrice);
    }
}
