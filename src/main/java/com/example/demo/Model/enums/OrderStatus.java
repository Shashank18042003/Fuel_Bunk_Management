package com.example.demo.Model.enums;

public enum OrderStatus {
	PENDING("Pending", "warning"), CONFIRMED("Confirmed", "info"), DISPATCHED("Dispatched", "primary"),
	DELIVERED("Delivered", "success"), CANCELLED("Cancelled", "danger"), FAILED("Failed", "danger");

	private final String displayName;
	private final String badgeClass;

	OrderStatus(String displayName, String badgeClass) {
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