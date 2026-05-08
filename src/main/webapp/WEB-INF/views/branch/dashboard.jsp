<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Branch Dashboard — ${branch.branchName}"/>
<c:set var="currentPage" value="branch-dashboard"/>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- Branch Info Banner -->
<div class="fc-card fc-mb-6" style="border-color:var(--fc-amber);border-left:3px solid var(--fc-amber);">
    <div class="fc-card-body" style="padding:16px 20px;">
        <div class="fc-flex fc-gap-3" style="justify-content:space-between;flex-wrap:wrap;">
            <div>
                <div style="font-size:18px;font-weight:700;">${branch.branchName}</div>
                <div class="fc-mono" style="font-size:11px;color:var(--fc-text-muted);margin-top:2px;">${branch.branchCode} &nbsp;|&nbsp; ${branch.address}, ${branch.city}</div>
            </div>
            <div class="fc-live"><span class="fc-live-dot"></span> LIVE TRACKING</div>
        </div>
    </div>
</div>

<!-- Quick Stats -->
<div class="fc-stats fc-mb-6">
    <div class="fc-stat warning">
        <div class="fc-stat-label">Pending Orders</div>
        <div class="fc-stat-value">${pendingOrders}</div>
        <div class="fc-stat-sub">Awaiting action</div>
    </div>
    <div class="fc-stat">
        <div class="fc-stat-label">Total Orders</div>
        <div class="fc-stat-value">${orders.size()}</div>
    </div>
    <c:if test="${not empty lowAlerts}">
    <div class="fc-stat danger">
        <div class="fc-stat-label">Stock Alerts</div>
        <div class="fc-stat-value">${lowAlerts.size()}</div>
        <div class="fc-stat-sub">Need replenishment</div>
    </div>
    </c:if>
</div>

<!-- Fuel Inventory Gauges -->
<div class="fc-card fc-mb-6">
    <div class="fc-card-header">
        <span class="fc-card-title">Live Fuel Levels</span>
        <a href="${pageContext.request.contextPath}/branch/inventory" class="fc-btn fc-btn-ghost fc-btn-sm">Manage →</a>
    </div>
    <div class="fc-card-body">
        <div class="fc-grid-2">
            <c:forEach var="inv" items="${inventories}">
            <div style="background:var(--fc-surface2);border:1px solid var(--fc-border);border-radius:10px;padding:18px;">
                <div class="fc-flex fc-gap-2" style="justify-content:space-between;margin-bottom:12px;">
                    <div style="font-size:15px;font-weight:600;">
                        <c:if test="${inv.fuelType == 'PETROL'}"><span class="fuel-petrol">⛽ Petrol</span></c:if>
                        <c:if test="${inv.fuelType == 'DIESEL'}"><span class="fuel-diesel">🔧 Diesel</span></c:if>
                    </div>
                    <span class="fc-badge ${inv.status == 'AVAILABLE' ? 'success' : inv.status == 'LOW' ? 'warning' : 'danger'}">
                        ${inv.status.displayName}
                    </span>
                </div>

                <div class="fc-gauge-bar" style="height:10px;margin-bottom:8px;">
                    <div class="fc-gauge-fill ${inv.status == 'OUT_OF_STOCK' ? 'empty' : inv.status == 'LOW' ? 'low' : inv.fuelType == 'PETROL' ? 'petrol' : 'diesel'}"
                         style="width:${inv.volumePercentage}%"></div>
                </div>

                <div style="display:grid;grid-template-columns:1fr 1fr 1fr;gap:12px;margin-top:12px;">
                    <div>
                        <div class="fc-stat-label">Volume</div>
                        <div class="fc-mono" style="font-size:16px;font-weight:600;">
                            <fmt:formatNumber value="${inv.availableVolumeLitres}" maxFractionDigits="1"/>
                            <span style="font-size:11px;color:var(--fc-text-muted);">L</span>
                        </div>
                    </div>
                    <div>
                        <div class="fc-stat-label">Density</div>
                        <div class="fc-mono" style="font-size:14px;">${inv.densityKgPerLitre} kg/L</div>
                    </div>
                    <div>
                        <div class="fc-stat-label">Price / L</div>
                        <div class="fc-mono" style="font-size:14px;color:var(--fc-amber);">₹${inv.pricePerLitre}</div>
                    </div>
                </div>
            </div>
            </c:forEach>
        </div>
    </div>
</div>

<!-- Alerts -->
<c:if test="${not empty lowAlerts}">
<div class="fc-alert warning fc-mb-6">
    ⚠ Low stock detected on ${lowAlerts.size()} fuel type(s).
    <a href="${pageContext.request.contextPath}/branch/inventory" style="color:inherit;font-weight:700;">Manage →</a>
</div>
</c:if>

<!-- Recent Orders -->
<div class="fc-card">
    <div class="fc-card-header">
        <span class="fc-card-title">Recent Orders</span>
        <a href="${pageContext.request.contextPath}/branch/orders" class="fc-btn fc-btn-ghost fc-btn-sm">View All →</a>
    </div>
    <table class="fc-table">
        <thead>
            <tr><th>Order #</th><th>User</th><th>Fuel</th><th>Qty</th><th>Amount</th><th>Status</th><th>Time</th></tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${orders}" end="9">
            <tr>
                <td class="fc-mono" style="font-size:11px;">${order.orderNumber}</td>
                <td>${order.user.fullName}</td>
                <td>
                    <c:if test="${order.fuelType == 'PETROL'}"><span class="fuel-petrol">⛽</span></c:if>
                    <c:if test="${order.fuelType == 'DIESEL'}"><span class="fuel-diesel">🔧</span></c:if>
                    ${order.fuelType.displayName}
                </td>
                <td class="fc-mono">${order.quantityLitres}L</td>
                <td class="fc-mono">₹<fmt:formatNumber value="${order.grandTotal}" maxFractionDigits="2"/></td>
                <td>
                    <span class="fc-badge ${order.status == 'DELIVERED' ? 'success' : order.status == 'PENDING' ? 'warning' : order.status == 'CANCELLED' ? 'danger' : 'info'}">
                        ${order.status.displayName}
                    </span>
                </td>
                <td style="font-size:11px;color:var(--fc-text-muted);">
                    <fmt:formatDate value="${order.createdAt}" pattern="dd MMM HH:mm"/>
                </td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
