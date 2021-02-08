package com.devpro.yuubook.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.devpro.yuubook.models.entities.Wards;

public interface WardsRepo extends JpaRepository<Wards, Integer>{

	@Query(value = "select * from wards where district_id = ?1", nativeQuery = true)
	List<Wards> getAllById(int id);

}
