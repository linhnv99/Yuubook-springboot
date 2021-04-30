package com.devpro.yuubook.services.mappers;

import com.devpro.yuubook.models.dto.GenreOut;
import com.devpro.yuubook.models.dto.NotificationIn;
import com.devpro.yuubook.models.dto.NotificationOut;
import com.devpro.yuubook.models.entities.Category;
import com.devpro.yuubook.models.entities.Notification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Component
public class NotificationMapper {

    @Autowired
    private CategoryMapper categoryMapper;

    public Notification map(NotificationIn notificationIn) {
        Notification notification = new Notification();
        notification.setEmail(notificationIn.getEmail());
        notification.setStatus(true);
        return notification;
    }

    public NotificationOut map(Notification notification, Set<Integer> genreIds, List<Category> categories) {
        List<GenreOut> genreOuts = categoryMapper.map(categories);

        NotificationOut notificationOut = new NotificationOut();
        notificationOut.setId(notification.getId());
        notificationOut.setEmail(notification.getEmail());
        notificationOut.setStatus(notification.isStatus());

        if (genreIds.contains(0))
            notificationOut.setGenres(genreOuts);
        else {
            List<GenreOut> genreOuts1 = genreOuts.stream().filter(it -> genreIds.contains(it.getId())).collect(Collectors.toList());
            notificationOut.setGenres(genreOuts1);
        }

        return notificationOut;
    }
}
