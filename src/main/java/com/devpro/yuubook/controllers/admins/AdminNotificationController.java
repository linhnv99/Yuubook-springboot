package com.devpro.yuubook.controllers.admins;

import com.devpro.yuubook.models.dto.AjaxResponse;
import com.devpro.yuubook.models.entities.Notification;
import com.devpro.yuubook.services.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/notifications")
public class AdminNotificationController {
    @Autowired
    private NotificationService service;

    @Autowired
    private NotificationService notificationService;

    @GetMapping
    public String findAll(ModelMap model) {

        model.addAttribute("notifications", service.findAll());

        return "admin/notification";
    }

    @PostMapping("/statuses/{id}/changers")
    public ResponseEntity<AjaxResponse> changeStatus(@PathVariable int id) {

        Notification notification = service.changeStatus(id);

        if (notification == null)
            return ResponseEntity.ok(new AjaxResponse("ERROR", 200));

        return ResponseEntity.ok(new AjaxResponse("SUCCESS", 200));
    }


    @PostMapping("/sends")
    public ResponseEntity<Object> sendMail() {
        System.out.println("==================Boot send mail================");
        notificationService.sendMail();

        return ResponseEntity.ok("SUCCESS");
    }

}
