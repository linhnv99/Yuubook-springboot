package com.devpro.yuubook.repositories;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.devpro.yuubook.models.entities.User;

import java.util.List;

@Repository
public interface UserRepo extends JpaRepository<User, Integer> {

	User getUserByEmail(String email);

	@Query("select u from User u where u.name = ?1")
	User loadUserByUsername(String userName);

	@Transactional
	@Modifying
	@Query(value = "update user set status = 0 where id = ?1", nativeQuery = true)
	void deleteById(int id);
	
	@Query(value = "select count(*) from user", nativeQuery = true)
	int getTotalNumberOfUsers();

	List<User> findAllByStatus(boolean status);
}
