package com.devpro.yuubook.utils;

import com.devpro.yuubook.models.entities.Book;
import com.devpro.yuubook.models.entities.Comment;

import java.text.DecimalFormat;

public class FuncUtils {
    public static int calculatorStar(Book book) {
        if (book.getComments().size() != 0) {
            int avg = 0;
            for (Comment comment : book.getComments()) {
                avg += comment.getStar();
            }
            return avg / book.getComments().size();
        }
        return 0;
    }

    public static String formatPrice(double value) {
        DecimalFormat df = new DecimalFormat("###,###,###");
        return df.format(value);
    }
}
