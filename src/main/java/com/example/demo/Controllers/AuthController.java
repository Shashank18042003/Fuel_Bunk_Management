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
	public String login(@RequestParam String email, @RequestParam String password,String role, Model model) {

		String response = authService.login(email, password);

		model.addAttribute("message", response);

		if (response.equals("USER_DASHBOARD")) {
	        return "user/user-dashboard";
	    } 
	    else if (response.equals("ADMIN_DASHBOARD")) {
	        return "admin/admin-dashboard";
	    } 
	    else if (response.startsWith("MANAGER_DASHBOARD")) {
	        return "manager/manager-dashboard";
	    }

	    model.addAttribute("message", response);
	    return "login";

	}
}
