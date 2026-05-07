package com.example.demo.Model.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.example.demo.Model.pojos.Order;

public interface OrderRepository extends JpaRepository<Order, Integer> {
	
	List<Order> findByUserId(int userId);

    List<Order> findByOrderStatus(String status);

    List<Order> findByBranchId(int branchId);

    @Query("select o from Order o where o.paymentStatus='PENDING'")
    List<Order> getPendingPayments();

}
