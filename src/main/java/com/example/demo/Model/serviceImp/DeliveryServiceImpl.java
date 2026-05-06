package com.example.demo.Model.serviceImp;


import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Model.pojos.Delivery;
import com.example.demo.Model.pojos.Order;
import com.example.demo.Model.pojos.User;
import com.example.demo.Model.repository.DeliveryRepository;
import com.example.demo.Model.repository.OrderRepository;
import com.example.demo.Model.repository.UserRepository;
import com.example.demo.Model.serviceDesign.DeliveryService;

@Service
public class DeliveryServiceImpl implements DeliveryService {

    @Autowired
    private DeliveryRepository deliveryRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private UserRepository userRepository;

    @Override
    public Delivery assignDeliveryAgent(int orderId,
                                        int agentId) {

        Order order =
                orderRepository.findById(orderId)
                .orElseThrow(() ->
                        new RuntimeException("Order Not Found"));

        User agent =
                userRepository.findById(agentId)
                .orElseThrow(() ->
                        new RuntimeException("Agent Not Found"));

        Delivery delivery = new Delivery();

        delivery.setOrder(order);
        delivery.setDeliveryAgent(agent);
        delivery.setStatus("ASSIGNED");
        delivery.setDispatchTime(LocalDateTime.now());

        order.setOrderStatus("DISPATCHED");

        orderRepository.save(order);

        return deliveryRepository.save(delivery);
    }

    @Override
    public Delivery updateDeliveryStatus(int deliveryId,
                                         String status) {

        Delivery delivery =
                deliveryRepository.findById(deliveryId)
                .orElseThrow(() ->
                        new RuntimeException("Delivery Not Found"));

        delivery.setStatus(status);

        if(status.equalsIgnoreCase("DELIVERED")) {

            delivery.setDeliveryTime(LocalDateTime.now());

            Order order = delivery.getOrder();

            order.setOrderStatus("DELIVERED");

            orderRepository.save(order);
        }

        return deliveryRepository.save(delivery);
    }

    @Override
    public Delivery getDeliveryByOrderId(int orderId) {

        return deliveryRepository.findByOrderId(orderId);
    }

    @Override
    public List<Delivery> getAllDeliveries() {

        return deliveryRepository.findAll();
    }
}
