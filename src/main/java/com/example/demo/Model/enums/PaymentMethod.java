package com.example.demo.Model.enums;

public enum PaymentMethod {
	CASH_ON_DELIVERY("Cash on Delivery"), ONLINE_UPI("UPI"), ONLINE_CARD("Card"), ONLINE_NETBANKING("Net Banking");

	private final String displayName;

	PaymentMethod(String displayName) {
		this.displayName = displayName;
	}

	public String getDisplayName() {
		return displayName;
	}
}