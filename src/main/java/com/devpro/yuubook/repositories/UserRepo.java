package com.devpro.yuubook.repositories;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.devpro.yuubook.entities.User;

@Repository
public interface UserRepo extends JpaRepository<User, Integer> {

	User findUserByEmail(String email);

	@Query("select u from User u where u.name = ?1")
	User loadUserByUsername(String userName);

	@Transactional
	@Modifying
	@Query(value = "delete from user where id = ?1", nativeQuery = true)
	void deleteUserById(Integer id);
	
	@Query(value = "select count(*) from user", nativeQuery = true)
	Integer getTotalNumberOfUsers();

}
