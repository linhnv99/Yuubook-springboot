package com.devpro.yuubook.services.mappers;

import com.devpro.yuubook.models.dto.NotificationIn;
import com.devpro.yuubook.models.entities.NotificationGenre;
import org.springframework.stereotype.Component;

@Component
public class NotificationGenreMapper {
    public NotificationGenre map(NotificationIn notificationIn, int notificationId) {
        NotificationGenre notificationGenre = new NotificationGenre();
        notificationGenre.setGenreId(notificationIn.getCategoryId());
        notificationGenre.setNotificationId(notificationId);
        return notificationGenre;
    }
}
