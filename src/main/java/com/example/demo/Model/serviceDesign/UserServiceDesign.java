package com.example.demo.Model.serviceDesign;

import java.util.List;
import java.util.Optional;

import com.example.demo.Model.enums.Role;
import com.example.demo.Model.pojos.User;

public interface UserServiceDesign {

	// REGISTER USER

	User register(User user);

	// FIND BY EMAIL

	Optional<User> findByEmail(String email);

	// FIND BY ID

	Optional<User> findById(Long id);

	// FIND ALL USERS

	List<User> findAll();

	// FIND MANAGERS

	List<User> findManagers();

	// FIND ACTIVE USERS

	List<User> findActiveUsers();

	// SAVE USER

	User save(User user);

	// UPDATE USER

	User update(Long id, User updatedUser);

	// TOGGLE ACTIVE

	void toggleActive(Long id);

	// CHANGE PASSWORD

	void changePassword(Long id, String oldPassword, String newPassword);

	// COUNT BY ROLE

	long countByRole(Role role);

}
