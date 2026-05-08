package com.example.demo.config;

import java.math.BigDecimal;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.Model.enums.FuelType;
import com.example.demo.Model.enums.Role;
import com.example.demo.Model.enums.VehicleType;
import com.example.demo.Model.pojos.Branch;
import com.example.demo.Model.pojos.User;
import com.example.demo.Model.repository.BranchRepository;
import com.example.demo.Model.repository.FuelInventoryRepository;
import com.example.demo.Model.repository.UserRepository;
import com.example.demo.Model.serviceImp.FuelInventoryService;

@Component
@Transactional
public class DataInitializer implements CommandLineRunner {

	// ================= LOGGER =================

	private static final Logger log = LoggerFactory.getLogger(DataInitializer.class);

	// ================= DEPENDENCIES =================

	private final UserRepository userRepository;

	private final BranchRepository branchRepository;

	private final FuelInventoryRepository inventoryRepository;

	private final FuelInventoryService inventoryService;

	private final PasswordEncoder passwordEncoder;

	// ================= CONSTRUCTOR =================

	public DataInitializer(

			UserRepository userRepository,

			BranchRepository branchRepository,

			FuelInventoryRepository inventoryRepository,

			FuelInventoryService inventoryService,

			PasswordEncoder passwordEncoder) {

		this.userRepository = userRepository;

		this.branchRepository = branchRepository;

		this.inventoryRepository = inventoryRepository;

		this.inventoryService = inventoryService;

		this.passwordEncoder = passwordEncoder;
	}

	// ================= RUN =================

	@Override
	public void run(String... args) {

		if (userRepository.count() > 0) {

			log.info("Data already initialized.");

			return;
		}

		log.info("Initializing FuelCore demo data...");

		// ================= ADMIN =================

		User admin = new User();

		admin.setFullName("FuelCore Admin");

		admin.setEmail("admin@fuelcore.com");

		admin.setPassword(passwordEncoder.encode("admin@123"));

		admin.setRole(Role.ADMIN);

		admin.setPhone("9000000001");

		admin.setActive(true);

		userRepository.save(admin);

		// ================= BRANCH 1 =================

		Branch b1 = new Branch();

		b1.setBranchCode("FC-HYD-001");

		b1.setBranchName("Hyderabad Central");

		b1.setAddress("Plot 42, MG Road, Secunderabad");

		b1.setCity("Hyderabad");

		b1.setState("Telangana");

		b1.setPinCode("500003");

		b1.setPhone("040-27654321");

		b1.setLatitude(17.4399);

		b1.setLongitude(78.4983);

		b1.setActive(true);

		branchRepository.save(b1);

		inventoryService.initializeInventoryForBranch(b1);

		// ================= BRANCH 2 =================

		Branch b2 = new Branch();

		b2.setBranchCode("FC-HYD-002");

		b2.setBranchName("Banjara Hills");

		b2.setAddress("Road No. 12, Banjara Hills");

		b2.setCity("Hyderabad");

		b2.setState("Telangana");

		b2.setPinCode("500034");

		b2.setPhone("040-23456789");

		b2.setLatitude(17.4156);

		b2.setLongitude(78.4347);

		b2.setActive(true);

		branchRepository.save(b2);

		inventoryService.initializeInventoryForBranch(b2);

		// ================= BRANCH 3 =================

		Branch b3 = new Branch();

		b3.setBranchCode("FC-HYD-003");

		b3.setBranchName("Gachibowli Tech Hub");

		b3.setAddress("Near DLF Cyber City, Gachibowli");

		b3.setCity("Hyderabad");

		b3.setState("Telangana");

		b3.setPinCode("500032");

		b3.setPhone("040-66778899");

		b3.setLatitude(17.4435);

		b3.setLongitude(78.3485);

		b3.setActive(true);

		branchRepository.save(b3);

		inventoryService.initializeInventoryForBranch(b3);

		// ================= MANAGER 1 =================

		User manager1 = new User();

		manager1.setFullName("Ravi Kumar");

		manager1.setEmail("manager1@fuelcore.com");

		manager1.setPassword(passwordEncoder.encode("manager@123"));

		manager1.setRole(Role.MANAGER);

		manager1.setPhone("9000000002");

		manager1.setBranch(b1);

		manager1.setActive(true);

		userRepository.save(manager1);

		// ================= MANAGER 2 =================

		User manager2 = new User();

		manager2.setFullName("Priya Sharma");

		manager2.setEmail("manager2@fuelcore.com");

		manager2.setPassword(passwordEncoder.encode("manager@123"));

		manager2.setRole(Role.MANAGER);

		manager2.setPhone("9000000003");

		manager2.setBranch(b2);

		manager2.setActive(true);

		userRepository.save(manager2);

		// ================= USER 1 =================

		User user1 = new User();

		user1.setFullName("Arjun Reddy");

		user1.setEmail("user@fuelcore.com");

		user1.setPassword(passwordEncoder.encode("user@123"));

		user1.setRole(Role.USER);

		user1.setPhone("9876543210");

		user1.setVehicleType(VehicleType.BIKE);

		user1.setVehicleNumber("TS09AB1234");

		user1.setActive(true);

		userRepository.save(user1);

		// ================= USER 2 =================

		User user2 = new User();

		user2.setFullName("Meena Kapoor");

		user2.setEmail("meena@fuelcore.com");

		user2.setPassword(passwordEncoder.encode("user@123"));

		user2.setRole(Role.USER);

		user2.setPhone("9876543211");

		user2.setVehicleType(VehicleType.CAR);

		user2.setVehicleNumber("AP28CD5678");

		user2.setActive(true);

		userRepository.save(user2);

		// ================= INVENTORY =================

		seedInventory(b1.getId(), FuelType.PETROL, 7500, 0.7320, 102.50);

		seedInventory(b1.getId(), FuelType.DIESEL, 2000, 0.8200, 88.75);

		seedInventory(b2.getId(), FuelType.PETROL, 9200, 0.7310, 102.50);

		seedInventory(b2.getId(), FuelType.DIESEL, 8500, 0.8195, 88.75);

		seedInventory(b3.getId(), FuelType.PETROL, 0, 0.7300, 102.50);

		seedInventory(b3.getId(), FuelType.DIESEL, 6700, 0.8210, 88.75);

		log.info("FuelCore demo data initialized.");
	}

	// ================= INVENTORY SEED =================

	private void seedInventory(

			Long branchId,

			FuelType fuelType,

			double litres,

			double density,

			double price) {

		inventoryRepository

				.findByBranchIdAndFuelType(branchId, fuelType)

				.ifPresent(inventory -> {

					inventory.setAvailableVolumeLitres(BigDecimal.valueOf(litres));

					inventory.setDensityKgPerLitre(BigDecimal.valueOf(density));

					inventory.setPricePerLitre(BigDecimal.valueOf(price));

					inventory.recalculateStatus();

					inventoryRepository.save(inventory);
				});
	}
}