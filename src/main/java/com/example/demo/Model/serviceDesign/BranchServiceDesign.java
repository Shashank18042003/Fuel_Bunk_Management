package com.example.demo.Model.serviceDesign;

import java.util.List;
import java.util.Optional;

import com.example.demo.Model.pojos.Branch;

public interface BranchServiceDesign {

	// CREATE BRANCH

	Branch createBranch(Branch branch);

	// FIND ACTIVE BRANCHES

	List<Branch> findAllActive();

	// FIND ALL BRANCHES

	List<Branch> findAll();

	// FIND BY ID

	Optional<Branch> findById(Long id);

	// FIND BY CODE

	Optional<Branch> findByCode(String code);

	// UPDATE BRANCH

	Branch update(Branch branch);

	// TOGGLE ACTIVE

	void toggleActive(Long id);

	// FIND NEAREST BRANCHES

	List<Branch> findNearestBranches(double lat, double lng, int limit);

	// COUNT ACTIVE BRANCHES

	long countActiveBranches();

}
