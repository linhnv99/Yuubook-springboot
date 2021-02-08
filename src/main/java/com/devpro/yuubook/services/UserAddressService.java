package com.devpro.yuubook.services;

import com.devpro.yuubook.models.dto.CustomerAddress;
import com.devpro.yuubook.models.entities.User;
import com.devpro.yuubook.models.entities.UserAddress;

public interface UserAddressService {

	UserAddress save(UserAddress userAddress, User user);

	CustomerAddress getUserAddressByUserLogin(User user);

}
