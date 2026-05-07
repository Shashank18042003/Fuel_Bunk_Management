package com.example.demo.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.Model.serviceDesign.NotificationService;

@Controller
@RequestMapping("/notification")
public class NotificationController {

	@Autowired
	private NotificationService notificationService;

	@GetMapping("/user/{id}")
	public String getNotifications(@PathVariable int id, Model model) {

		model.addAttribute("notifications", notificationService.getNotificationsByUser(id));

		return "notifications";
	}
}