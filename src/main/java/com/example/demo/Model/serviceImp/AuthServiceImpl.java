package com.example.demo.Model.serviceImp;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Model.pojos.User;
import com.example.demo.Model.repository.UserRepository;
import com.example.demo.Model.serviceDesign.AuthService;

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public User registerUser(User user) {

        Optional<User> existingUser =
                userRepository.findByEmail(user.getEmail());

        if (existingUser.isPresent()) {
            throw new RuntimeException("Email already exists");
        }

        user.setStatus("ACTIVE");
        user.setCreatedAt(java.time.LocalDateTime.now());

        return userRepository.save(user);
    }

    @Override
    public User login(String email, String password) {

        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Invalid Email"));

        // Password check
        if (!user.getPassword().equals(password)) {
            throw new RuntimeException("Invalid Password");
        }

        // Manager must have branch
        if (user.getRole().equalsIgnoreCase("MANAGER") && user.getBranch() == null) {
            throw new RuntimeException("Branch not assigned");
        }

        return user; // ✅ return full user
    }
    
    @Override
    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User Not Found"));
    }
}