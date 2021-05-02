package com.devpro.yuubook.services.impl;

import com.devpro.yuubook.models.dto.BookOut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.List;

@Service
public class MailService {

    @Autowired
    private JavaMailSender mailSender;

    public boolean sendMail(String email, List<BookOut> bookOuts) {

        MimeMessage message = mailSender.createMimeMessage();

        try {
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");

            String emailName = email.substring(0, email.lastIndexOf("@"));

            StringBuilder bookLinks = new StringBuilder("<ul>");

            for (BookOut it : bookOuts)
                bookLinks.append("<li><a href=\"http://yuubook.com.vn/san-pham/")
                        .append(it.getSlug()).append("\">")
                        .append(it.getName()).append("</a>")
                        .append("</li>");

            bookLinks.append("</ul>");

            String htmlMsg = "<b style=\"color:#500050\">Xin chào " + emailName + ",</b>" +
                    "<br>" +
                    "<p>Lại là mình đây hihi. Hôm nay mình sẽ mang tới cho bạn những cuốn sách tuyệt vời nhất! </p>" + bookLinks;

            message.setContent(htmlMsg, "text/html; charset=UTF-8");

            helper.setTo(email);

            helper.setSubject("[Yuubook] - Sách hay mỗi ngày");

            mailSender.send(message);

        } catch (MessagingException e) {
            return false;
        }

        return true;
    }
}
