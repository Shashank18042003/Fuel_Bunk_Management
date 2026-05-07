package com.example.demo.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.Model.serviceDesign.ReportService;

@Controller
@RequestMapping("/report")
public class ReportController {

	@Autowired
	private ReportService reportService;

	@GetMapping("/all")
	public String reports(Model model) {

		model.addAttribute("salesReport", reportService.getDailySalesReport());

		model.addAttribute("branchReport", reportService.getBranchPerformanceReport());

		model.addAttribute("fuelReport", reportService.getFuelConsumptionReport());

		return "reports";
	}
}