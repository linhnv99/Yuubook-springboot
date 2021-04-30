package com.devpro.yuubook.services.mappers;

import com.devpro.yuubook.models.bo.Oauth2UserDetail;
import com.devpro.yuubook.models.bo.Provider;
import com.devpro.yuubook.models.entities.Role;
import com.devpro.yuubook.models.entities.User;
import com.devpro.yuubook.repositories.RoleRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Component
public class UserMapper {

    @Autowired
    private RoleRepo roleRepo;

    public User map(Oauth2UserDetail oauth2UserDetail) {
        User user = new User();

        user.setName(oauth2UserDetail.getName());

        List<Role> roles = new ArrayList<>();
        roles.add(roleRepo.findRoleByName("ROLE_USER"));
        user.setRoles(roles);

        user.setSurname(oauth2UserDetail.getSurname());
        user.setEmail(oauth2UserDetail.getEmail());
        user.setAvatar(oauth2UserDetail.getAvatar());
        user.setProvider(Provider.GOOGLE.name());
        user.setStatus(true);

        return user;
    }
}
