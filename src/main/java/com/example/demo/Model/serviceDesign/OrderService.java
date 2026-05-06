package com.example.demo.Model.serviceDesign;

import java.util.List;

import com.example.demo.Model.pojos.Order;

public interface OrderService {
	
	Order placeOrder(Order order);
    Order updateOrderStatus(int orderId, String status);
    Order getOrderById(int orderId);
    List<Order> getOrdersByUser(int userId);
    List<Order> getAllOrders();
    void cancelOrder(int orderId);

}
