package com.example.demo.Model.pojos;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;

import org.hibernate.annotations.UpdateTimestamp;

import com.example.demo.Model.enums.FuelStatus;
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
import jakarta.persistence.UniqueConstraint;

@Entity
@Table(name = "fuel_inventory", uniqueConstraints = @UniqueConstraint(columnNames = { "branch_id", "fuel_type" }))
public class FuelInventory {

	// ================= ID =================

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	// ================= BRANCH =================

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "branch_id", nullable = false)
	private Branch branch;

	// ================= FUEL TYPE =================

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private FuelType fuelType;

	// ================= AVAILABLE VOLUME =================

	@Column(nullable = false, precision = 10, scale = 2)
	private BigDecimal availableVolumeLitres = BigDecimal.ZERO;

	// ================= TANK CAPACITY =================

	@Column(nullable = false, precision = 10, scale = 2)
	private BigDecimal tankCapacityLitres = BigDecimal.valueOf(10000);

	// ================= DENSITY =================

	@Column(nullable = false, precision = 5, scale = 4)
	private BigDecimal densityKgPerLitre = BigDecimal.valueOf(0.73);

	// ================= PRICE =================

	@Column(nullable = false, precision = 8, scale = 2)
	private BigDecimal pricePerLitre = BigDecimal.valueOf(100.00);

	// ================= STATUS =================

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private FuelStatus status = FuelStatus.AVAILABLE;

	// ================= LOW STOCK THRESHOLD =================

	@Column(nullable = false)
	private Integer lowStockThresholdPercent = 20;

	// ================= LAST REPLENISHED =================

	private LocalDateTime lastReplenishedAt;

	// ================= UPDATED AT =================

	@UpdateTimestamp
	private LocalDateTime updatedAt;

	// ================= DEFAULT CONSTRUCTOR =================

	public FuelInventory() {

	}

	// ================= PARAMETERIZED CONSTRUCTOR =================

	public FuelInventory(Long id, Branch branch, FuelType fuelType, BigDecimal availableVolumeLitres,
			BigDecimal tankCapacityLitres, BigDecimal densityKgPerLitre, BigDecimal pricePerLitre, FuelStatus status,
			Integer lowStockThresholdPercent, LocalDateTime lastReplenishedAt, LocalDateTime updatedAt) {

		this.id = id;
		this.branch = branch;
		this.fuelType = fuelType;
		this.availableVolumeLitres = availableVolumeLitres;
		this.tankCapacityLitres = tankCapacityLitres;
		this.densityKgPerLitre = densityKgPerLitre;
		this.pricePerLitre = pricePerLitre;
		this.status = status;
		this.lowStockThresholdPercent = lowStockThresholdPercent;
		this.lastReplenishedAt = lastReplenishedAt;
		this.updatedAt = updatedAt;
	}

	// ================= PERCENTAGE =================

	public double getVolumePercentage() {

		if (tankCapacityLitres.compareTo(BigDecimal.ZERO) == 0) {

			return 0;
		}

		return availableVolumeLitres.divide(tankCapacityLitres, 4, RoundingMode.HALF_UP)
				.multiply(BigDecimal.valueOf(100)).doubleValue();
	}

	// ================= TOTAL WEIGHT =================

	public BigDecimal getTotalWeightKg() {

		return availableVolumeLitres.multiply(densityKgPerLitre);
	}

	// ================= RECALCULATE STATUS =================

	public void recalculateStatus() {

		double percentage = getVolumePercentage();

		if (percentage <= 0) {

			this.status = FuelStatus.OUT_OF_STOCK;
		} else if (percentage < lowStockThresholdPercent) {

			this.status = FuelStatus.LOW;
		} else {

			this.status = FuelStatus.AVAILABLE;
		}

	}

	// ================= GETTERS AND SETTERS =================

	public Long getId() {

		return id;
	}

	public void setId(Long id) {

		this.id = id;
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

	public BigDecimal getAvailableVolumeLitres() {

		return availableVolumeLitres;
	}

	public void setAvailableVolumeLitres(BigDecimal availableVolumeLitres) {

		this.availableVolumeLitres = availableVolumeLitres;
	}

	public BigDecimal getTankCapacityLitres() {

		return tankCapacityLitres;
	}

	public void setTankCapacityLitres(BigDecimal tankCapacityLitres) {

		this.tankCapacityLitres = tankCapacityLitres;
	}

	public BigDecimal getDensityKgPerLitre() {

		return densityKgPerLitre;
	}

	public void setDensityKgPerLitre(BigDecimal densityKgPerLitre) {

		this.densityKgPerLitre = densityKgPerLitre;
	}

	public BigDecimal getPricePerLitre() {

		return pricePerLitre;
	}

	public void setPricePerLitre(BigDecimal pricePerLitre) {

		this.pricePerLitre = pricePerLitre;
	}

	public FuelStatus getStatus() {

		return status;
	}

	public void setStatus(FuelStatus status) {

		this.status = status;
	}

	public Integer getLowStockThresholdPercent() {

		return lowStockThresholdPercent;
	}

	public void setLowStockThresholdPercent(Integer lowStockThresholdPercent) {

		this.lowStockThresholdPercent = lowStockThresholdPercent;
	}

	public LocalDateTime getLastReplenishedAt() {

		return lastReplenishedAt;
	}

	public void setLastReplenishedAt(LocalDateTime lastReplenishedAt) {

		this.lastReplenishedAt = lastReplenishedAt;
	}

	public LocalDateTime getUpdatedAt() {

		return updatedAt;
	}

	public void setUpdatedAt(LocalDateTime updatedAt) {

		this.updatedAt = updatedAt;
	}

}