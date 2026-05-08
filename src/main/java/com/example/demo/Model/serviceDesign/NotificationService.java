package com.example.demo.Model.serviceDesign;

import java.util.List;

import com.example.demo.Model.pojos.OrderStatusHistory;

public interface NotificationService {
	
	OrderStatusHistory sendNotification(OrderStatusHistory notification);
    List<OrderStatusHistory> getNotificationsByUser(int userId);
    void markAsRead(int notificationId);

}
