package com.devpro.yuubook.services.impl;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.devpro.yuubook.models.dto.CustomerAddress;
import com.devpro.yuubook.models.entities.User;
import com.devpro.yuubook.models.entities.UserAddress;
import com.devpro.yuubook.repositories.DistrictRepo;
import com.devpro.yuubook.repositories.ProvinceRepo;
import com.devpro.yuubook.repositories.UserAddressRepo;
import com.devpro.yuubook.repositories.WardsRepo;
import com.devpro.yuubook.services.UserAddressService;

@Service
public class UserAddressServiceImpl implements UserAddressService {
    @Autowired
    private UserAddressRepo userAddressRepo;
    @Autowired
    private ProvinceRepo provinceRepo;
    @Autowired
    private DistrictRepo districtRepo;
    @Autowired
    private WardsRepo wardsRepo;

    @Override
    public UserAddress save(UserAddress userAddressIn, User user) {
        UserAddress userAddress = userAddressRepo.findById(userAddressIn.getId()).orElse(null);
        userAddressIn.setUser(user);
        if (userAddress != null) {
            userAddressIn.setCreatedDate((userAddress.getCreatedDate()));
            userAddressIn.setUpdatedDate(LocalDateTime.now());
        }
        userAddressIn.setCreatedDate(LocalDateTime.now());
        return userAddressRepo.save(userAddressIn);
    }

    @Override
    public CustomerAddress getUserAddressByUserLogin(User user) {
        UserAddress userAddress = userAddressRepo.getUserAddressByUserId(user.getId());
        CustomerAddress cusAddress = new CustomerAddress();
        if (userAddress != null) {
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
