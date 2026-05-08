package com.example.demo.Model.serviceImp;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.Model.enums.FuelStatus;
import com.example.demo.Model.enums.FuelType;
import com.example.demo.Model.enums.OrderStatus;
import com.example.demo.Model.enums.PaymentMethod;
import com.example.demo.Model.enums.PaymentStatus;
import com.example.demo.Model.pojos.FuelInventory;
import com.example.demo.Model.pojos.Order;
import com.example.demo.Model.pojos.OrderStatusHistory;
import com.example.demo.Model.pojos.Payment;
import com.example.demo.Model.pojos.User;
import com.example.demo.Model.repository.OrderRepository;
import com.example.demo.Model.repository.OrderStatusHistoryRepository;
import com.example.demo.Model.repository.PaymentRepository;
import com.example.demo.Model.serviceDesign.OrderServiceDesign;

@Service
@Transactional
public class OrderService implements OrderServiceDesign {

	// ================= LOGGER =================

	private static final Logger logger = LoggerFactory.getLogger(OrderService.class);

	// ================= REPOSITORIES =================

	@Autowired
	private OrderRepository orderRepository;

	@Autowired
	private FuelInventoryService inventoryService;

	@Autowired
	private PaymentRepository paymentRepository;

	@Autowired
	private OrderStatusHistoryRepository statusHistoryRepository;

	// ================= PLACE ORDER =================

	@Override
	public Order placeOrder(Order order, User currentUser) {

		// VALIDATE ORDER LIMITS

		validateOrderLimits(order);

		// CHECK INVENTORY

		FuelInventory inventory = inventoryService.findByBranchAndType(order.getBranch().getId(), order.getFuelType())

				.orElseThrow(() -> new RuntimeException(

						"Branch does not carry "

								+

								order.getFuelType().getDisplayName()));

		if (inventory.getStatus() == FuelStatus.OUT_OF_STOCK) {

			throw new RuntimeException(

					"Fuel not available at selected branch. Please choose another branch.");
		}

		if (inventory.getAvailableVolumeLitres().compareTo(order.getQuantityLitres()) < 0) {

			throw new RuntimeException(

					"Insufficient stock. Available: "

							+

							inventory.getAvailableVolumeLitres()

							+

							"L");
		}

		// CALCULATE AMOUNT

		BigDecimal totalAmount = inventory.getPricePerLitre()

				.multiply(order.getQuantityLitres());

		BigDecimal deliveryCharge = BigDecimal.valueOf(50);

		BigDecimal grandTotal = totalAmount.add(deliveryCharge);

		// SET ORDER DETAILS

		order.setUser(currentUser);

		order.setPricePerLitre(inventory.getPricePerLitre());

		order.setTotalAmount(totalAmount);

		order.setDeliveryCharge(deliveryCharge);

		order.setGrandTotal(grandTotal);

		order.setStatus(OrderStatus.PENDING);

		order.setOrderNumber(generateOrderNumber());

		order.setVehicleType(currentUser.getVehicleType());

		order.setVehicleNumber(currentUser.getVehicleNumber());

		Order savedOrder = orderRepository.save(order);

		// CREATE PAYMENT

		Payment payment = new Payment();

		payment.setTransactionId(

				"TXN-"

						+

						UUID.randomUUID().toString().substring(0, 12).toUpperCase());

		payment.setOrder(savedOrder);

		payment.setMethod(order.getPaymentMethod());

		payment.setAmount(grandTotal);

		payment.setStatus(PaymentStatus.PENDING);

		paymentRepository.save(payment);

		// STATUS HISTORY

		addStatusHistory(savedOrder, OrderStatus.PENDING, "Order placed by user", currentUser);

		logger.info(

				"Order placed: {} | ₹{} | {}",

				savedOrder.getOrderNumber(),

				grandTotal,

				order.getFuelType());

		return savedOrder;
	}

	// ================= VALIDATE LIMITS =================

	private void validateOrderLimits(Order order) {

		double max = order.getFuelType() == FuelType.PETROL

				?

				5.0

				:

				10.0;

		if (order.getQuantityLitres().doubleValue() > max) {

			throw new RuntimeException(

					order.getFuelType().getDisplayName()

							+

							" order limit is "

							+

							max

							+

							"L. Requested: "

							+

							order.getQuantityLitres()

							+

							"L");
		}

		if (order.getQuantityLitres().doubleValue() < 0.5) {

			throw new RuntimeException("Minimum order quantity is 0.5L");
		}
	}

	// ================= UPDATE STATUS =================

