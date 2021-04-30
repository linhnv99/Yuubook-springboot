package com.devpro.yuubook.repositories;

import com.devpro.yuubook.models.entities.Notification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NotificationRepo extends JpaRepository<Notification, Integer> {

    Notification findByEmail(String email);

    @Query(value = "select * from notification where status = 1", nativeQuery = true)
    List<Notification> findAllByStatus();
}
