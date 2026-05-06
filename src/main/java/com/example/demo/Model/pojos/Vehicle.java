package com.example.demo.Model.pojos;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "vehicle")
public class Vehicle {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String vehicleNumber;
	private String vehicleType;
	private double maxPetrolLimit;
	private double maxDieselLimit;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;
	
	
	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getVehicleNumber() {
		return vehicleNumber;
	}

	public void setVehicleNumber(String vehicleNumber) {
		this.vehicleNumber = vehicleNumber;
	}

	public String getVehicleType() {
		return vehicleType;
	}

	public void setVehicleType(String vehicleType) {
		this.vehicleType = vehicleType;
	}

	public double getMaxPetrolLimit() {
		return maxPetrolLimit;
	}

	public void setMaxPetrolLimit(double maxPetrolLimit) {
		this.maxPetrolLimit = maxPetrolLimit;
	}

	public double getMaxDieselLimit() {
		return maxDieselLimit;
	}

	public void setMaxDieselLimit(double maxDieselLimit) {
		this.maxDieselLimit = maxDieselLimit;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	
	
	
}
