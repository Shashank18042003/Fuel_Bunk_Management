package com.example.demo.Model.serviceImp;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.Model.pojos.Notification;
import com.example.demo.Model.serviceDesign.NotificationService;

@Service
public class NotificationServiceImpl implements NotificationService {

	private List<Notification> notificationList = new ArrayList<>();

	@Override
	public Notification sendNotification(Notification notification) {

		notification.setCreatedAt(LocalDateTime.now());

		notification.setRead(false);

		notificationList.add(notification);

		return notification;
	}

	@Override
	public void markAsRead(int notificationId) {

		for (Notification notification : notificationList) {

			if (notification.getId() == notificationId) {

				notification.setRead(true);
			}
		}
	}

	@Override
	public List<Notification> getNotificationsByUser(int userId) {

		List<Notification> userNotifications = new ArrayList<>();

		for (Notification notification : notificationList) {

			if (notification.getUser().getId() == userId) {

				userNotifications.add(notification);
			}
		}

		return userNotifications;
	}
}