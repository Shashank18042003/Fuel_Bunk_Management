package com.example.demo.Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class AuthController {
	@GetMapping("/")
	public String test()
	{
		return "login";
	}
	@PostMapping("/login")
	public void login()
	{
		
	}
}
