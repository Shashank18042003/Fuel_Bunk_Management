package com.example.demo.Model.serviceImp;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.example.demo.Model.serviceDesign.ReportService;

@Service
public class ReportServiceImpl implements ReportService {

	@Override
	public Map<String, Object> getDailySalesReport() {

		Map<String, Object> report = new HashMap<>();

		report.put("date", LocalDate.now());

		report.put("totalOrders", 120);

		report.put("totalRevenue", 45000.00);

		report.put("petrolSales", 2500);

		report.put("dieselSales", 1800);

		return report;
	}

	@Override
	public Map<String, Object> getBranchPerformanceReport() {

		Map<String, Object> report = new HashMap<>();

		report.put("bestBranch", "Miyapur Branch");

		report.put("highestSales", 95000.00);

		report.put("lowestSales", 25000.00);

		report.put("activeBranches", 8);

		return report;
	}

	@Override
	public Map<String, Object> getFuelConsumptionReport() {

		Map<String, Object> report = new HashMap<>();

		report.put("petrolConsumed", 5000);

		report.put("dieselConsumed", 3500);

		report.put("remainingPetrol", 2000);

		report.put("remainingDiesel", 1500);

		return report;
	}
}