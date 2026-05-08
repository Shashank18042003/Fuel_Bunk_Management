package com.example.demo.Model.pojos;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;

import com.example.demo.Model.enums.FuelType;

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
@Table(name = "fuel_price_history")
public class FuelPriceHistory {

	// ================= ID =================

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	// ================= FUEL TYPE =================

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private FuelType fuelType;

	// ================= OLD PRICE =================

	@Column(nullable = false, precision = 8, scale = 2)
	private BigDecimal oldPrice;

	// ================= NEW PRICE =================

	@Column(nullable = false, precision = 8, scale = 2)
	private BigDecimal newPrice;

	// ================= REASON =================

	private String reason;

	// ================= UPDATED BY =================

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "updated_by")
	private User updatedBy;

	// ================= BRANCH =================

	// null = global change
	// non-null = branch-specific

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "branch_id")
	private Branch branch;

	// ================= CHANGED AT =================

	@CreationTimestamp
	@Column(updatable = false)
	private LocalDateTime changedAt;

	// ================= DEFAULT CONSTRUCTOR =================

	public FuelPriceHistory() {

	}

	// ================= PARAMETERIZED CONSTRUCTOR =================

	public FuelPriceHistory(Long id, FuelType fuelType, BigDecimal oldPrice, BigDecimal newPrice, String reason,
			User updatedBy, Branch branch, LocalDateTime changedAt) {

		this.id = id;
		this.fuelType = fuelType;
		this.oldPrice = oldPrice;
		this.newPrice = newPrice;
		this.reason = reason;
		this.updatedBy = updatedBy;
		this.branch = branch;
		this.changedAt = changedAt;
	}

	// ================= GETTERS AND SETTERS =================

	public Long getId() {

		return id;
	}

	public void setId(Long id) {

		this.id = id;
	}

	public FuelType getFuelType() {

		return fuelType;
	}

	public void setFuelType(FuelType fuelType) {

		this.fuelType = fuelType;
	}

	public BigDecimal getOldPrice() {

		return oldPrice;
	}

	public void setOldPrice(BigDecimal oldPrice) {

		this.oldPrice = oldPrice;
	}

	public BigDecimal getNewPrice() {

		return newPrice;
	}

	public void setNewPrice(BigDecimal newPrice) {

		this.newPrice = newPrice;
	}

	public String getReason() {

		return reason;
	}

	public void setReason(String reason) {

		this.reason = reason;
	}

	public User getUpdatedBy() {

		return updatedBy;
	}

	public void setUpdatedBy(User updatedBy) {

		this.updatedBy = updatedBy;
	}

	public Branch getBranch() {

		return branch;
	}

	public void setBranch(Branch branch) {

		this.branch = branch;
	}

	public LocalDateTime getChangedAt() {

		return changedAt;
	}

	public void setChangedAt(LocalDateTime changedAt) {

		this.changedAt = changedAt;
	}

}