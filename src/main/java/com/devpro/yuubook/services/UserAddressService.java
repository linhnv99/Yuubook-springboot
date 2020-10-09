package com.devpro.yuubook.services;

import com.devpro.yuubook.dto.CustomerAddress;
import com.devpro.yuubook.entities.User;
import com.devpro.yuubook.entities.UserAddress;

public interface UserAddressService {

	UserAddress save(UserAddress userAddress, User user);

	CustomerAddress getUserAddressByUserLogin(User user);

}
