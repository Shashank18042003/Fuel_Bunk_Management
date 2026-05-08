package com.example.demo.Model.pojos;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.example.demo.Model.enums.FuelType;
import com.example.demo.Model.enums.OrderStatus;
import com.example.demo.Model.enums.PaymentMethod;
import com.example.demo.Model.enums.VehicleType;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMax;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "orders")
public class Order {

	// ================= ID =================

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	// ================= ORDER NUMBER =================

	@Column(nullable = false, unique = true)
	private String orderNumber;

	// ================= USER =================

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", nullable = false)
	private User user;

	// ================= BRANCH =================

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "branch_id", nullable = false)
	private Branch branch;

	// ================= FUEL TYPE =================

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private FuelType fuelType;

	// ================= QUANTITY =================

	@NotNull
	@DecimalMin("0.5")
	@DecimalMax("10.0")
	@Column(nullable = false, precision = 5, scale = 2)
	private BigDecimal quantityLitres;

	// ================= PRICE =================

	@Column(nullable = false, precision = 8, scale = 2)
	private BigDecimal pricePerLitre;

	// ================= TOTAL =================

	@Column(nullable = false, precision = 10, scale = 2)
	private BigDecimal totalAmount;

	// ================= DELIVERY CHARGE =================

	@Column(precision = 5, scale = 2)
	private BigDecimal deliveryCharge;

	// ================= GRAND TOTAL =================

	@Column(precision = 10, scale = 2)
	private BigDecimal grandTotal;

	// ================= DELIVERY LOCATION =================

	private String deliveryAddress;

	private Double deliveryLatitude;

	private Double deliveryLongitude;

	// ================= ORDER STATUS =================

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private OrderStatus status = OrderStatus.PENDING;

	// ================= PAYMENT METHOD =================

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private PaymentMethod paymentMethod;

	// ================= PAYMENT =================

	@OneToOne(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private Payment payment;

	// ================= DELIVERY AGENT =================

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "agent_id")
	private User deliveryAgent;

	// ================= DELIVERY TIME =================

	private LocalDateTime requestedDeliveryTime;

	private LocalDateTime actualDeliveryTime;

	// ================= VEHICLE =================

	@Enumerated(EnumType.STRING)
	private VehicleType vehicleType;

	@Column(length = 20)
	private String vehicleNumber;

	// ================= NOTES =================

	private String notes;

	// ================= STATUS HISTORY =================

	@OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private List<OrderStatusHistory> statusHistory;

	// ================= CREATED AT =================

	@CreationTimestamp
	@Column(updatable = false)
	private LocalDateTime createdAt;

	// ================= UPDATED AT =================

	@UpdateTimestamp
	private LocalDateTime updatedAt;

	// ================= DEFAULT CONSTRUCTOR =================

	public Order() {

	}

	// ================= PARAMETERIZED CONSTRUCTOR =================

	public Order(Long id, String orderNumber, User user, Branch branch, FuelType fuelType, BigDecimal quantityLitres,
			BigDecimal pricePerLitre, BigDecimal totalAmount, BigDecimal deliveryCharge, BigDecimal grandTotal,
			String deliveryAddress, Double deliveryLatitude, Double deliveryLongitude, OrderStatus status,
			PaymentMethod paymentMethod, Payment payment, User deliveryAgent, LocalDateTime requestedDeliveryTime,
			LocalDateTime actualDeliveryTime, VehicleType vehicleType, String vehicleNumber, String notes,
			List<OrderStatusHistory> statusHistory, LocalDateTime createdAt, LocalDateTime updatedAt) {

		this.id = id;
		this.orderNumber = orderNumber;
		this.user = user;
		this.branch = branch;
		this.fuelType = fuelType;
		this.quantityLitres = quantityLitres;
		this.pricePerLitre = pricePerLitre;
		this.totalAmount = totalAmount;
		this.deliveryCharge = deliveryCharge;
		this.grandTotal = grandTotal;
		this.deliveryAddress = deliveryAddress;
		this.deliveryLatitude = deliveryLatitude;
		this.deliveryLongitude = deliveryLongitude;
		this.status = status;
		this.paymentMethod = paymentMethod;
		this.payment = payment;
		this.deliveryAgent = deliveryAgent;
		this.requestedDeliveryTime = requestedDeliveryTime;
		this.actualDeliveryTime = actualDeliveryTime;
		this.vehicleType = vehicleType;
		this.vehicleNumber = vehicleNumber;
		this.notes = notes;
		this.statusHistory = statusHistory;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}

	// ================= GETTERS AND SETTERS =================

	public Long getId() {

		return id;
	}

	public void setId(Long id) {

		this.id = id;
	}

	public String getOrderNumber() {

		return orderNumber;
	}

	public void setOrderNumber(String orderNumber) {

		this.orderNumber = orderNumber;
	}

	public User getUser() {

		return user;
	}

	public void setUser(User user) {

		this.user = user;
	}

	public Branch getBranch() {

		return branch;
	}

	public void setBranch(Branch branch) {

		this.branch = branch;
	}

	public FuelType getFuelType() {

		return fuelType;
	}

	public void setFuelType(FuelType fuelType) {

		this.fuelType = fuelType;
	}

	public BigDecimal getQuantityLitres() {

		return quantityLitres;
	}

	public void setQuantityLitres(BigDecimal quantityLitres) {

		this.quantityLitres = quantityLitres;
	}

	public BigDecimal getPricePerLitre() {

		return pricePerLitre;
	}

	public void setPricePerLitre(BigDecimal pricePerLitre) {

		this.pricePerLitre = pricePerLitre;
	}

	public BigDecimal getTotalAmount() {

		return totalAmount;
	}

	public void setTotalAmount(BigDecimal totalAmount) {

		this.totalAmount = totalAmount;
	}

	public BigDecimal getDeliveryCharge() {

		return deliveryCharge;
	}

	public void setDeliveryCharge(BigDecimal deliveryCharge) {

		this.deliveryCharge = deliveryCharge;
	}

	public BigDecimal getGrandTotal() {

		return grandTotal;
	}

	public void setGrandTotal(BigDecimal grandTotal) {

		this.grandTotal = grandTotal;
	}

	public String getDeliveryAddress() {

		return deliveryAddress;
	}

	public void setDeliveryAddress(String deliveryAddress) {

		this.deliveryAddress = deliveryAddress;
	}

	public Double getDeliveryLatitude() {

		return deliveryLatitude;
	}

	public void setDeliveryLatitude(Double deliveryLatitude) {

		this.deliveryLatitude = deliveryLatitude;
	}

	public Double getDeliveryLongitude() {

		return deliveryLongitude;
	}

	public void setDeliveryLongitude(Double deliveryLongitude) {

		this.deliveryLongitude = deliveryLongitude;
	}

	public OrderStatus getStatus() {

		return status;
	}

	public void setStatus(OrderStatus status) {

		this.status = status;
	}

	public PaymentMethod getPaymentMethod() {

		return paymentMethod;
	}

	public void setPaymentMethod(PaymentMethod paymentMethod) {

		this.paymentMethod = paymentMethod;
	}

	public Payment getPayment() {

		return payment;
	}

	public void setPayment(Payment payment) {

		this.payment = payment;
	}

	public User getDeliveryAgent() {

		return deliveryAgent;
	}

	public void setDeliveryAgent(User deliveryAgent) {

		this.deliveryAgent = deliveryAgent;
	}

	public LocalDateTime getRequestedDeliveryTime() {

		return requestedDeliveryTime;
	}

	public void setRequestedDeliveryTime(LocalDateTime requestedDeliveryTime) {

		this.requestedDeliveryTime = requestedDeliveryTime;
	}

	public LocalDateTime getActualDeliveryTime() {

		return actualDeliveryTime;
	}

	public void setActualDeliveryTime(LocalDateTime actualDeliveryTime) {

		this.actualDeliveryTime = actualDeliveryTime;
	}

	public VehicleType getVehicleType() {

		return vehicleType;
	}

	public void setVehicleType(VehicleType vehicleType) {

		this.vehicleType = vehicleType;
	}

	public String getVehicleNumber() {

		return vehicleNumber;
	}

	public void setVehicleNumber(String vehicleNumber) {

		this.vehicleNumber = vehicleNumber;
	}

	public String getNotes() {

		return notes;
	}

	public void setNotes(String notes) {

		this.notes = notes;
	}

	public List<OrderStatusHistory> getStatusHistory() {

		return statusHistory;
	}

	public void setStatusHistory(List<OrderStatusHistory> statusHistory) {

		this.statusHistory = statusHistory;
	}

	public LocalDateTime getCreatedAt() {

		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {

		this.createdAt = createdAt;
	}

	public LocalDateTime getUpdatedAt() {

		return updatedAt;
	}

	public void setUpdatedAt(LocalDateTime updatedAt) {

		this.updatedAt = updatedAt;
	}

}