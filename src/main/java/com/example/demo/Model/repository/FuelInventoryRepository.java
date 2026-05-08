package com.example.demo.Model.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.Model.enums.FuelStatus;
import com.example.demo.Model.enums.FuelType;
import com.example.demo.Model.pojos.FuelInventory;

@Repository
public interface FuelInventoryRepository extends JpaRepository<FuelInventory, Long> {

	Optional<FuelInventory> findByBranchIdAndFuelType(Long branchId, FuelType fuelType);

	List<FuelInventory> findByBranchId(Long branchId);

	List<FuelInventory> findByFuelTypeAndStatus(FuelType fuelType, FuelStatus status);

	List<FuelInventory> findByStatus(FuelStatus status);

	@Query("SELECT fi FROM FuelInventory fi WHERE fi.status IN ('LOW', 'OUT_OF_STOCK')")
	List<FuelInventory> findLowOrOutOfStockInventories();

	@Query("SELECT COUNT(fi) FROM FuelInventory fi WHERE fi.status = 'OUT_OF_STOCK'")
	long countOutOfStock();

	@Query("SELECT SUM(fi.availableVolumeLitres) FROM FuelInventory fi WHERE fi.fuelType = :type")
	Double getTotalVolumeByType(@Param("type") FuelType type);
}