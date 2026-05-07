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

			if (response.equals("INVALID_CREDENTIALS")) {
				model.addAttribute("message", "Invalid email or password");
				return "login";
			}
			
			if(email.equals("admin@gmail.com") && password.equals("admin123")) {
				return "admin/admindashboard";
			}
			else if(email.equals("manager1@gmail.com") && password.equals("manager123")) {
				return "manager/managerDashboard";
			}
			else {
				return "user/userDashboard";
			}

		}
}
