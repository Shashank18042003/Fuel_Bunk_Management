package com.example.demo.Model.serviceImp;


import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.Model.enums.Role;
import com.example.demo.Model.pojos.User;
import com.example.demo.Model.repository.UserRepository;
import com.example.demo.Model.serviceDesign.UserServiceDesign;

@Service
@Transactional
public class UserService
        implements UserServiceDesign {

    // ================= REPOSITORY =================

    @Autowired
    private UserRepository userRepository;

    // ================= PASSWORD ENCODER =================

    @Autowired
    private PasswordEncoder passwordEncoder;

    // ================= REGISTER =================

    @Override
    public User register(User user) {

        if(userRepository.existsByEmail(
                user.getEmail())) {

            throw new RuntimeException(
                    "Email already registered: "
                    + user.getEmail());
        }

        user.setPassword(
                passwordEncoder.encode(
                        user.getPassword()));

        user.setRole(Role.USER);

        user.setActive(true);

        User savedUser =
                userRepository.save(user);

        System.out.println(
                "New user registered: "
                + savedUser.getEmail());

        return savedUser;
    }

    // ================= FIND BY EMAIL =================

    @Override
    @Transactional(readOnly = true)
    public Optional<User> findByEmail(
            String email) {

        return userRepository.findByEmail(email);
    }

    // ================= FIND BY ID =================

    @Override
    @Transactional(readOnly = true)
    public Optional<User> findById(Long id) {

        return userRepository.findById(id);
    }

    // ================= FIND ALL =================

    @Override
    @Transactional(readOnly = true)
    public List<User> findAll() {

        return userRepository.findAll();
    }

    // ================= FIND MANAGERS =================

    @Override
    @Transactional(readOnly = true)
    public List<User> findManagers() {

        return userRepository.findByRole(
                Role.MANAGER);
    }

    // ================= FIND ACTIVE USERS =================

    @Override
    @Transactional(readOnly = true)
    public List<User> findActiveUsers() {

        return userRepository.findAllActiveUsers();
    }

    // ================= SAVE USER =================

    @Override
    public User save(User user) {

        return userRepository.save(user);
    }

    // ================= UPDATE USER =================

    @Override
    public User update(Long id,
                       User updatedUser) {

        User user =
                userRepository.findById(id)
                .orElseThrow(() ->
                        new RuntimeException(
                                "User not found: "
                                + id));

        user.setFullName(
                updatedUser.getFullName());

        user.setPhone(
                updatedUser.getPhone());

        user.setVehicleType(
                updatedUser.getVehicleType());

        user.setVehicleNumber(
                updatedUser.getVehicleNumber());

        return userRepository.save(user);
    }

    // ================= TOGGLE ACTIVE =================

    @Override
    public void toggleActive(Long id) {

        User user =
                userRepository.findById(id)
                .orElseThrow(() ->
                        new RuntimeException(
                                "User not found: "
                                + id));

        user.setActive(!user.isActive());

        userRepository.save(user);
    }

    // ================= CHANGE PASSWORD =================

    @Override
    public void changePassword(Long id,
                               String oldPassword,
                               String newPassword) {

        User user =
                userRepository.findById(id)
                .orElseThrow(() ->
                        new RuntimeException(
                                "User not found: "
                                + id));

        if(!passwordEncoder.matches(
                oldPassword,
                user.getPassword())) {

            throw new RuntimeException(
                    "Current password is incorrect");
        }

        user.setPassword(
                passwordEncoder.encode(
                        newPassword));

        userRepository.save(user);
    }

    // ================= COUNT BY ROLE =================

    @Override
    @Transactional(readOnly = true)
    public long countByRole(Role role) {

        return userRepository.countByRole(role);
    }

}