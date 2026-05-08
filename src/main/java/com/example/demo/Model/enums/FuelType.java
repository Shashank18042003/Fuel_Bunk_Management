package com.example.demo.Model.enums;

public enum FuelType {
	PETROL("Petrol", 5.0, "⛽"), DIESEL("Diesel", 10.0, "🔧");

	private final String displayName;
	private final double maxOrderLitres;
	private final String icon;

	FuelType(String displayName, double maxOrderLitres, String icon) {
		this.displayName = displayName;
		this.maxOrderLitres = maxOrderLitres;
		this.icon = icon;
	}

	public String getDisplayName() {
		return displayName;
	}

	public double getMaxOrderLitres() {
		return maxOrderLitres;
	}

	public String getIcon() {
		return icon;
	}
}