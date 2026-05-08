package com.example.demo.Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.Model.pojos.User;
import com.example.demo.Model.serviceImp.UserService;

import jakarta.validation.Valid;

@Controller
public class AuthController {

	// ================= SERVICE =================

	private final UserService userService;

	// ================= CONSTRUCTOR =================

	public AuthController(UserService userService) {

		this.userService = userService;
	}

	// ================= INDEX =================

	@GetMapping("/")
	public String index() {

		return "redirect:/login";
	}

	// ================= LOGIN PAGE =================

	@GetMapping("/login")
	public String loginPage(

			@RequestParam(value = "error", required = false) String error,

			@RequestParam(value = "logout", required = false) String logout,

			Model model) {

		// LOGIN ERROR

		if (error != null) {

			model.addAttribute(

					"errorMessage",

					"Invalid email or password.");
		}

		// LOGOUT SUCCESS

		if (logout != null) {

			model.addAttribute(

					"successMessage",

					"Logged out successfully.");
		}

		return "auth/login";
	}

	// ================= REGISTER PAGE =================

	@GetMapping("/register")
	public String registerPage(Model model) {

		model.addAttribute(

				"user",

				new User());

		return "auth/register";
	}

	// ================= REGISTER USER =================

	@PostMapping("/register")
	public String register(

			@Valid @ModelAttribute("user") User user,

			BindingResult result,

			@RequestParam("confirmPassword") String confirmPassword,

			RedirectAttributes redirectAttributes,

			Model model) {

		// VALIDATION ERRORS

		if (result.hasErrors()) {

			return "auth/register";
		}

		// PASSWORD CHECK

		if (!user.getPassword().equals(confirmPassword)) {

			model.addAttribute(

					"errorMessage",

					"Passwords do not match.");

			return "auth/register";
		}

		try {

			// REGISTER USER

			userService.register(user);

			redirectAttributes.addFlashAttribute(

					"successMessage",

					"Registration successful. Please login.");

			return "redirect:/login";
		}

		catch (RuntimeException e) {

			model.addAttribute(

					"errorMessage",

					e.getMessage());

			return "auth/register";
		}
	}
}