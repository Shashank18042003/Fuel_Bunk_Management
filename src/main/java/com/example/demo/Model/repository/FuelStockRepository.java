package com.example.demo.Model.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.example.demo.Model.pojos.FuelStock;

public interface FuelStockRepository extends JpaRepository<FuelStock, Integer> {

	List<FuelStock> findByFuelType(String fuelType);

	List<FuelStock> findByStatus(String status);

	FuelStock findByBranchId(int branchId);

	@Query("select f from FuelStock f where f.availableLiters < 1000")
	List<FuelStock> getLowStockBranches();
}
