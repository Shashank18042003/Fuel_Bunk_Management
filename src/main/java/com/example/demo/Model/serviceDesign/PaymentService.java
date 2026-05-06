package com.example.demo.Model.serviceDesign;

import java.util.List;

import com.example.demo.Model.pojos.Payment;

public interface PaymentService {

	Payment makePayment(Payment payment);
    Payment updatePaymentStatus(int paymentId, String status);
    Payment getPaymentByOrderId(int orderId);
    List<Payment> getAllPayments();
}
