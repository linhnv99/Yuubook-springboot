package com.devpro.yuubook.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.devpro.yuubook.models.entities.Role;

@Repository
public interface RoleRepo extends JpaRepository<Role, Integer> {
	Role findRoleByName(String roleName);
}
