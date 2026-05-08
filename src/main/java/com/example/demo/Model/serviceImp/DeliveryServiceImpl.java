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

	@Override
	public Delivery assignDeliveryAgent(int orderId, int agentId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Delivery updateDeliveryStatus(int deliveryId, String status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Delivery getDeliveryByOrderId(int orderId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Delivery> getAllDeliveries() {
		// TODO Auto-generated method stub
		return null;
	}

    
}
