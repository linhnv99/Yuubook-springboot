package com.devpro.yuubook.services;

import com.devpro.yuubook.models.dto.NotificationIn;
import com.devpro.yuubook.models.dto.NotificationOut;
import com.devpro.yuubook.models.entities.Notification;

import java.util.List;


public interface NotificationService {
    Notification register(NotificationIn notificationIn);

    List<NotificationOut> findAll();

    Notification changeStatus(int id);

    void sendMail();
}
