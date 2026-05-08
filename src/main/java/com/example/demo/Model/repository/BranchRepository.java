package com.example.demo.Model.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.Model.pojos.Branch;

@Repository
public interface BranchRepository extends JpaRepository<Branch, Long> {

	// ================= FIND BY BRANCH CODE =================

	Optional<Branch> findByBranchCode(String branchCode);

	// ================= ACTIVE BRANCHES =================

	List<Branch> findByActiveTrue();

	// ================= FIND BY CITY =================

	List<Branch> findByCity(String city);

	// ================= CHECK BRANCH CODE =================

	boolean existsByBranchCode(String branchCode);

	// ================= NEAREST BRANCHES =================
	/*
	 * Haversine Formula Distance in KM
	 */

	@Query(value = """

			SELECT *,

			(
			    6371 * acos(

			        cos(radians(:lat)) *

			        cos(radians(latitude)) *

			        cos(radians(longitude)
			        - radians(:lng))

			        +

			        sin(radians(:lat)) *

			        sin(radians(latitude))

			    )

			) AS distance

			FROM branches

			WHERE active = true

			ORDER BY distance

			""",

			nativeQuery = true)

	List<Branch> findNearestBranches(

			@Param("lat") double lat,

			@Param("lng") double lng,

			Pageable pageable);

	// ================= COUNT ACTIVE =================

	long countByActiveTrue();

}