package com.devpro.yuubook.utils;

public class BodyTemplate<T> {
    private String type;
    private String action;
    private T data;

    public BodyTemplate(String type, String action, T data) {
        this.type = type;
        this.action = action;
        this.data = data;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
