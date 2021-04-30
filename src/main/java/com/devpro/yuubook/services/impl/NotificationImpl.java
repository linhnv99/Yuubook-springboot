package com.devpro.yuubook.services.impl;

import com.devpro.yuubook.models.dto.BookOut;
import com.devpro.yuubook.models.dto.GenreOut;
import com.devpro.yuubook.models.dto.NotificationIn;
import com.devpro.yuubook.models.dto.NotificationOut;
import com.devpro.yuubook.models.entities.Book;
import com.devpro.yuubook.models.entities.Category;
import com.devpro.yuubook.models.entities.Notification;
import com.devpro.yuubook.models.entities.NotificationGenre;
import com.devpro.yuubook.repositories.BookRepo;
import com.devpro.yuubook.repositories.CategoryRepo;
import com.devpro.yuubook.repositories.NotificationGenreRepo;
import com.devpro.yuubook.repositories.NotificationRepo;
import com.devpro.yuubook.services.NotificationService;
import com.devpro.yuubook.services.mappers.CategoryMapper;
import com.devpro.yuubook.services.mappers.NotificationGenreMapper;
import com.devpro.yuubook.services.mappers.NotificationMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;


@Service
public class NotificationImpl implements NotificationService {

    @Autowired
    private NotificationRepo notificationRepo;

    @Autowired
    private CategoryRepo categoryRepo;

    @Autowired
    private NotificationGenreRepo notificationGenreRepo;

    @Autowired
    private BookRepo bookRepo;

    @Autowired
    private MailService mailService;

    @Autowired
    private NotificationMapper mapper;

    @Autowired
    private CategoryMapper categoryMapper;

    @Autowired
    private NotificationGenreMapper notifyGenreMapper;

    @Override
    public Notification register(NotificationIn notificationIn) {
        Notification notification = notificationRepo.findByEmail(notificationIn.getEmail());

        if (notification == null) {
            notification = mapper.map(notificationIn);

            notification = notificationRepo.save(notification);
            saveNotificationGenre(notificationIn, notification.getId());

            return notification;
        }

//        check exist notification for genre
        NotificationGenre notificationGenre = notificationGenreRepo.findByNotificationIdAndGenreId
                (notification.getId(), notificationIn.getCategoryId());

        if (notificationGenre == null)
            saveNotificationGenre(notificationIn, notification.getId());

        return notification;
    }

    @Override
    public List<NotificationOut> findAll() {
        List<Notification> notifications = notificationRepo.findAll();
        List<NotificationGenre> notificationGenres = notificationGenreRepo.findAll();
        List<Category> categories = categoryRepo.findAllParentCategories();
        return getNotificationOuts(notifications, notificationGenres, categories);
    }

    @Override
    public Notification changeStatus(int notifyId) {
        Notification notification = notificationRepo.findById(notifyId).orElse(null);

        if (notification == null) return null;

        notification.setStatus(!notification.isStatus());

        return notificationRepo.save(notification);

    }

    @Override
    public void sendMail() {
        List<Notification> notifications = notificationRepo.findAllByStatus();
        List<NotificationGenre> notificationGenres = notificationGenreRepo.findAll();
        List<Category> categories = categoryRepo.findAllParentCategories();
        List<Book> books = bookRepo.findByCreateDate(LocalDate.now());

        List<NotificationOut> notificationOuts = getNotificationOuts(notifications, notificationGenres, categories);

        if (books.isEmpty()) return;

        notificationOuts.forEach(notify -> {

            List<BookOut> bookOuts = getBookOuts(notify.getGenres(), books);

            if (!bookOuts.isEmpty())
                mailService.sendMail(notify.getEmail(), bookOuts);
        });
    }

    private List<BookOut> getBookOuts(List<GenreOut> genres, List<Book> books) {

        Set<Integer> genreIds = genres.stream().map(GenreOut::getId).collect(Collectors.toSet());

        return books.stream()
                .filter(it -> genreIds.contains(it.getCategory().getParentId().getId()))
                .map(it -> {
                    BookOut bookOut = new BookOut();
                    bookOut.setId(it.getId());
                    bookOut.setName(it.getName());
                    return bookOut;
                }).collect(Collectors.toList());
    }


    /**
     * get notification by each email
     *
     * @param notificationGenres
     * @param categories
     * @param notifications
     * @return
     */
    private List<NotificationOut> getNotificationOuts(List<Notification> notifications, List<NotificationGenre> notificationGenres,
                                                      List<Category> categories) {

//        map genreId by notificationId
        Map<Integer, Set<Integer>> mapGenreIdByNotificationId = notificationGenres.stream()
                .collect(Collectors.groupingBy(NotificationGenre::getNotificationId,
                        Collectors.mapping(NotificationGenre::getGenreId, Collectors.toSet())));


        return notifications.stream()
                .map(it -> mapper.map(it, mapGenreIdByNotificationId.get(it.getId()), categories))
                .collect(Collectors.toList());
    }


    private void saveNotificationGenre(NotificationIn notificationIn, int notificationId) {
        NotificationGenre notificationGenre = notifyGenreMapper.map(notificationIn, notificationId);
        notificationGenreRepo.save(notificationGenre);
    }
}
