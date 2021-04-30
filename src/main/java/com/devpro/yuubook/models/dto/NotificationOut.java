package com.devpro.yuubook.models.dto;

import java.util.List;

public class NotificationOut {
    private int id;
    private String email;
    private boolean status;
    private List<GenreOut> genres;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public List<GenreOut> getGenres() {
        return genres;
    }

    public void setGenres(List<GenreOut> genres) {
        this.genres = genres;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
