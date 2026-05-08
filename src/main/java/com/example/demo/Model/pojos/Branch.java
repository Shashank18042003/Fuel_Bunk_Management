package com.example.demo.Model.pojos;

import java.time.LocalDateTime;
import java.util.List;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;

@Entity
@Table(name = "branches")
public class Branch {

	// ================= ID =================

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	// ================= BRANCH CODE =================

	@NotBlank
	@Column(nullable = false, unique = true)
	private String branchCode;

	// ================= BRANCH NAME =================

	@NotBlank
	@Column(nullable = false)
	private String branchName;

	// ================= ADDRESS =================

	@NotBlank
	@Column(nullable = false)
	private String address;

	// ================= CITY =================

	@Column(nullable = false)
	private String city;

	// ================= STATE =================

	@Column(nullable = false)
	private String state;

	// ================= PIN CODE =================

	@Column(nullable = false)
	private String pinCode;

	// ================= PHONE =================

	private String phone;

	// ================= GPS =================

	private Double latitude;

	private Double longitude;

	// ================= ACTIVE =================

	@Column(nullable = false)
	private boolean active = true;

	// ================= INVENTORIES =================

	@OneToMany(mappedBy = "branch", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private List<FuelInventory> inventories;

	// ================= ORDERS =================

	@OneToMany(mappedBy = "branch", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private List<Order> orders;

	// ================= MANAGERS =================

	@OneToMany(mappedBy = "branch", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private List<User> managers;

	// ================= CREATED AT =================

	@CreationTimestamp
	@Column(updatable = false)
	private LocalDateTime createdAt;

	// ================= UPDATED AT =================

	@UpdateTimestamp
	private LocalDateTime updatedAt;

	// ================= DEFAULT CONSTRUCTOR =================

	public Branch() {

	}

	// ================= PARAMETERIZED CONSTRUCTOR =================

	public Branch(Long id, String branchCode, String branchName, String address, String city, String state,
			String pinCode, String phone, Double latitude, Double longitude, boolean active,
			List<FuelInventory> inventories, List<Order> orders, List<User> managers, LocalDateTime createdAt,
			LocalDateTime updatedAt) {

		this.id = id;
		this.branchCode = branchCode;
		this.branchName = branchName;
		this.address = address;
		this.city = city;
		this.state = state;
		this.pinCode = pinCode;
		this.phone = phone;
		this.latitude = latitude;
		this.longitude = longitude;
		this.active = active;
		this.inventories = inventories;
		this.orders = orders;
		this.managers = managers;
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

	public String getBranchCode() {

		return branchCode;
	}

	public void setBranchCode(String branchCode) {

		this.branchCode = branchCode;
	}

	public String getBranchName() {

		return branchName;
	}

	public void setBranchName(String branchName) {

		this.branchName = branchName;
	}

	public String getAddress() {

		return address;
	}

	public void setAddress(String address) {

		this.address = address;
	}

	public String getCity() {

		return city;
	}

	public void setCity(String city) {

		this.city = city;
	}

	public String getState() {

		return state;
	}

	public void setState(String state) {

		this.state = state;
	}

	public String getPinCode() {

		return pinCode;
	}

	public void setPinCode(String pinCode) {

		this.pinCode = pinCode;
	}

	public String getPhone() {

		return phone;
	}

	public void setPhone(String phone) {

		this.phone = phone;
	}

	public Double getLatitude() {

		return latitude;
	}

	public void setLatitude(Double latitude) {

		this.latitude = latitude;
	}

	public Double getLongitude() {

		return longitude;
	}

	public void setLongitude(Double longitude) {

		this.longitude = longitude;
	}

	public boolean isActive() {

		return active;
	}

	public void setActive(boolean active) {

		this.active = active;
	}

	public List<FuelInventory> getInventories() {

		return inventories;
	}

	public void setInventories(List<FuelInventory> inventories) {

		this.inventories = inventories;
	}

	public List<Order> getOrders() {

		return orders;
	}

	public void setOrders(List<Order> orders) {

		this.orders = orders;
	}

	public List<User> getManagers() {

		return managers;
	}

	public void setManagers(List<User> managers) {

		this.managers = managers;
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