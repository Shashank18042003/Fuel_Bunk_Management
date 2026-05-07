package com.example.demo.Model.serviceImp;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Model.pojos.Branch;
import com.example.demo.Model.repository.BranchRepository;
import com.example.demo.Model.serviceDesign.BranchService;

@Service
public class BranchServiceImpl implements BranchService {

    @Autowired
    private BranchRepository branchRepository;

    @Override
    public Branch addBranch(Branch branch) {

        branch.setStatus("ACTIVE");

        return branchRepository.save(branch);
    }

    @Override
    public Branch updateBranch(int branchId, Branch branch) {

        Branch existing =
                branchRepository.findById(branchId)
                .orElseThrow(() ->
                        new RuntimeException("Branch Not Found"));

        existing.setBranchName(branch.getBranchName());
        existing.setLocation(branch.getLocation());

        return branchRepository.save(existing);
    }

    @Override
    public void deleteBranch(int branchId) {

        branchRepository.deleteById(branchId);
    }

    @Override
    public Branch getBranchById(int branchId) {

        return branchRepository.findById(branchId)
                .orElseThrow(() ->
                        new RuntimeException("Branch Not Found"));
    }

    @Override
    public List<Branch> getAllBranches() {

        return branchRepository.findAll();
    }
}
