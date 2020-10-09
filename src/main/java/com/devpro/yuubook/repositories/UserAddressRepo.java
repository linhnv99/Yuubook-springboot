package com.devpro.yuubook.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.devpro.yuubook.entities.UserAddress;

@Repository
public interface UserAddressRepo extends JpaRepository<UserAddress, Integer> {

	@Query(value = "select * from user_address where user_id = ?1", nativeQuery = true)
	UserAddress getUserAddressByUserId(Integer id);
	
}
