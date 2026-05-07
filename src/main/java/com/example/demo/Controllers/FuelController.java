package com.example.demo.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.Model.pojos.FuelStock;
import com.example.demo.Model.serviceDesign.FuelService;

@Controller
@RequestMapping("/fuel")
public class FuelController {

	@Autowired
	private FuelService fuelService;

	@GetMapping("/all")
	public String getAllFuelStocks(Model model) {

		model.addAttribute("stocks", fuelService.getAllFuelStocks());

		return "fuelStocks";
	}

	@GetMapping("/add")
	public String addFuelPage(Model model) {

		model.addAttribute("fuelStock", new FuelStock());

		return "addFuel";
	}

	@PostMapping("/save")
	public String saveFuel(@ModelAttribute FuelStock fuelStock) {

		fuelService.addFuelStock(fuelStock);

		return "redirect:/fuel/all";
	}
}