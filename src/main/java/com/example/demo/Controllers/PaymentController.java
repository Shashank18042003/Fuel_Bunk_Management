package com.example.demo.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.Model.pojos.Payment;
import com.example.demo.Model.serviceDesign.PaymentService;

@Controller
@RequestMapping("/payment")
public class PaymentController {

	@Autowired
	private PaymentService paymentService;

	@GetMapping("/all")
	public String getAllPayments(Model model) {

		model.addAttribute("payments", paymentService.getAllPayments());

		return "admin/payments";
	}

	@GetMapping("/add")
	public String paymentPage(Model model) {

		model.addAttribute("payment", new Payment());

		return "payment";
	}

	@PostMapping("/save")
	public String savePayment(@ModelAttribute Payment payment) {

		paymentService.makePayment(payment);

//		return "redirect:/payment/all";
		return "redirect:/payment/all";
	}
}