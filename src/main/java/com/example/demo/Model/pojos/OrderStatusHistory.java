package com.example.demo.Model.pojos;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;

import com.example.demo.Model.enums.OrderStatus;

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
import jakarta.persistence.Table;

@Entity
@Table(name = "order_status_history")
public class OrderStatusHistory {

	// ================= ID =================

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	// ================= ORDER =================

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "order_id", nullable = false)
	private Order order;

	// ================= STATUS =================

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private OrderStatus status;

	// ================= REMARKS =================

	private String remarks;

	// ================= UPDATED BY =================

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "updated_by")
	private User updatedBy;

	// ================= TIMESTAMP =================

	@CreationTimestamp
	@Column(updatable = false)
	private LocalDateTime timestamp;

	// ================= DEFAULT CONSTRUCTOR =================

	public OrderStatusHistory() {

	}

	// ================= PARAMETERIZED CONSTRUCTOR =================

	public OrderStatusHistory(Long id, Order order, OrderStatus status, String remarks, User updatedBy,
			LocalDateTime timestamp) {

		this.id = id;
		this.order = order;
		this.status = status;
		this.remarks = remarks;
		this.updatedBy = updatedBy;
		this.timestamp = timestamp;
	}

	// ================= GETTERS AND SETTERS =================

	public Long getId() {

		return id;
	}

	public void setId(Long id) {

		this.id = id;
	}

	public Order getOrder() {

		return order;
	}

	public void setOrder(Order order) {

		this.order = order;
	}

	public OrderStatus getStatus() {

		return status;
	}

	public void setStatus(OrderStatus status) {

		this.status = status;
	}

	public String getRemarks() {

		return remarks;
	}

	public void setRemarks(String remarks) {

		this.remarks = remarks;
	}

	public User getUpdatedBy() {

		return updatedBy;
	}

	public void setUpdatedBy(User updatedBy) {

		this.updatedBy = updatedBy;
	}

	public LocalDateTime getTimestamp() {

		return timestamp;
	}

	public void setTimestamp(LocalDateTime timestamp) {

		this.timestamp = timestamp;
	}

}