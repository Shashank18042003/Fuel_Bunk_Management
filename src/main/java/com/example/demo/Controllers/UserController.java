package com.example.demo.Controllers;

import java.util.List;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.Model.enums.FuelType;
import com.example.demo.Model.enums.PaymentMethod;
import com.example.demo.Model.enums.VehicleType;
import com.example.demo.Model.pojos.Branch;
import com.example.demo.Model.pojos.Order;
import com.example.demo.Model.pojos.User;
import com.example.demo.Model.serviceImp.BranchService;
import com.example.demo.Model.serviceImp.FuelInventoryService;
import com.example.demo.Model.serviceImp.OrderService;
import com.example.demo.Model.serviceImp.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	// ================= SERVICES =================

	private final UserService userService;

	private final BranchService branchService;

	private final FuelInventoryService inventoryService;

	private final OrderService orderService;

	// ================= CONSTRUCTOR =================

	public UserController(

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

		User user = getCurrentUser(userDetails);

		model.addAttribute("user", user);

		model.addAttribute(

				"recentOrders",

				orderService.findByUser(user.getId()));

		model.addAttribute(

				"branches",

				branchService.findAllActive());

		model.addAttribute("fuelTypes", FuelType.values());

		return "user/dashboard";
	}

	// ================= NEW ORDER FORM =================

	@GetMapping("/order/new")
	public String newOrderForm(

			@AuthenticationPrincipal UserDetails userDetails,

			@RequestParam(required = false) Long branchId,

			@RequestParam(required = false) FuelType fuelType,

			Model model) {

		User user = getCurrentUser(userDetails);

		model.addAttribute("user", user);

		model.addAttribute("order", new Order());

		model.addAttribute(

				"branches",

				branchService.findAllActive());

		model.addAttribute("fuelTypes", FuelType.values());

		model.addAttribute("payMethods", PaymentMethod.values());

		model.addAttribute("vehicleTypes", VehicleType.values());

		// PREFILL SELECTED INVENTORY

		if (branchId != null && fuelType != null) {

			inventoryService

					.findByBranchAndType(branchId, fuelType)

					.ifPresent(inv ->

					model.addAttribute("selectedInventory", inv));

			model.addAttribute("selectedBranchId", branchId);

			model.addAttribute("selectedFuelType", fuelType);
		}

		return "user/new-order";
	}

	// ================= PLACE ORDER =================

	@PostMapping("/order/place")
	public String placeOrder(

			@ModelAttribute Order order,

			@RequestParam Long branchId,

			@RequestParam(required = false) Double deliveryLat,

			@RequestParam(required = false) Double deliveryLng,

			@AuthenticationPrincipal UserDetails userDetails,

			RedirectAttributes ra) {

		User user = getCurrentUser(userDetails);

		try {

			Branch branch = branchService.findById(branchId)

					.orElseThrow();

			order.setBranch(branch);

			if (deliveryLat != null) {

				order.setDeliveryLatitude(deliveryLat);
			}

			if (deliveryLng != null) {

				order.setDeliveryLongitude(deliveryLng);
			}

			Order placed = orderService.placeOrder(order, user);

			ra.addFlashAttribute(

					"success",

					"Order " + placed.getOrderNumber() + " placed successfully.");

			return "redirect:/user/orders/" + placed.getId();
		}

		catch (RuntimeException e) {

			ra.addFlashAttribute("error", e.getMessage());

			return "redirect:/user/order/new?branchId=" + branchId + "&fuelType=" + order.getFuelType();
		}
	}

	// ================= MY ORDERS =================

	@GetMapping("/orders")
	public String myOrders(

			@AuthenticationPrincipal UserDetails userDetails,

			Model model) {

		User user = getCurrentUser(userDetails);

		model.addAttribute(

				"orders",

				orderService.findByUser(user.getId()));

		return "user/orders";
	}

	// ================= ORDER DETAIL =================

	@GetMapping("/orders/{id}")
	public String orderDetail(

			@PathVariable Long id,

			@AuthenticationPrincipal UserDetails userDetails,

			Model model) {

		User user = getCurrentUser(userDetails);

		Order order = orderService.findById(id)

				.orElseThrow(() ->

				new RuntimeException("Order not found"));

		// USER CAN ONLY VIEW OWN ORDER

		if (!order.getUser().getId().equals(user.getId())) {

			return "redirect:/user/orders";
		}

		model.addAttribute("order", order);

		return "user/order-detail";
	}

	// ================= BROWSE BRANCHES =================

	@GetMapping("/branches")
	public String browseBranches(

			@AuthenticationPrincipal UserDetails userDetails,

			@RequestParam(required = false) FuelType fuelType,

			Model model) {

		User user = getCurrentUser(userDetails);

		List<Branch> branches = branchService.findAllActive();

		model.addAttribute("branches", branches);

		model.addAttribute("fuelTypes", FuelType.values());

		model.addAttribute("selected", fuelType);

		// LOAD INVENTORY FOR EACH BRANCH

		branches.forEach(branch ->

		model.addAttribute(

				"inv_" + branch.getId(),

				inventoryService.findByBranch(branch.getId())));

		return "user/branches";
	}

	// ================= PROFILE =================

	@GetMapping("/profile")
	public String profile(

			@AuthenticationPrincipal UserDetails userDetails,

			Model model) {

		User user = getCurrentUser(userDetails);

		model.addAttribute("user", user);

		model.addAttribute("vehicleTypes", VehicleType.values());

		return "user/profile";
	}

	// ================= UPDATE PROFILE =================

	@PostMapping("/profile/update")
	public String updateProfile(

			@ModelAttribute User updatedUser,

			@AuthenticationPrincipal UserDetails userDetails,

			RedirectAttributes ra) {

		User user = getCurrentUser(userDetails);

		try {

			userService.update(user.getId(), updatedUser);

			ra.addFlashAttribute(

					"success",

					"Profile updated successfully.");
		}

		catch (RuntimeException e) {

			ra.addFlashAttribute("error", e.getMessage());
		}

		return "redirect:/user/profile";
	}
}