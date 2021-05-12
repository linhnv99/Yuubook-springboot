package com.devpro.yuubook.controllers.clients;

import java.util.List;

import com.devpro.yuubook.models.bo.Oauth2UserDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.devpro.yuubook.models.dto.AjaxResponse;
import com.devpro.yuubook.models.entities.District;
import com.devpro.yuubook.models.entities.User;
import com.devpro.yuubook.models.entities.Wards;
import com.devpro.yuubook.repositories.DistrictRepo;
import com.devpro.yuubook.repositories.WardsRepo;
import com.devpro.yuubook.services.UserService;

@RestController
public class RestAPIController {
    @Autowired
    private DistrictRepo districtRepo;
    @Autowired
    private WardsRepo wardsRepo;
    @Autowired
    private UserService userService;

    @PostMapping("/district/{id}")
    public ResponseEntity<AjaxResponse> getDistrict(@PathVariable("id") Integer id) {
        List<District> districts = districtRepo.getAllById(id);
        return ResponseEntity.ok(new AjaxResponse(districts, 200));
    }

    @PostMapping("/wards/{id}")
    public ResponseEntity<AjaxResponse> getWards(@PathVariable("id") Integer id) {
        List<Wards> wards = wardsRepo.getAllById(id);
        return ResponseEntity.ok(new AjaxResponse(wards, 200));
    }

    @PostMapping("/favorite-book/{act}/{id}")
    public ResponseEntity<AjaxResponse> addFavoriteBook(@PathVariable("id") Integer id,
                                                        @PathVariable("act") String act) {
        if (getUserLogin() == null) {
            return ResponseEntity.ok(new AjaxResponse("Vui lòng đăng nhập.", 400));
        }
        if (act.equals("add")) {
            userService.addFavoriteBookByUserLogin(getUserLogin(), id);
        } else {
            userService.removeFavoriteBookByUserLogin(getUserLogin(), id);
        }
        return ResponseEntity.ok(new AjaxResponse("Thành công", 200));
    }

    public User getUserLogin() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User user = null;
        if (authentication instanceof UsernamePasswordAuthenticationToken) {
            User u = (User) authentication.getPrincipal();
            user = userService.getUserByEmail(u.getEmail());
        }

        if (authentication instanceof OAuth2AuthenticationToken) {
            Oauth2UserDetail oauth2UserDetail = (Oauth2UserDetail) authentication.getPrincipal();
            user = userService.getUserByEmail(oauth2UserDetail.getEmail());
        }
        return user;
    }
}
