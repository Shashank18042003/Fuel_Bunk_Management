package com.example.demo.Model.serviceImp;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.Model.pojos.OrderStatusHistory;
import com.example.demo.Model.serviceDesign.NotificationService;

@Service
public class NotificationServiceImpl implements NotificationService {

	@Override
	public OrderStatusHistory sendNotification(OrderStatusHistory notification) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<OrderStatusHistory> getNotificationsByUser(int userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void markAsRead(int notificationId) {
		// TODO Auto-generated method stub
		
	}

	
}