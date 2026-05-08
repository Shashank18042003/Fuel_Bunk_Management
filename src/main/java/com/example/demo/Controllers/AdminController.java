package com.example.demo.Controllers;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import org.springframework.security.access.prepost.PreAuthorize;
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
import com.example.demo.Model.enums.OrderStatus;
import com.example.demo.Model.enums.Role;
import com.example.demo.Model.pojos.Branch;
import com.example.demo.Model.pojos.User;
import com.example.demo.Model.repository.PaymentRepository;
import com.example.demo.Model.serviceImp.BranchService;
import com.example.demo.Model.serviceImp.FuelInventoryService;
import com.example.demo.Model.serviceImp.OrderService;
import com.example.demo.Model.serviceImp.UserService;

@Controller
@RequestMapping("/admin")
@PreAuthorize("hasRole('ADMIN')")
public class AdminController {

	// ================= SERVICES =================

	private final UserService userService;

	private final BranchService branchService;

	private final FuelInventoryService inventoryService;

	private final OrderService orderService;

	private final PaymentRepository paymentRepository;

	// ================= CONSTRUCTOR =================

	public AdminController(

			UserService userService,

			BranchService branchService,

			FuelInventoryService inventoryService,

			OrderService orderService,

			PaymentRepository paymentRepository) {

		this.userService = userService;

		this.branchService = branchService;

		this.inventoryService = inventoryService;

		this.orderService = orderService;

		this.paymentRepository = paymentRepository;
	}

	// ================= DASHBOARD =================

	@GetMapping("/dashboard")
	public String dashboard(Model model) {

		model.addAttribute("totalBranches", branchService.countActiveBranches());

		model.addAttribute("totalUsers", userService.countByRole(Role.USER));

		model.addAttribute("totalManagers", userService.countByRole(Role.MANAGER));

		model.addAttribute("pendingOrders", orderService.countByStatus(OrderStatus.PENDING));

		model.addAttribute("todayRevenue",

				orderService.getTotalRevenueSince(

						LocalDateTime.now().toLocalDate().atStartOfDay()));

		model.addAttribute("outOfStockCount", inventoryService.countOutOfStock());

		model.addAttribute("lowAlerts", inventoryService.findLowOrOutOfStock());

		model.addAttribute("recentOrders",

				orderService.findByStatus(OrderStatus.PENDING));

		model.addAttribute("branchPerformance",

				orderService.getBranchPerformance());

		model.addAttribute("totalPetrolLitres",

				inventoryService.getTotalVolumeByType(FuelType.PETROL));

		model.addAttribute("totalDieselLitres",

				inventoryService.getTotalVolumeByType(FuelType.DIESEL));

		return "admin/dashboard";
	}

	// ================= BRANCHES =================

	@GetMapping("/branches")
	public String branches(Model model) {

		model.addAttribute("branches", branchService.findAll());

		model.addAttribute("newBranch", new Branch());

		return "admin/branches";
	}

	@PostMapping("/branches/create")
	public String createBranch(

			@ModelAttribute Branch branch,

			RedirectAttributes ra) {

		try {

			branchService.createBranch(branch);

			ra.addFlashAttribute("success", "Branch created successfully.");
		}

		catch (RuntimeException e) {

			ra.addFlashAttribute("error", e.getMessage());
		}

		return "redirect:/admin/branches";
	}

	@PostMapping("/branches/{id}/toggle")
	public String toggleBranch(

			@PathVariable Long id,

			RedirectAttributes ra) {

		branchService.toggleActive(id);

		ra.addFlashAttribute("success", "Branch status updated.");

		return "redirect:/admin/branches";
	}

	// ================= USERS =================

	@GetMapping("/users")
	public String users(Model model) {

		model.addAttribute("users", userService.findActiveUsers());

		model.addAttribute("managers", userService.findManagers());

		model.addAttribute("branches", branchService.findAllActive());

		model.addAttribute("newUser", new User());

		return "admin/users";
	}

	@PostMapping("/users/{id}/toggle")
	public String toggleUser(

			@PathVariable Long id,

			RedirectAttributes ra) {

		userService.toggleActive(id);

		ra.addFlashAttribute("success", "User status updated.");

		return "redirect:/admin/users";
	}

