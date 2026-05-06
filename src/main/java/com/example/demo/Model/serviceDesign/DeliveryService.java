package com.example.demo.Model.serviceDesign;

import java.util.List;

import com.example.demo.Model.pojos.Delivery;

public interface DeliveryService {
	
	Delivery assignDeliveryAgent(int orderId, int agentId);
    Delivery updateDeliveryStatus(int deliveryId, String status);
    Delivery getDeliveryByOrderId(int orderId);
    List<Delivery> getAllDeliveries();

}
