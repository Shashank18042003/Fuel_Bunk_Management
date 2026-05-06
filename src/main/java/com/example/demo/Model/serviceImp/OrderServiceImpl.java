package com.example.demo.Model.serviceImp;



import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Model.pojos.Order;
import com.example.demo.Model.repository.OrderRepository;
import com.example.demo.Model.serviceDesign.OrderService;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Override
    public Order placeOrder(Order order) {

        if(order.getVechicleType().equalsIgnoreCase("BIKE")
                && order.getQuantity() > 5) {

            throw new RuntimeException(
                    "Bike Petrol Limit Exceeded");
        }

        if(order.getVechicleType().equalsIgnoreCase("TRUCK")
                && order.getQuantity() > 50) {

            throw new RuntimeException(
                    "Truck Diesel Limit Exceeded");
        }

        order.setOrderStatus("PENDING");
        order.setPaymentStatus("PENDING");
        order.setCreatedAt(LocalDateTime.now());

        return orderRepository.save(order);
    }

    @Override
    public Order updateOrderStatus(int orderId,
                                   String status) {

        Order order =
                orderRepository.findById(orderId)
                .orElseThrow(() ->
                        new RuntimeException("Order Not Found"));

        order.setOrderStatus(status);

        return orderRepository.save(order);
    }

    @Override
    public Order getOrderById(int orderId) {

        return orderRepository.findById(orderId)
                .orElseThrow(() ->
                        new RuntimeException("Order Not Found"));
    }

    @Override
    public List<Order> getOrdersByUser(int userId) {

        return orderRepository.findByUserId(userId);
    }

    @Override
    public List<Order> getAllOrders() {

        return orderRepository.findAll();
    }

    @Override
    public void cancelOrder(int orderId) {

        Order order =
                orderRepository.findById(orderId)
                .orElseThrow(() ->
                        new RuntimeException("Order Not Found"));

        order.setOrderStatus("CANCELLED");

        orderRepository.save(order);
    }
}