	@Override
	public Order updateStatus(Long orderId, OrderStatus newStatus, String remarks, User updatedBy) {

		Order order = orderRepository.findById(orderId)

				.orElseThrow(() -> new RuntimeException("Order not found: " + orderId));

		OrderStatus oldStatus = order.getStatus();

		order.setStatus(newStatus);

		// DELIVERED

		if (newStatus == OrderStatus.DELIVERED

				&&

				oldStatus != OrderStatus.DELIVERED) {

			inventoryService.deductFuel(

					order.getBranch().getId(),

					order.getFuelType(),

					order.getQuantityLitres());

			order.setActualDeliveryTime(LocalDateTime.now());

			paymentRepository.findByOrderId(orderId)

					.ifPresent(payment -> {

						if (payment.getMethod() == PaymentMethod.CASH_ON_DELIVERY) {

							payment.setStatus(PaymentStatus.SUCCESS);

							payment.setInvoiceNumber(generateInvoiceNumber(order));

							payment.setInvoiceGeneratedAt(LocalDateTime.now());

							paymentRepository.save(payment);
						}

					});

		}

		// CANCELLED

		if (newStatus == OrderStatus.CANCELLED) {

			paymentRepository.findByOrderId(orderId)

					.ifPresent(payment -> {

						payment.setStatus(PaymentStatus.REFUNDED);

						paymentRepository.save(payment);

					});
		}

		Order updatedOrder = orderRepository.save(order);

		addStatusHistory(updatedOrder, newStatus, remarks, updatedBy);

		return updatedOrder;
	}

	// ================= ASSIGN AGENT =================

	@Override
	public Order assignDeliveryAgent(Long orderId, User agent) {

		Order order = orderRepository.findById(orderId)

				.orElseThrow(() -> new RuntimeException("Order not found"));

		order.setDeliveryAgent(agent);

		order.setStatus(OrderStatus.DISPATCHED);

		addStatusHistory(

				order,

				OrderStatus.DISPATCHED,

				"Assigned to agent: " + agent.getFullName(),

				agent);

		return orderRepository.save(order);
	}

	// ================= STATUS HISTORY =================

	private void addStatusHistory(Order order, OrderStatus status, String remarks, User updatedBy) {

		OrderStatusHistory history = new OrderStatusHistory();

		history.setOrder(order);

		history.setStatus(status);

		history.setRemarks(remarks);

		history.setUpdatedBy(updatedBy);

		statusHistoryRepository.save(history);
	}

	// ================= FIND BY USER =================

	@Override
	@Transactional(readOnly = true)
	public List<Order> findByUser(Long userId) {

		return orderRepository.findByUserIdOrderByCreatedAtDesc(userId);
	}

	// ================= FIND BY BRANCH =================

	@Override
	@Transactional(readOnly = true)
	public List<Order> findByBranch(Long branchId) {

		return orderRepository.findByBranchIdOrderByCreatedAtDesc(branchId);
	}

	// ================= FIND ALL =================

	@Override
	@Transactional(readOnly = true)
	public List<Order> findAll() {

		return orderRepository.findAll();
	}

	// ================= FIND BY ID =================

	@Override
	@Transactional(readOnly = true)
	public Optional<Order> findById(Long id) {

		return orderRepository.findById(id);
	}

	// ================= FIND BY STATUS =================

	@Override
	@Transactional(readOnly = true)
	public List<Order> findByStatus(OrderStatus status) {

		return orderRepository.findByStatus(status);
	}

	// ================= COUNT BY STATUS =================

	@Override
	@Transactional(readOnly = true)
	public long countByStatus(OrderStatus status) {

		return orderRepository.countByStatus(status);
	}

	// ================= TOTAL REVENUE =================

	@Override
	@Transactional(readOnly = true)
	public Double getTotalRevenueSince(LocalDateTime since) {

		Double revenue = orderRepository.getTotalRevenueFromDate(since);

		return revenue != null ? revenue : 0.0;
	}

	// ================= BRANCH PERFORMANCE =================

	@Override
	@Transactional(readOnly = true)
	public List<Object[]> getBranchPerformance() {

		return orderRepository.getBranchPerformance();
	}

	// ================= ORDER NUMBER =================

	private String generateOrderNumber() {

		String datePart = LocalDateTime.now()

				.format(DateTimeFormatter.ofPattern("yyyyMMdd"));

		String random = UUID.randomUUID().toString().substring(0, 6).toUpperCase();

		return "FC-" + datePart + "-" + random;
	}

	// ================= INVOICE NUMBER =================

	private String generateInvoiceNumber(Order order) {

		return "INV-" + order.getOrderNumber();
	}

}