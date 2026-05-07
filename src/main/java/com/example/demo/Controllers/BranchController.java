package com.example.demo.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.Model.pojos.Branch;
import com.example.demo.Model.serviceDesign.BranchService;

@Controller
@RequestMapping("/branch")
public class BranchController {

	@Autowired
	private BranchService branchService;

	@GetMapping("/all")
	public String getAllBranches(Model model) {

		model.addAttribute("branches", branchService.getAllBranches());

		return "admin/branches";
	}
	@GetMapping("/add")
	public String addBranchPage(Model model) {

		model.addAttribute("branch", new Branch());

		return "addBranch";
	}

	@PostMapping("/save")
	public String saveBranch(@ModelAttribute Branch branch) {

		branchService.addBranch(branch);

		return "redirect:branch/all";
	}
}