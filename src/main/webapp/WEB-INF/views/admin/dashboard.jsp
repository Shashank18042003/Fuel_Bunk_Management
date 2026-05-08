<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Admin Dashboard"/>
<c:set var="currentPage" value="admin-dashboard"/>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- Stat Cards -->
<div class="fc-stats fc-mb-6">
    <div class="fc-stat amber">
        <div class="fc-stat-label">Active Branches</div>
        <div class="fc-stat-value">${totalBranches}</div>
        <div class="fc-stat-sub">Across all cities</div>
    </div>
    <div class="fc-stat">
        <div class="fc-stat-label">Registered Users</div>
        <div class="fc-stat-value">${totalUsers}</div>
        <div class="fc-stat-sub">Active accounts</div>
    </div>
    <div class="fc-stat">
        <div class="fc-stat-label">Branch Managers</div>
        <div class="fc-stat-value">${totalManagers}</div>
        <div class="fc-stat-sub">Across all branches</div>
    </div>
    <div class="fc-stat warning">
        <div class="fc-stat-label">Pending Orders</div>
        <div class="fc-stat-value">${pendingOrders}</div>
        <div class="fc-stat-sub">Awaiting dispatch</div>
    </div>
    <div class="fc-stat success">
        <div class="fc-stat-label">Today's Revenue</div>
        <div class="fc-stat-value">
            ₹<fmt:formatNumber value="${todayRevenue != null ? todayRevenue : 0}" maxFractionDigits="0"/>
        </div>
        <div class="fc-stat-sub">Delivered orders</div>
    </div>
    <div class="fc-stat ${outOfStockCount > 0 ? 'danger' : ''}">
        <div class="fc-stat-label">Out of Stock</div>
        <div class="fc-stat-value">${outOfStockCount}</div>
        <div class="fc-stat-sub">Inventory slots</div>
    </div>
</div>

<!-- Fuel Volume Overview -->
<div class="fc-grid-2 fc-mb-6">
    <div class="fc-card">
        <div class="fc-card-header">
            <span class="fc-card-title">⛽ Petrol — Total Available</span>
            <span class="fc-badge info">LIVE</span>
        </div>
        <div class="fc-card-body">
            <div style="font-size:36px;font-weight:700;font-family:var(--font-mono);color:var(--fc-petrol);letter-spacing:-1px;">
                <fmt:formatNumber value="${totalPetrolLitres != null ? totalPetrolLitres : 0}" maxFractionDigits="0"/>
                <span style="font-size:16px;font-weight:400;color:var(--fc-text-muted);"> L</span>
            </div>
            <div style="color:var(--fc-text-muted);font-size:12px;margin-top:4px;">Combined across all active branches</div>
        </div>
    </div>
    <div class="fc-card">
        <div class="fc-card-header">
            <span class="fc-card-title">🔧 Diesel — Total Available</span>
            <span class="fc-badge amber">LIVE</span>
        </div>
        <div class="fc-card-body">
            <div style="font-size:36px;font-weight:700;font-family:var(--font-mono);color:var(--fc-diesel);letter-spacing:-1px;">
                <fmt:formatNumber value="${totalDieselLitres != null ? totalDieselLitres : 0}" maxFractionDigits="0"/>
                <span style="font-size:16px;font-weight:400;color:var(--fc-text-muted);"> L</span>
            </div>
            <div style="color:var(--fc-text-muted);font-size:12px;margin-top:4px;">Combined across all active branches</div>
        </div>
    </div>
</div>

