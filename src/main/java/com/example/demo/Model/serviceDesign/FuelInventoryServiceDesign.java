package com.example.demo.Model.serviceDesign;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import com.example.demo.Model.enums.FuelType;
import com.example.demo.Model.pojos.Branch;
import com.example.demo.Model.pojos.FuelInventory;

public interface FuelInventoryServiceDesign {

	// INITIALIZE INVENTORY

	void initializeInventoryForBranch(Branch branch);

	// FIND BY BRANCH AND TYPE

	Optional<FuelInventory> findByBranchAndType(Long branchId, FuelType type);

	// FIND BY BRANCH

	List<FuelInventory> findByBranch(Long branchId);

	// FIND ALL

	List<FuelInventory> findAll();

	// LOW OR OUT STOCK

	List<FuelInventory> findLowOrOutOfStock();

	// REPLENISH

	FuelInventory replenish(Long branchId, FuelType type, BigDecimal litres);

	// DEDUCT FUEL

	FuelInventory deductFuel(Long branchId, FuelType type, BigDecimal litres);

	// UPDATE PRICE

	void updatePrice(Long branchId, FuelType type, BigDecimal newPrice);

	// BROADCAST PRICE

	void broadcastPrice(FuelType type, BigDecimal newPrice);

	// UPDATE DENSITY

	void updateDensity(Long branchId, FuelType type, BigDecimal density);

	// COUNT OUT OF STOCK

	long countOutOfStock();

	// TOTAL VOLUME

	Double getTotalVolumeByType(FuelType type);

}
