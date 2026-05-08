package com.example.demo.Model.serviceImp;


import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.Model.pojos.Payment;
import com.example.demo.Model.serviceDesign.PaymentService;

@Service
public class PaymentServiceImpl implements PaymentService {

	@Override
	public Payment makePayment(Payment payment) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Payment updatePaymentStatus(int paymentId, String status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Payment getPaymentByOrderId(int orderId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Payment> getAllPayments() {
		// TODO Auto-generated method stub
		return null;
	}

 
}