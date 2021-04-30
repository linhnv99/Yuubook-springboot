package com.devpro.yuubook.models.bo;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;

import java.util.Collection;
import java.util.Map;

public class Oauth2UserDetail implements OAuth2User {

    private OAuth2User oAuth2User;

    public Oauth2UserDetail(OAuth2User oAuth2User) {
        this.oAuth2User = oAuth2User;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return oAuth2User.getAuthorities();
    }

    @Override
    public Map<String, Object> getAttributes() {
        return oAuth2User.getAttributes();
    }

    @Override
    public String getName() {
        return oAuth2User.getAttribute("given_name");
    }

    public String getSurname() {
        return oAuth2User.getAttribute("family_name");
    }

    public String getEmail() {
        return oAuth2User.getAttribute("email");
    }

    public String getAvatar() {
        return oAuth2User.getAttribute("picture");
    }
}
