<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="My Dashboard"/>
<c:set var="currentPage" value="user-dashboard"/>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- Emergency CTA Banner -->
<div style="background:linear-gradient(135deg,rgba(245,158,11,0.12),rgba(245,158,11,0.04));border:1px solid rgba(245,158,11,0.3);border-radius:14px;padding:24px 28px;margin-bottom:24px;display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:16px;">
    <div>
        <div style="font-size:20px;font-weight:700;margin-bottom:6px;">⚡ Stuck on the road?</div>
        <div style="color:var(--fc-text-muted);font-size:14px;">Order emergency fuel delivery — Petrol up to 5L, Diesel up to 10L.<br>
        Cash on delivery or pay online.</div>
    </div>
    <a href="${pageContext.request.contextPath}/user/order/new" class="fc-btn fc-btn-primary" style="padding:12px 28px;font-size:15px;">
        Order Fuel Now →
    </a>
</div>

<!-- User Vehicle Info -->
<c:if test="${not empty user.vehicleType}">
<div class="fc-card fc-mb-6">
    <div class="fc-card-header"><span class="fc-card-title">My Vehicle</span></div>
    <div class="fc-card-body fc-flex fc-gap-3" style="flex-wrap:wrap;">
        <div>
            <div class="fc-stat-label">Vehicle Type</div>
            <div style="font-size:16px;font-weight:600;margin-top:4px;">${user.vehicleType.displayName}</div>
        </div>
        <div>
            <div class="fc-stat-label">Vehicle Number</div>
            <div class="fc-mono" style="font-size:16px;font-weight:600;margin-top:4px;">${user.vehicleNumber}</div>
        </div>
        <div>
            <div class="fc-stat-label">Max Fuel Order</div>
            <div class="fc-mono" style="font-size:16px;font-weight:600;margin-top:4px;color:var(--fc-amber);">
                ${user.vehicleType.maxLitres}L
            </div>
        </div>
    </div>
</div>
</c:if>

<!-- Branch Availability Quick View -->
<div class="fc-card fc-mb-6">
    <div class="fc-card-header">
        <span class="fc-card-title">Fuel Availability Near You</span>
        <a href="${pageContext.request.contextPath}/user/branches" class="fc-btn fc-btn-ghost fc-btn-sm">All Branches →</a>
    </div>
    <div class="fc-card-body">
        <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(220px,1fr));gap:14px;">
            <c:forEach var="branch" items="${branches}" end="5">
            <div style="background:var(--fc-surface2);border:1px solid var(--fc-border);border-radius:10px;padding:14px;">
                <div style="font-weight:600;font-size:13px;margin-bottom:6px;">${branch.branchName}</div>
                <div style="font-size:11px;color:var(--fc-text-muted);margin-bottom:10px;">${branch.city}</div>
                <a href="${pageContext.request.contextPath}/user/order/new?branchId=${branch.id}"
                   class="fc-btn fc-btn-secondary fc-btn-sm" style="width:100%;justify-content:center;">
                    Order from here
                </a>
            </div>
            </c:forEach>
        </div>
    </div>
</div>

<!-- Recent Orders -->
<div class="fc-card">
    <div class="fc-card-header">
        <span class="fc-card-title">My Recent Orders</span>
        <a href="${pageContext.request.contextPath}/user/orders" class="fc-btn fc-btn-ghost fc-btn-sm">View All →</a>
    </div>
    <c:choose>
        <c:when test="${empty recentOrders}">
            <div class="fc-card-body" style="text-align:center;color:var(--fc-text-muted);padding:40px;">
                No orders yet. Place your first emergency fuel order above.
            </div>
        </c:when>
        <c:otherwise>
            <table class="fc-table">
                <thead>
                    <tr><th>Order #</th><th>Fuel</th><th>Qty</th><th>Amount</th><th>Status</th><th>Date</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${recentOrders}" end="4">
                    <tr>
                        <td>
                            <a href="${pageContext.request.contextPath}/user/orders/${order.id}"
                               class="fc-mono" style="color:var(--fc-amber);text-decoration:none;font-size:11px;">
                                ${order.orderNumber}
                            </a>
                        </td>
                        <td>
                            <c:if test="${order.fuelType == 'PETROL'}"><span class="fuel-petrol">⛽ Petrol</span></c:if>
                            <c:if test="${order.fuelType == 'DIESEL'}"><span class="fuel-diesel">🔧 Diesel</span></c:if>
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
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
