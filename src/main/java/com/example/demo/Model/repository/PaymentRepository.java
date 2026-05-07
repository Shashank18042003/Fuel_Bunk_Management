package com.example.demo.Model.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.Model.pojos.Payment;

public interface PaymentRepository extends JpaRepository<Payment, Integer> {
	
	Payment findByTransactionId(String transactionId);

    Payment findByOrderId(int orderId);

    List<Payment> findByPaymentStatus(String status);

}
