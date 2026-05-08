package com.example.demo.Model.serviceDesign;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import com.example.demo.Model.enums.OrderStatus;
import com.example.demo.Model.pojos.Order;
import com.example.demo.Model.pojos.User;

public interface OrderServiceDesign {

    // PLACE ORDER

    Order placeOrder(Order order,
                     User currentUser);

    // UPDATE STATUS

    Order updateStatus(Long orderId,
                       OrderStatus newStatus,
                       String remarks,
                       User updatedBy);

    // ASSIGN DELIVERY AGENT

    Order assignDeliveryAgent(Long orderId,
                              User agent);

    // FIND BY USER

    List<Order> findByUser(Long userId);

    // FIND BY BRANCH

    List<Order> findByBranch(Long branchId);

    // FIND ALL

    List<Order> findAll();

    // FIND BY ID

    Optional<Order> findById(Long id);

    // FIND BY STATUS

    List<Order> findByStatus(OrderStatus status);

    // COUNT BY STATUS

    long countByStatus(OrderStatus status);

    // TOTAL REVENUE

    Double getTotalRevenueSince(
            LocalDateTime since);

    // BRANCH PERFORMANCE

    List<Object[]> getBranchPerformance();

}