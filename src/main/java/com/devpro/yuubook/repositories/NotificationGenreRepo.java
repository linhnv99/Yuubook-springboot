package com.devpro.yuubook.repositories;

import com.devpro.yuubook.models.entities.Notification;
import com.devpro.yuubook.models.entities.NotificationGenre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NotificationGenreRepo extends JpaRepository<NotificationGenre, Integer> {

    NotificationGenre findByNotificationIdAndGenreId(int notificationId, int genreId);
}
