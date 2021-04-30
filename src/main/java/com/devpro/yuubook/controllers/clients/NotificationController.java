package com.devpro.yuubook.controllers.clients;

import com.devpro.yuubook.models.dto.AjaxResponse;
import com.devpro.yuubook.models.dto.NotificationIn;
import com.devpro.yuubook.models.entities.Notification;
import com.devpro.yuubook.services.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/notifications")
public class NotificationController {
    @Autowired
    private NotificationService service;

    @PostMapping("/registers")
    public ResponseEntity<AjaxResponse> register(@RequestBody NotificationIn notificationIn) {
        Notification notification = service.register(notificationIn);

        if (notification == null)
            return ResponseEntity.ok(new AjaxResponse("Đã xảy ra lỗi. Thử lại sau!", 400));

        return ResponseEntity.ok(new AjaxResponse("Đăng ký thành công. Chúc bạn ngày mới vui vẻ!!!", 200));
    }
}
