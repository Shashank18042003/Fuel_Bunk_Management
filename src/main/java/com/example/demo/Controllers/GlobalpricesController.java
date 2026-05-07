package com.example.demo.Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/globalprices")
public class GlobalpricesController {

	@GetMapping("/prices")
	public String showprices(){
		return"admin/globalPrices";
	}
}
