package com.devpro.yuubook.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.devpro.yuubook.dto.AjaxResponse;
import com.devpro.yuubook.entities.District;
import com.devpro.yuubook.entities.User;
import com.devpro.yuubook.entities.Wards;
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
	public ResponseEntity<AjaxResponse> getDistrict(ModelMap model, @PathVariable("id") Integer id) {
		List<District> districts = districtRepo.getAllById(id);
		return ResponseEntity.ok(new AjaxResponse(districts, 200));
	}

	@PostMapping("/wards/{id}")
	public ResponseEntity<AjaxResponse> getWards(ModelMap model, @PathVariable("id") Integer id) {
		List<Wards> wards = wardsRepo.getAllById(id);
		return ResponseEntity.ok(new AjaxResponse(wards, 200));
	}
	
	@PostMapping("/favorite-book/{act}/{id}")
	public ResponseEntity<AjaxResponse> addFavoriteBook(ModelMap model, @PathVariable("id") Integer id,
			@PathVariable("act") String act) {
		if(getUserLogin()== null) {
			return ResponseEntity.ok(new AjaxResponse("Vui lòng đăng nhập.", 400));
		}
		if(act.equals("add")) {
			userService.addFavoritedBookByUserLogin(getUserLogin(),id);
		}else {
			userService.removeFavoritedBookByUserLogin(getUserLogin(),id);
		}
		return ResponseEntity.ok(new AjaxResponse("Thành công", 200));
	}
	public User getUserLogin() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		User user = null;
		if (!(authentication instanceof AnonymousAuthenticationToken)) {
			User userLogin = (User) authentication.getPrincipal();
			user = userService.findUserByEmail(userLogin.getEmail());
		}
		return user;
	}
}
