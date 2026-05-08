package com.example.demo.Model.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.demo.Model.enums.PaymentStatus;
import com.example.demo.Model.pojos.Payment;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, Long> {

	Optional<Payment> findByTransactionId(String transactionId);

	Optional<Payment> findByOrderId(Long orderId);

	List<Payment> findByStatus(PaymentStatus status);

	@Query("SELECT p FROM Payment p ORDER BY p.createdAt DESC")
	List<Payment> findAllOrderByCreatedAtDesc();

	@Query("SELECT SUM(p.amount) FROM Payment p WHERE p.status = 'SUCCESS'")
	Double getTotalSuccessfulRevenue();
}