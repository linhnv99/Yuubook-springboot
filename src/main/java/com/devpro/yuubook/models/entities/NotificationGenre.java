package com.devpro.yuubook.models.entities;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "notification_genre")
public class NotificationGenre {

    @Id
    @Column
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "notification_id")
    private int notificationId;

    @Column(name = "genre_id")
    private int genreId;
}
