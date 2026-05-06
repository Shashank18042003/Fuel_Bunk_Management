package com.example.demo.Model.serviceDesign;

import java.util.List;

import com.example.demo.Model.pojos.Notification;

public interface NotificationService {
	
	Notification sendNotification(Notification notification);
    List<Notification> getNotificationsByUser(int userId);
    void markAsRead(int notificationId);

}
