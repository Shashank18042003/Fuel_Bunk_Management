package com.example.demo.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.Model.serviceDesign.DeliveryService;

@Controller
@RequestMapping("/delivery")
public class DeliveryController {

	@Autowired
	private DeliveryService deliveryService;

	@GetMapping("/all")
	public String getAllDeliveries(Model model) {

		model.addAttribute("deliveries", deliveryService.getAllDeliveries());

		return "deliveries";
	}

	@PostMapping("/assign")
	public String assignDeliveryAgent(@RequestParam int orderId, @RequestParam int agentId) {

		deliveryService.assignDeliveryAgent(orderId, agentId);

		return "redirect:/delivery/all";
	}
}