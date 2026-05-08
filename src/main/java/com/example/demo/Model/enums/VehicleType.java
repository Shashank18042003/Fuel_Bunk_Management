package com.example.demo.Model.enums;

public enum VehicleType {
	BIKE("Bike", 5.0, FuelType.PETROL), CAR("Car", 10.0, null), // can take both
	TRUCK("Truck", 10.0, FuelType.DIESEL), AUTO("Auto Rickshaw", 5.0, null);

	private final String displayName;
	private final double maxLitres;
	private final FuelType preferredFuel;

	VehicleType(String displayName, double maxLitres, FuelType preferredFuel) {
		this.displayName = displayName;
		this.maxLitres = maxLitres;
		this.preferredFuel = preferredFuel;
	}

	public String getDisplayName() {
		return displayName;
	}

	public double getMaxLitres() {
		return maxLitres;
	}

	public FuelType getPreferredFuel() {
		return preferredFuel;
	}
}