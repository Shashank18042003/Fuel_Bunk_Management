package com.example.demo.Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
@RequestMapping("/user")
public class UserController {
	@GetMapping("/dashboard")
	public String dashboard() {

		return "user/userDashboard";
	}
	@GetMapping("/fuelorder")
	public String emergencyOrder() {

		return "user/emergencyOrder";
	}
	@GetMapping("/myorders")
	public String myOrders() {

		return "user/myOrders";
	}
	
}
