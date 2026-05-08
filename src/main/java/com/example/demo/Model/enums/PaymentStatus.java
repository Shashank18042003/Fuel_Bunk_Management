package com.example.demo.Model.enums;

public enum PaymentStatus {
	PENDING("Pending", "warning"), SUCCESS("Success", "success"), FAILED("Failed", "danger"),
	REFUNDED("Refunded", "info");

	private final String displayName;
	private final String badgeClass;

	PaymentStatus(String displayName, String badgeClass) {
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