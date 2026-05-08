package com.example.demo.Model.serviceImp;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.Model.enums.FuelStatus;
import com.example.demo.Model.enums.FuelType;
import com.example.demo.Model.pojos.Branch;
import com.example.demo.Model.pojos.FuelInventory;
import com.example.demo.Model.repository.FuelInventoryRepository;
import com.example.demo.Model.serviceDesign.FuelInventoryServiceDesign;

@Service
@Transactional
public class FuelInventoryService implements FuelInventoryServiceDesign {

	// ================= LOGGER =================

	private static final Logger logger = LoggerFactory.getLogger(FuelInventoryService.class);

	// ================= REPOSITORY =================

	@Autowired
	private FuelInventoryRepository inventoryRepository;

	// ================= INITIALIZE INVENTORY =================

	@Override
	public void initializeInventoryForBranch(Branch branch) {

		for (FuelType type : FuelType.values()) {

			FuelInventory inventory = new FuelInventory();

			inventory.setBranch(branch);

			inventory.setFuelType(type);

			inventory.setAvailableVolumeLitres(BigDecimal.ZERO);

			inventory.setTankCapacityLitres(BigDecimal.valueOf(10000));

			inventory.setDensityKgPerLitre(

					type == FuelType.PETROL

							?

							BigDecimal.valueOf(0.7300)

							:

							BigDecimal.valueOf(0.8200));

			inventory.setPricePerLitre(

					type == FuelType.PETROL

							?

							BigDecimal.valueOf(102.50)

							:

							BigDecimal.valueOf(88.75));

			inventory.setStatus(FuelStatus.OUT_OF_STOCK);

			inventory.setLowStockThresholdPercent(20);

			inventoryRepository.save(inventory);
		}

		logger.info("Inventory initialized for branch: {}", branch.getBranchName());
	}

	// ================= FIND BY BRANCH AND TYPE =================

	@Override
	@Transactional(readOnly = true)
	public Optional<FuelInventory> findByBranchAndType(Long branchId, FuelType type) {

		return inventoryRepository.findByBranchIdAndFuelType(branchId, type);
	}

	// ================= FIND BY BRANCH =================

	@Override
	@Transactional(readOnly = true)
	public List<FuelInventory> findByBranch(Long branchId) {

		return inventoryRepository.findByBranchId(branchId);
	}

	// ================= FIND ALL =================

	@Override
	@Transactional(readOnly = true)
	public List<FuelInventory> findAll() {

		return inventoryRepository.findAll();
	}

	// ================= LOW OR OUT STOCK =================

	@Override
	@Transactional(readOnly = true)
	public List<FuelInventory> findLowOrOutOfStock() {

		return inventoryRepository.findLowOrOutOfStockInventories();
	}

	// ================= REPLENISH =================

	@Override
	public FuelInventory replenish(Long branchId, FuelType type, BigDecimal litres) {

		FuelInventory inventory = inventoryRepository.findByBranchIdAndFuelType(branchId, type)

				.orElseThrow(() -> new RuntimeException("Inventory not found"));

		BigDecimal newVolume = inventory.getAvailableVolumeLitres().add(litres);

		if (newVolume.compareTo(inventory.getTankCapacityLitres()) > 0) {

			throw new RuntimeException(

					"Cannot exceed tank capacity of "

							+

							inventory.getTankCapacityLitres()

							+

							" litres");
		}

		inventory.setAvailableVolumeLitres(newVolume);

		inventory.setLastReplenishedAt(LocalDateTime.now());

		inventory.recalculateStatus();

		logger.info("Replenished {} L of {} at branch {}", litres, type, branchId);

		return inventoryRepository.save(inventory);
	}

	// ================= DEDUCT FUEL =================

	@Override
	public FuelInventory deductFuel(Long branchId, FuelType type, BigDecimal litres) {

		FuelInventory inventory = inventoryRepository.findByBranchIdAndFuelType(branchId, type)

				.orElseThrow(() -> new RuntimeException("Inventory not found"));

		if (inventory.getAvailableVolumeLitres().compareTo(litres) < 0) {

			throw new RuntimeException(

					"Insufficient fuel. Available: "

							+

							inventory.getAvailableVolumeLitres()

							+

							"L, Requested: "

							+

							litres

							+

							"L");
		}

		inventory.setAvailableVolumeLitres(

				inventory.getAvailableVolumeLitres().subtract(litres));

		inventory.recalculateStatus();

		return inventoryRepository.save(inventory);
	}

	// ================= UPDATE PRICE =================

	@Override
	public void updatePrice(Long branchId, FuelType type, BigDecimal newPrice) {

		FuelInventory inventory = inventoryRepository.findByBranchIdAndFuelType(branchId, type)

				.orElseThrow(() -> new RuntimeException("Inventory not found"));

		inventory.setPricePerLitre(newPrice);

		inventoryRepository.save(inventory);
	}

	// ================= BROADCAST PRICE =================

	@Override
	public void broadcastPrice(FuelType type, BigDecimal newPrice) {

		List<FuelInventory> inventories = inventoryRepository.findAll();

		inventories.stream()

				.filter(i -> i.getFuelType() == type)

				.forEach(i -> {

					i.setPricePerLitre(newPrice);

					inventoryRepository.save(i);

				});

		logger.info("Global price update: {} = ₹{}", type, newPrice);
	}

	// ================= UPDATE DENSITY =================

	@Override
	public void updateDensity(Long branchId, FuelType type, BigDecimal density) {

		FuelInventory inventory = inventoryRepository.findByBranchIdAndFuelType(branchId, type)

				.orElseThrow(() -> new RuntimeException("Inventory not found"));

		inventory.setDensityKgPerLitre(density);

		inventoryRepository.save(inventory);
	}

	// ================= COUNT OUT OF STOCK =================

	@Override
	@Transactional(readOnly = true)
	public long countOutOfStock() {

		return inventoryRepository.countOutOfStock();
	}

	// ================= TOTAL VOLUME =================

	@Override
	@Transactional(readOnly = true)
	public Double getTotalVolumeByType(FuelType type) {

		Double volume = inventoryRepository.getTotalVolumeByType(type);

		return volume != null ? volume : 0.0;
	}

}