package com.example.demo.Model.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.example.demo.Model.pojos.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	Optional<User> findByEmail(String email);

	List<User> findByStatus(String status);

	List<User> findByBranchId(int branchId);

	@Query("select u from User u where u.role.roleName='DELIVERY_AGENT'")
	List<User> getAllDeliveryAgents();

}
