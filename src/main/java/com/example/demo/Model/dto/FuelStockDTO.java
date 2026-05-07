package com.example.demo.Model.dto;

public class FuelStockDTO {
	
	private int branchId;
    private String fuelType;
    private double availableLiters;
    private double density;
    private String status;
    
    
	public int getBranchId() {
		return branchId;
	}
	public void setBranchId(int branchId) {
		this.branchId = branchId;
	}
	public String getFuelType() {
		return fuelType;
	}
	public void setFuelType(String fuelType) {
		this.fuelType = fuelType;
	}
	public double getAvailableLiters() {
		return availableLiters;
	}
	public void setAvailableLiters(double availableLiters) {
		this.availableLiters = availableLiters;
	}
	public double getDensity() {
		return density;
	}
	public void setDensity(double density) {
		this.density = density;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

    
    
}
