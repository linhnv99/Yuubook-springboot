package com.devpro.yuubook.models.bo;

import com.devpro.yuubook.models.entities.User;
import com.devpro.yuubook.repositories.UserRepo;
import com.devpro.yuubook.services.UserService;
import com.devpro.yuubook.services.mappers.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class Oauth2LoginSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    @Autowired
    private UserRepo repo;

    @Autowired
    private UserMapper mapper;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
            throws IOException, ServletException {

        Oauth2UserDetail oauth2UserDetail = (Oauth2UserDetail) authentication.getPrincipal();

        String email = oauth2UserDetail.getEmail();

        User user = repo.findByEmail(email);

        if (user == null) {
            user = mapper.map(oauth2UserDetail);
            repo.save(user);
        }

        super.onAuthenticationSuccess(request, response, authentication);
    }
}
