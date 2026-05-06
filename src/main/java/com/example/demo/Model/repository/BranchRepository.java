package com.example.demo.Model.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.Model.pojos.Branch;

public interface BranchRepository extends JpaRepository<Branch, Integer> {

	List<Branch> findByLocation(String location);

	Branch findByBranchName(String branchName);

}
