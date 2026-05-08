package com.example.demo.Model.pojos;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.example.demo.Model.enums.PaymentMethod;
import com.example.demo.Model.enums.PaymentStatus;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "payments")
public class Payment {

	// ================= ID =================

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	// ================= TRANSACTION ID =================

	@Column(nullable = false, unique = true)
	private String transactionId;

	// ================= ORDER =================

	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "order_id", nullable = false)
	private Order order;

	// ================= PAYMENT METHOD =================

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private PaymentMethod method;

	// ================= PAYMENT STATUS =================

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private PaymentStatus status = PaymentStatus.PENDING;

	// ================= AMOUNT =================

	@Column(nullable = false, precision = 10, scale = 2)
	private BigDecimal amount;

	// ================= GATEWAY DETAILS =================

	private String gatewayTransactionId;

	private String gatewayResponse;

	// ================= INVOICE =================

	private String invoiceNumber;

	private LocalDateTime invoiceGeneratedAt;

	// ================= CREATED AT =================

	@CreationTimestamp
	@Column(updatable = false)
	private LocalDateTime createdAt;

	// ================= UPDATED AT =================

	@UpdateTimestamp
	private LocalDateTime updatedAt;

	// ================= DEFAULT CONSTRUCTOR =================

	public Payment() {

	}

	// ================= PARAMETERIZED CONSTRUCTOR =================

	public Payment(Long id, String transactionId, Order order, PaymentMethod method, PaymentStatus status,
			BigDecimal amount, String gatewayTransactionId, String gatewayResponse, String invoiceNumber,
			LocalDateTime invoiceGeneratedAt, LocalDateTime createdAt, LocalDateTime updatedAt) {

		this.id = id;
		this.transactionId = transactionId;
		this.order = order;
		this.method = method;
		this.status = status;
		this.amount = amount;
		this.gatewayTransactionId = gatewayTransactionId;
		this.gatewayResponse = gatewayResponse;
		this.invoiceNumber = invoiceNumber;
		this.invoiceGeneratedAt = invoiceGeneratedAt;
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

	public String getTransactionId() {

		return transactionId;
	}

	public void setTransactionId(String transactionId) {

		this.transactionId = transactionId;
	}

	public Order getOrder() {

		return order;
	}

	public void setOrder(Order order) {

		this.order = order;
	}

	public PaymentMethod getMethod() {

		return method;
	}

	public void setMethod(PaymentMethod method) {

		this.method = method;
	}

	public PaymentStatus getStatus() {

		return status;
	}

	public void setStatus(PaymentStatus status) {

		this.status = status;
	}

	public BigDecimal getAmount() {

		return amount;
	}

	public void setAmount(BigDecimal amount) {

		this.amount = amount;
	}

	public String getGatewayTransactionId() {

		return gatewayTransactionId;
	}

	public void setGatewayTransactionId(String gatewayTransactionId) {

		this.gatewayTransactionId = gatewayTransactionId;
	}

	public String getGatewayResponse() {

		return gatewayResponse;
	}

	public void setGatewayResponse(String gatewayResponse) {

		this.gatewayResponse = gatewayResponse;
	}

	public String getInvoiceNumber() {

		return invoiceNumber;
	}

	public void setInvoiceNumber(String invoiceNumber) {

		this.invoiceNumber = invoiceNumber;
	}

	public LocalDateTime getInvoiceGeneratedAt() {

		return invoiceGeneratedAt;
	}

	public void setInvoiceGeneratedAt(LocalDateTime invoiceGeneratedAt) {

		this.invoiceGeneratedAt = invoiceGeneratedAt;
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