package com.example.demo.Model.serviceDesign;

import java.util.Map;

public interface ReportService {
	
	Map<String, Object> getDailySalesReport();
    Map<String, Object> getBranchPerformanceReport();
    Map<String, Object> getFuelConsumptionReport();

}
