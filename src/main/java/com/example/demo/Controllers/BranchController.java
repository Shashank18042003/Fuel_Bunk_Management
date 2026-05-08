package com.example.demo.Controllers;

import java.math.BigDecimal;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.Model.enums.FuelType;
import com.example.demo.Model.enums.OrderStatus;
import com.example.demo.Model.pojos.User;
import com.example.demo.Model.serviceImp.BranchService;
import com.example.demo.Model.serviceImp.FuelInventoryService;
import com.example.demo.Model.serviceImp.OrderService;
import com.example.demo.Model.serviceImp.UserService;

@Controller
@RequestMapping("/branch")
@PreAuthorize("hasAnyRole('ADMIN','MANAGER')")
public class BranchController {

	// ================= SERVICES =================

	private final UserService userService;

	private final BranchService branchService;

	private final FuelInventoryService inventoryService;

	private final OrderService orderService;

	// ================= CONSTRUCTOR =================

	public BranchController(

			UserService userService,

			BranchService branchService,

			FuelInventoryService inventoryService,

			OrderService orderService) {

		this.userService = userService;

		this.branchService = branchService;

		this.inventoryService = inventoryService;

		this.orderService = orderService;
	}

	// ================= CURRENT USER =================

	private User getCurrentUser(UserDetails userDetails) {

		return userService

				.findByEmail(userDetails.getUsername())

				.orElseThrow();
	}

	// ================= DASHBOARD =================

	@GetMapping("/dashboard")
	public String dashboard(

			@AuthenticationPrincipal UserDetails userDetails,

			Model model) {

		User manager = getCurrentUser(userDetails);

		Long branchId = manager.getBranch() != null

				? manager.getBranch().getId()

				: null;

		// IF ADMIN LOGIN

		if (branchId == null) {

			return "redirect:/admin/dashboard";
		}

		model.addAttribute("branch", manager.getBranch());

		model.addAttribute("inventories",

				inventoryService.findByBranch(branchId));

		model.addAttribute("orders",

				orderService.findByBranch(branchId));

		model.addAttribute(

				"pendingOrders",

				orderService.findByBranch(branchId)

						.stream()

						.filter(order ->

						order.getStatus() == OrderStatus.PENDING)

						.count());

		model.addAttribute(

				"lowAlerts",

				inventoryService.findLowOrOutOfStock()

						.stream()

						.filter(inventory ->

						inventory.getBranch().getId()

								.equals(branchId))

						.toList());

		return "branch/dashboard";
	}

	// ================= INVENTORY =================

	@GetMapping("/inventory")
	public String inventory(

			@AuthenticationPrincipal UserDetails userDetails,

			Model model) {

		User manager = getCurrentUser(userDetails);

		Long branchId = manager.getBranch().getId();

		model.addAttribute(

				"inventories",

				inventoryService.findByBranch(branchId));

		model.addAttribute("branch", manager.getBranch());

		model.addAttribute("fuelTypes", FuelType.values());

		return "branch/inventory";
	}

	// ================= UPDATE DENSITY =================

	@PostMapping("/inventory/update-density")
	public String updateDensity(

			@AuthenticationPrincipal UserDetails userDetails,

			@RequestParam Long branchId,

			@RequestParam FuelType fuelType,

			@RequestParam BigDecimal density,

			RedirectAttributes ra) {

		try {

			inventoryService.updateDensity(branchId, fuelType, density);

			ra.addFlashAttribute(

					"success",

					"Density updated for " + fuelType.getDisplayName());
		}

		catch (RuntimeException e) {

			ra.addFlashAttribute("error", e.getMessage());
		}

		return "redirect:/branch/inventory";
	}

	// ================= ORDERS =================

	@GetMapping("/orders")
	public String orders(

			@AuthenticationPrincipal UserDetails userDetails,

			Model model) {

		User manager = getCurrentUser(userDetails);

		Long branchId = manager.getBranch().getId();

		model.addAttribute(

				"orders",

				orderService.findByBranch(branchId));

		model.addAttribute("statuses", OrderStatus.values());

		model.addAttribute("branch", manager.getBranch());

		return "branch/orders";
	}

	// ================= UPDATE ORDER STATUS =================

	@PostMapping("/orders/{id}/status")
	public String updateOrderStatus(

			@PathVariable Long id,

			@RequestParam OrderStatus status,

			@RequestParam(required = false) String remarks,

			@AuthenticationPrincipal UserDetails userDetails,

			RedirectAttributes ra) {

		User currentUser = getCurrentUser(userDetails);

		try {

			orderService.updateStatus(id, status, remarks, currentUser);

			ra.addFlashAttribute(

					"success",

					"Order updated to : " + status.getDisplayName());
		}

		catch (RuntimeException e) {

			ra.addFlashAttribute("error", e.getMessage());
		}

		return "redirect:/branch/orders";
	}

	// ================= ASSIGN DELIVERY AGENT =================

	@PostMapping("/orders/{id}/assign")
	public String assignAgent(

			@PathVariable Long id,

			@RequestParam Long agentId,

			@AuthenticationPrincipal UserDetails userDetails,

			RedirectAttributes ra) {

		User agent = userService.findById(agentId).orElseThrow();

		try {

			orderService.assignDeliveryAgent(id, agent);

			ra.addFlashAttribute(

					"success",

					"Agent " + agent.getFullName() + " assigned.");
		}

		catch (RuntimeException e) {

			ra.addFlashAttribute("error", e.getMessage());
		}

		return "redirect:/branch/orders";
	}
}