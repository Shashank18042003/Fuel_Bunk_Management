package com.example.demo.Model.pojos;

import java.time.LocalDateTime;
import java.util.List;



import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.example.demo.Model.enums.VehicleType;
import com.example.demo.Model.enums.Role;

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
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "users")
public class User {

	// ================= ID =================

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	// ================= FULL NAME =================

	@NotBlank
	@Size(min = 2, max = 100)
	@Column(nullable = false)
	private String fullName;

	// ================= EMAIL =================

	@Email
	@NotBlank
	@Column(nullable = false, unique = true)
	private String email;

	// ================= PASSWORD =================

	@NotBlank
	@Column(nullable = false)
	private String password;

	// ================= PHONE =================

	@Column(length = 15)
	private String phone;

	// ================= ROLE =================

	@Enumerated(EnumType.STRING)
	@Column(nullable = false)
	private Role role = Role.USER;

	// ================= VEHICLE TYPE =================

	@Enumerated(EnumType.STRING)
	private VehicleType vehicleType;

	// ================= VEHICLE NUMBER =================

	@Column(length = 20)
	private String vehicleNumber;

	// ================= ACTIVE =================

	@Column(nullable = false)
	private boolean active = true;

	// ================= BRANCH =================

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "branch_id")
	private Branch branch;

	// ================= ORDERS =================

	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	private List<Order> orders;

	// ================= CREATED AT =================

	@CreationTimestamp
	@Column(updatable = false)
	private LocalDateTime createdAt;

	// ================= UPDATED AT =================

	@UpdateTimestamp
	private LocalDateTime updatedAt;

	// ================= DEFAULT CONSTRUCTOR =================

	public User() {

	}

	// ================= PARAMETERIZED CONSTRUCTOR =================

	public User(Long id, String fullName, String email, String password, String phone, Role role,
			VehicleType vehicleType, String vehicleNumber, boolean active, Branch branch, List<Order> orders,
			LocalDateTime createdAt, LocalDateTime updatedAt) {

		this.id = id;
		this.fullName = fullName;
		this.email = email;
		this.password = password;
		this.phone = phone;
		this.role = role;
		this.vehicleType = vehicleType;
		this.vehicleNumber = vehicleNumber;
		this.active = active;
		this.branch = branch;
		this.orders = orders;
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

	public String getFullName() {

		return fullName;
	}

	public void setFullName(String fullName) {

		this.fullName = fullName;
	}

	public String getEmail() {

		return email;
	}

	public void setEmail(String email) {

		this.email = email;
	}

	public String getPassword() {

		return password;
	}

	public void setPassword(String password) {

		this.password = password;
	}

	public String getPhone() {

		return phone;
	}

	public void setPhone(String phone) {

		this.phone = phone;
	}

	public Role getRole() {

		return role;
	}

	public void setRole(Role role) {

		this.role = role;
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

	public boolean isActive() {

		return active;
	}

	public void setActive(boolean active) {

		this.active = active;
	}

	public Branch getBranch() {

		return branch;
	}

	public void setBranch(Branch branch) {

		this.branch = branch;
	}

	public List<Order> getOrders() {

		return orders;
	}

	public void setOrders(List<Order> orders) {

		this.orders = orders;
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