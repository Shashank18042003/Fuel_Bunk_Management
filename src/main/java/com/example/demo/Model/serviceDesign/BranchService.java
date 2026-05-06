package com.example.demo.Model.serviceDesign;

import java.util.List;

import com.example.demo.Model.pojos.Branch;

public interface BranchService {

	Branch addBranch(Branch branch);
	Branch updateBranch(int branchId, Branch branch);
	void deleteBranch(int branchId);
	Branch getBranchById(int branchId);
	List<Branch> getAllBranches();
}
