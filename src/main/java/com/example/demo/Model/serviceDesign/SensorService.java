package com.example.demo.Model.serviceDesign;

public interface SensorService {
	
	double getTankLevel(int branchId);

	double getFuelDensity(int branchId);

	void updateSensorData(int branchId);

}
