package com.devpro.yuubook.services.impl;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devpro.yuubook.dto.CustomerAddress;
import com.devpro.yuubook.entities.User;
import com.devpro.yuubook.entities.UserAddress;
import com.devpro.yuubook.repositories.DistrictRepo;
import com.devpro.yuubook.repositories.ProvinceRepo;
import com.devpro.yuubook.repositories.UserAddressRepo;
import com.devpro.yuubook.repositories.WardsRepo;
import com.devpro.yuubook.services.UserAddressService;
@Service
public class UserAddressServiceImpl implements UserAddressService{
	@Autowired
	private UserAddressRepo userAddressRepo;
	@Autowired
	private ProvinceRepo provinceRepo;
	@Autowired
	private DistrictRepo districtRepo;
	@Autowired 
	private WardsRepo wardsRepo;
	
	@Override
	public UserAddress save(UserAddress userAddress, User user) {
		userAddress.setUser(user);
		if(userAddress.getId()!=null) {
			UserAddress userAddressInDB = userAddressRepo.findById(userAddress.getId()).get();
			userAddress.setCreatedDate((userAddressInDB.getCreatedDate()));
			userAddress.setUpdatedDate(LocalDateTime.now());
		}else {
			userAddress.setCreatedDate(LocalDateTime.now());
		}
		return userAddressRepo.save(userAddress);
	}

	@Override
	public CustomerAddress getUserAddressByUserLogin(User user) {
		UserAddress userAddress = userAddressRepo.getUserAddressByUserId(user.getId());
		CustomerAddress cusAddress = new CustomerAddress();
		if(userAddress!=null) {
			cusAddress.setId(userAddress.getId());
			cusAddress.setFullname(user.getSurname() + " " + user.getName());
			cusAddress.setPhone(user.getPhone());
			cusAddress.setProvinceId(userAddress.getProvinceId());
			cusAddress.setDistrictId(userAddress.getDistrictId());
			cusAddress.setWardsId(userAddress.getWardsId());
			cusAddress.setProvince(provinceRepo.findById(userAddress.getProvinceId()).get().getName());
			cusAddress.setDistrict(districtRepo.findById(userAddress.getDistrictId()).get().getName());
			cusAddress.setWards(wardsRepo.findById(userAddress.getWardsId()).get().getName());
			cusAddress.setAddressDetail(userAddress.getAddressDetail());
			cusAddress.setNote(userAddress.getNote());
		}
		return cusAddress;
	}

}
