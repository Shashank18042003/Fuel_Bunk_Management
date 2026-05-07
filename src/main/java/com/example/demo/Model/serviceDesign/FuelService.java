package com.example.demo.Model.serviceDesign;

import java.util.List;

import com.example.demo.Model.pojos.FuelStock;

public interface FuelService {

	FuelStock addFuelStock(FuelStock fuelStock);
	FuelStock updateFuelStock(int stockId, FuelStock fuelStock);
	FuelStock getFuelStockByBranch(int branchId);
	List<FuelStock> getAllFuelStocks();
	String checkFuelStatus(double liters);

}
