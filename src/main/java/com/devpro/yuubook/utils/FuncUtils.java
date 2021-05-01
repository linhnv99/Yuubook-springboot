package com.devpro.yuubook.utils;

import com.devpro.yuubook.models.entities.Book;
import com.devpro.yuubook.models.entities.Comment;

import java.text.DecimalFormat;
import java.text.Normalizer;
import java.util.Calendar;
import java.util.Locale;
import java.util.regex.Pattern;


public class FuncUtils {
    private static final Pattern NON_LATIN = Pattern.compile("[^\\w_-]");
    private static final Pattern SEPARATORS = Pattern.compile("[\\s\\p{Punct}&&[^-]]");

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

    public static String toSlug(String input) {
        String noseparators = SEPARATORS.matcher(input).replaceAll("-").replace("đ", "d").replace("Đ", "D");;
        String normalized = Normalizer.normalize(noseparators, Normalizer.Form.NFD);
        String slug = NON_LATIN.matcher(normalized).replaceAll("");
        return slug.toLowerCase(Locale.ENGLISH).replaceAll("-{2,}", "-")
                .replaceAll("^-|-$", "") + "-" + Calendar.getInstance().getTime().getTime();
    }
}