<!-- Low Stock Alerts -->
<c:if test="${not empty lowAlerts}">
<div class="fc-card fc-mb-6">
    <div class="fc-card-header">
        <span class="fc-card-title">⚠ Stock Alerts</span>
        <span class="fc-badge danger">${lowAlerts.size()} Issues</span>
    </div>
    <table class="fc-table">
        <thead>
            <tr>
                <th>Branch</th>
                <th>Fuel Type</th>
                <th>Available (L)</th>
                <th>Tank %</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="inv" items="${lowAlerts}">
            <tr>
                <td><strong>${inv.branch.branchName}</strong><br>
                    <small style="color:var(--fc-text-muted);font-family:var(--font-mono);">${inv.branch.branchCode}</small>
                </td>
                <td>
                    <c:if test="${inv.fuelType == 'PETROL'}"><span class="fuel-petrol">⛽ Petrol</span></c:if>
                    <c:if test="${inv.fuelType == 'DIESEL'}"><span class="fuel-diesel">🔧 Diesel</span></c:if>
                </td>
                <td class="fc-mono"><fmt:formatNumber value="${inv.availableVolumeLitres}" maxFractionDigits="1"/></td>
                <td>
                    <div class="fc-gauge-wrap" style="min-width:100px;">
                        <div class="fc-gauge-bar">
                            <div class="fc-gauge-fill ${inv.status == 'OUT_OF_STOCK' ? 'empty' : 'low'}"
                                 style="width:${inv.volumePercentage}%"></div>
                        </div>
                        <div class="fc-gauge-labels">
                            <span><fmt:formatNumber value="${inv.volumePercentage}" maxFractionDigits="1"/>%</span>
                        </div>
                    </div>
                </td>
                <td>
                    <span class="fc-badge ${inv.status == 'OUT_OF_STOCK' ? 'danger' : 'warning'}">
                        ${inv.status.displayName}
                    </span>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/inventory" class="fc-btn fc-btn-sm fc-btn-secondary">
                        Replenish
                    </a>
                </td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</c:if>

<!-- Pending Orders + Branch Performance -->
<div class="fc-grid-2">
    <!-- Pending Orders -->
    <div class="fc-card">
        <div class="fc-card-header">
            <span class="fc-card-title">Pending Orders</span>
            <a href="${pageContext.request.contextPath}/admin/orders" class="fc-btn fc-btn-ghost fc-btn-sm">View all</a>
        </div>
        <c:choose>
            <c:when test="${empty recentOrders}">
                <div class="fc-card-body" style="text-align:center;color:var(--fc-text-muted);padding:32px;">
                    ✓ No pending orders
                </div>
            </c:when>
            <c:otherwise>
                <table class="fc-table">
                    <thead>
                        <tr><th>Order #</th><th>User</th><th>Fuel</th><th>Amount</th><th>Action</th></tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${recentOrders}" end="4">
                        <tr>
                            <td class="fc-mono" style="font-size:11px;">${order.orderNumber}</td>
                            <td>${order.user.fullName}</td>
                            <td>
                                <c:if test="${order.fuelType == 'PETROL'}"><span class="fuel-petrol">Petrol</span></c:if>
                                <c:if test="${order.fuelType == 'DIESEL'}"><span class="fuel-diesel">Diesel</span></c:if>
                                <br><small class="fc-mono">${order.quantityLitres}L</small>
                            </td>
                            <td class="fc-mono">₹<fmt:formatNumber value="${order.grandTotal}" maxFractionDigits="2"/></td>
                            <td>
                                <form method="post" action="${pageContext.request.contextPath}/admin/orders/${order.id}/status" style="display:inline;">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <input type="hidden" name="status" value="CONFIRMED"/>
                                    <button type="submit" class="fc-btn fc-btn-primary fc-btn-sm">Confirm</button>
                                </form>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Branch Performance -->
    <div class="fc-card">
        <div class="fc-card-header">
            <span class="fc-card-title">Branch Performance</span>
            <a href="${pageContext.request.contextPath}/admin/reports" class="fc-btn fc-btn-ghost fc-btn-sm">Reports →</a>
        </div>
        <div class="fc-card-body">
            <c:choose>
                <c:when test="${empty branchPerformance}">
                    <div style="text-align:center;color:var(--fc-text-muted);padding:20px;">No data yet</div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="row" items="${branchPerformance}">
                    <div style="margin-bottom:14px;">
                        <div class="fc-flex fc-gap-2" style="justify-content:space-between;margin-bottom:4px;">
                            <span style="font-size:13px;font-weight:500;">${row[0]}</span>
                            <span class="fc-mono" style="font-size:12px;color:var(--fc-amber);">
                                ₹<fmt:formatNumber value="${row[2]}" maxFractionDigits="0"/>
                            </span>
                        </div>
                        <div style="font-size:11px;color:var(--fc-text-muted);">${row[1]} orders delivered</div>
                    </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
