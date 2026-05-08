package com.example.demo.Model.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.demo.Model.enums.Role;
import com.example.demo.Model.pojos.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

	Optional<User> findByEmail(String email);

	boolean existsByEmail(String email);

	List<User> findByRole(Role role);

	List<User> findByBranchIdAndRole(Long branchId, Role role);

	List<User> findByRoleAndActiveTrue(Role role);

	@Query("SELECT u FROM User u WHERE u.role = 'USER' AND u.active = true ORDER BY u.createdAt DESC")
	List<User> findAllActiveUsers();

	long countByRole(Role role);
}