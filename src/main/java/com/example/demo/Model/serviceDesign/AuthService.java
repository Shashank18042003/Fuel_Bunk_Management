package com.example.demo.Model.serviceDesign;

import com.example.demo.Model.pojos.User;

public interface AuthService {
	
    User registerUser(User user);
    public User login(String email, String password);
    User getUserByEmail(String email);

}
