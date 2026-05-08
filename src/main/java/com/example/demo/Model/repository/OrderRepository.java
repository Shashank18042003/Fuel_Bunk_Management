package com.example.demo.Model.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.Model.enums.FuelType;
import com.example.demo.Model.enums.OrderStatus;
import com.example.demo.Model.pojos.Order;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

	Optional<Order> findByOrderNumber(String orderNumber);

	List<Order> findByUserId(Long userId);

	List<Order> findByBranchId(Long branchId);

	List<Order> findByBranchIdAndStatus(Long branchId, OrderStatus status);

	List<Order> findByStatus(OrderStatus status);

	List<Order> findByUserIdOrderByCreatedAtDesc(Long userId);

	@Query("SELECT o FROM Order o WHERE o.branch.id = :branchId ORDER BY o.createdAt DESC")
	List<Order> findByBranchIdOrderByCreatedAtDesc(@Param("branchId") Long branchId);

	@Query("SELECT o FROM Order o WHERE o.createdAt BETWEEN :start AND :end")
	List<Order> findByDateRange(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

	@Query("SELECT o FROM Order o WHERE o.branch.id = :branchId AND o.createdAt BETWEEN :start AND :end")
	List<Order> findByBranchAndDateRange(@Param("branchId") Long branchId, @Param("start") LocalDateTime start,
			@Param("end") LocalDateTime end);

	// Dashboard stats
	long countByStatus(OrderStatus status);

	@Query("SELECT SUM(o.grandTotal) FROM Order o WHERE o.status = 'DELIVERED' AND o.createdAt >= :since")
	Double getTotalRevenueFromDate(@Param("since") LocalDateTime since);

	@Query("SELECT SUM(o.quantityLitres) FROM Order o WHERE o.fuelType = :type AND o.status = 'DELIVERED'")
	Double getTotalLitresDeliveredByType(@Param("type") FuelType type);

	@Query("""
			SELECT o.branch.branchName as branch, COUNT(o) as orders, SUM(o.grandTotal) as revenue
			FROM Order o WHERE o.status = 'DELIVERED'
			GROUP BY o.branch.id, o.branch.branchName
			ORDER BY revenue DESC
			""")
	List<Object[]> getBranchPerformance();

	long countByCreatedAtAfter(LocalDateTime since);
}