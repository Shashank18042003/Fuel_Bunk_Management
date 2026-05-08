package com.example.demo.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.Model.pojos.User;
import com.example.demo.Model.serviceDesign.AuthService;

import jakarta.servlet.http.HttpSession;


@Controller
public class AuthController {
	
	@Autowired
	private AuthService authService;

	@GetMapping("/")
	public String loginPage(Model model) {

		model.addAttribute("user", new User());

		return "login";
	}

	@GetMapping("/register")
	public String registerPage(Model model) {

		model.addAttribute("user", new User());

		return "register";
	}

	@PostMapping("/registerUser")
	public String registerUser(@ModelAttribute User user, Model model) {

		authService.registerUser(user);

		model.addAttribute("success", "Registration Successful");

		return "login";
	}

	@PostMapping("/login")
	public String login(@RequestParam String email,
	                    @RequestParam String password,
	                    HttpSession session,
	                    Model model) {

	    try {
	        User user = authService.login(email, password);

	        // ✅ store user in session
	        session.setAttribute("loggedUser", user);
	        
	        // ✅ role-based redirect
	        if (user.getRole().equalsIgnoreCase("USER")) {
	            return "user/userDashboard";
	        } 
	        else if (user.getRole().equalsIgnoreCase("ADMIN")) {
	            return "admin/admindashboard";
	        } 
	        else if (user.getRole().equalsIgnoreCase("MANAGER")) {
	            return "manager/managerDashboard";
	        }

	    } catch (RuntimeException e) {
	        model.addAttribute("message", e.getMessage());
	        return "login";
	    }

	    return "login";
	}
}
