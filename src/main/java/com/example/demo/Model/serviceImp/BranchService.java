package com.example.demo.Model.serviceImp;

import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.Model.pojos.Branch;
import com.example.demo.Model.repository.BranchRepository;
import com.example.demo.Model.serviceDesign.BranchServiceDesign;

@Service
@Transactional
public class BranchService implements BranchServiceDesign {

	// ================= LOGGER =================

	private static final Logger logger = LoggerFactory.getLogger(BranchService.class);

	// ================= REPOSITORY =================

	@Autowired
	private BranchRepository branchRepository;

	// ================= INVENTORY SERVICE =================

	@Autowired
	private FuelInventoryService inventoryService;

	// ================= CREATE BRANCH =================

	@Override
	public Branch createBranch(Branch branch) {

		if (branchRepository.existsByBranchCode(branch.getBranchCode())) {

			throw new RuntimeException("Branch code already exists: " + branch.getBranchCode());
		}

		Branch savedBranch = branchRepository.save(branch);

		// AUTO CREATE INVENTORY

		inventoryService.initializeInventoryForBranch(savedBranch);

		logger.info("Branch created: {} - {}", savedBranch.getBranchCode(), savedBranch.getBranchName());

		return savedBranch;
	}

	// ================= FIND ACTIVE =================

	@Override
	@Transactional(readOnly = true)
	public List<Branch> findAllActive() {

		return branchRepository.findByActiveTrue();
	}

	// ================= FIND ALL =================

	@Override
	@Transactional(readOnly = true)
	public List<Branch> findAll() {

		return branchRepository.findAll();
	}

	// ================= FIND BY ID =================

	@Override
	@Transactional(readOnly = true)
	public Optional<Branch> findById(Long id) {

		return branchRepository.findById(id);
	}

	// ================= FIND BY CODE =================

	@Override
	@Transactional(readOnly = true)
	public Optional<Branch> findByCode(String code) {

		return branchRepository.findByBranchCode(code);
	}

	// ================= UPDATE =================

	@Override
	public Branch update(Branch branch) {

		return branchRepository.save(branch);
	}

	// ================= TOGGLE ACTIVE =================

	@Override
	public void toggleActive(Long id) {

		Branch branch = branchRepository.findById(id)
				.orElseThrow(() -> new RuntimeException("Branch not found: " + id));

		branch.setActive(!branch.isActive());

		branchRepository.save(branch);
	}

	// ================= FIND NEAREST =================

	@Override
	@Transactional(readOnly = true)
	public List<Branch> findNearestBranches(double lat, double lng, int limit) {

		Pageable pageable = PageRequest.of(0, limit);

		return branchRepository.findNearestBranches(lat, lng, pageable);
	}

	// ================= COUNT ACTIVE =================

	@Override
	@Transactional(readOnly = true)
	public long countActiveBranches() {

		return branchRepository.countByActiveTrue();
	}

}