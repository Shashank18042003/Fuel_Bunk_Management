package com.example.demo.Model.enums;

public enum FuelStatus {
	AVAILABLE("Available", "success"), LOW("Low Stock", "warning"), OUT_OF_STOCK("Out of Stock", "danger"),
	REPLENISHING("Replenishing", "info");

	private final String displayName;
	private final String badgeClass;

	FuelStatus(String displayName, String badgeClass) {
		this.displayName = displayName;
		this.badgeClass = badgeClass;
	}

	public String getDisplayName() {
		return displayName;
	}

	public String getBadgeClass() {
		return badgeClass;
	}
}