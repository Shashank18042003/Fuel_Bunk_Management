package com.example.demo.Model.serviceImp;


import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Model.pojos.Payment;
import com.example.demo.Model.repository.PaymentRepository;
import com.example.demo.Model.serviceDesign.PaymentService;

@Service
public class PaymentServiceImpl implements PaymentService {

    @Autowired
    private PaymentRepository paymentRepository;

    @Override
    public Payment makePayment(Payment payment) {

        payment.setPaymentStatus("SUCCESS");

        payment.setPaidAt(LocalDateTime.now());

        return paymentRepository.save(payment);
    }

    @Override
    public Payment updatePaymentStatus(int paymentId,
                                       String status) {

        Payment payment =
                paymentRepository.findById(paymentId)
                .orElseThrow(() ->
                        new RuntimeException("Payment Not Found"));

        payment.setPaymentStatus(status);

        return paymentRepository.save(payment);
    }

    @Override
    public Payment getPaymentByOrderId(int orderId) {

        return paymentRepository.findByOrderId(orderId);
    }

    @Override
    public List<Payment> getAllPayments() {

        return paymentRepository.findAll();
    }
}