	@PostMapping("/users/create-manager")
	public String createManager(

			@ModelAttribute("newUser") User user,

			@RequestParam Long branchId,

			RedirectAttributes ra) {

		try {

			user.setRole(Role.MANAGER);

			branchService.findById(branchId).ifPresent(user::setBranch);

			userService.save(user);

			ra.addFlashAttribute("success", "Manager account created.");
		}

		catch (RuntimeException e) {

			ra.addFlashAttribute("error", e.getMessage());
		}

		return "redirect:/admin/users";
	}

	// ================= INVENTORY =================

	@GetMapping("/inventory")
	public String inventory(Model model) {

		model.addAttribute("inventories", inventoryService.findAll());

		model.addAttribute("branches", branchService.findAllActive());

		model.addAttribute("fuelTypes", FuelType.values());

		return "admin/inventory";
	}

	@PostMapping("/inventory/price-update")
	public String updateGlobalPrice(

			@RequestParam FuelType fuelType,

			@RequestParam BigDecimal price,

			RedirectAttributes ra) {

		try {

			inventoryService.broadcastPrice(fuelType, price);

			ra.addFlashAttribute(

					"success",

					fuelType.getDisplayName()

							+ " price updated to ₹"

							+ price

							+ " across all branches.");
		}

		catch (RuntimeException e) {

			ra.addFlashAttribute("error", e.getMessage());
		}

		return "redirect:/admin/inventory";
	}

	@PostMapping("/inventory/replenish")
	public String replenish(

			@RequestParam Long branchId,

			@RequestParam FuelType fuelType,

			@RequestParam BigDecimal litres,

			RedirectAttributes ra) {

		try {

			inventoryService.replenish(branchId, fuelType, litres);

			ra.addFlashAttribute(

					"success",

					litres + "L of " + fuelType.getDisplayName() + " replenished.");
		}

		catch (RuntimeException e) {

			ra.addFlashAttribute("error", e.getMessage());
		}

		return "redirect:/admin/inventory";
	}

	// ================= ORDERS =================

	@GetMapping("/orders")
	public String orders(Model model) {

		model.addAttribute("orders", orderService.findAll());

		model.addAttribute("statuses", OrderStatus.values());

		model.addAttribute("pendingCount",

				orderService.countByStatus(OrderStatus.PENDING));

		return "admin/orders";
	}

	@PostMapping("/orders/{id}/status")
	public String updateOrderStatus(

			@PathVariable Long id,

			@RequestParam OrderStatus status,

			@RequestParam(required = false) String remarks,

			@AuthenticationPrincipal UserDetails userDetails,

			RedirectAttributes ra) {

		User currentUser =

				userService.findByEmail(userDetails.getUsername())

						.orElseThrow();

		try {

			orderService.updateStatus(id, status, remarks, currentUser);

			ra.addFlashAttribute(

					"success",

					"Order updated to: " + status.getDisplayName());
		}

		catch (RuntimeException e) {

			ra.addFlashAttribute("error", e.getMessage());
		}

		return "redirect:/admin/orders";
	}

	// ================= PAYMENTS =================

	@GetMapping("/payments")
	public String payments(Model model) {

		model.addAttribute(

				"payments",

				paymentRepository.findAllOrderByCreatedAtDesc());

		return "admin/payments";
	}

	// ================= REPORTS =================

	@GetMapping("/reports")
	public String reports(Model model) {

		model.addAttribute(

				"branchPerformance",

				orderService.getBranchPerformance());

		model.addAttribute(

				"branches",

				branchService.findAll());

		model.addAttribute(

				"totalRevenue",

				orderService.getTotalRevenueSince(

						LocalDateTime.of(2020, 1, 1, 0, 0)));

		model.addAttribute(

				"petrolLitres",

				inventoryService.getTotalVolumeByType(FuelType.PETROL));

		model.addAttribute(

				"dieselLitres",

				inventoryService.getTotalVolumeByType(FuelType.DIESEL));

		return "admin/reports";
	}
}