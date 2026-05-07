package com.example.demo.Model.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.Model.pojos.Delivery;

public interface DeliveryRepository extends JpaRepository<Delivery, Integer> {
	
	List<Delivery> findByStatus(String status);

    Delivery findByOrderId(int orderId);

    List<Delivery> findByDeliveryAgentId(int agentId);

}
