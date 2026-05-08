<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="All Orders"/>
<c:set var="currentPage" value="admin-orders"/>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="fc-flex fc-gap-3 fc-mb-6" style="flex-wrap:wrap;">
    <div class="fc-stat" style="flex:1;min-width:140px;padding:14px 18px;">
        <div class="fc-stat-label">Total Orders</div>
        <div class="fc-stat-value" style="font-size:22px;">${orders.size()}</div>
    </div>
    <div class="fc-stat warning" style="flex:1;min-width:140px;padding:14px 18px;">
        <div class="fc-stat-label">Pending</div>
        <div class="fc-stat-value" style="font-size:22px;">${pendingCount}</div>
    </div>
</div>

<div class="fc-card">
    <div class="fc-card-header">
        <span class="fc-card-title">Order Management</span>
        <!-- Quick Filter Tabs -->
        <div class="fc-flex fc-gap-2">
            <button class="fc-btn fc-btn-sm fc-btn-secondary active-filter" onclick="filterOrders('ALL')">All</button>
            <button class="fc-btn fc-btn-sm fc-btn-ghost" onclick="filterOrders('PENDING')">Pending</button>
            <button class="fc-btn fc-btn-sm fc-btn-ghost" onclick="filterOrders('DISPATCHED')">Dispatched</button>
            <button class="fc-btn fc-btn-sm fc-btn-ghost" onclick="filterOrders('DELIVERED')">Delivered</button>
        </div>
    </div>
    <table class="fc-table" id="ordersTable">
        <thead>
            <tr>
                <th>Order #</th>
                <th>User</th>
                <th>Branch</th>
                <th>Fuel</th>
                <th>Qty</th>
                <th>Amount</th>
                <th>Payment</th>
                <th>Status</th>
                <th>Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${orders}">
            <tr data-status="${order.status}">
                <td class="fc-mono" style="font-size:11px;">${order.orderNumber}</td>
                <td>
                    <strong>${order.user.fullName}</strong><br>
                    <small style="color:var(--fc-text-muted);">${order.vehicleNumber}</small>
                </td>
                <td style="font-size:12px;">${order.branch.branchName}</td>
                <td>
                    <c:if test="${order.fuelType == 'PETROL'}"><span class="fuel-petrol">⛽ Petrol</span></c:if>
                    <c:if test="${order.fuelType == 'DIESEL'}"><span class="fuel-diesel">🔧 Diesel</span></c:if>
                </td>
                <td class="fc-mono">${order.quantityLitres}L</td>
                <td class="fc-mono">₹<fmt:formatNumber value="${order.grandTotal}" maxFractionDigits="2"/></td>
                <td>
                    <span style="font-size:11px;color:var(--fc-text-muted);">${order.paymentMethod.displayName}</span>
                    <c:if test="${not empty order.payment}">
                        <br><span class="fc-badge ${order.payment.status == 'SUCCESS' ? 'success' : order.payment.status == 'PENDING' ? 'warning' : 'danger'}">
                            ${order.payment.status.displayName}
                        </span>
                    </c:if>
                </td>
                <td>
                    <span class="fc-badge ${order.status == 'DELIVERED' ? 'success' : order.status == 'PENDING' ? 'warning' : order.status == 'CANCELLED' ? 'danger' : order.status == 'DISPATCHED' ? 'info' : 'muted'}">
                        ${order.status.displayName}
                    </span>
                </td>
                <td style="font-size:11px;color:var(--fc-text-muted);">
                    <fmt:formatDate value="${order.createdAt}" pattern="dd MMM HH:mm"/>
                </td>
                <td>
                    <c:if test="${order.status != 'DELIVERED' && order.status != 'CANCELLED'}">
                    <form method="post" action="${pageContext.request.contextPath}/admin/orders/${order.id}/status"
                          style="display:flex;gap:4px;flex-wrap:nowrap;">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <select name="status" class="fc-select" style="padding:4px 6px;font-size:11px;width:auto;">
                            <c:forEach var="s" items="${statuses}">
                                <option value="${s}" ${s == order.status ? 'selected' : ''}>${s.displayName}</option>
                            </c:forEach>
                        </select>
                        <button type="submit" class="fc-btn fc-btn-primary fc-btn-sm">→</button>
                    </form>
                    </c:if>
                    <c:if test="${order.status == 'DELIVERED' || order.status == 'CANCELLED'}">
                        <span style="font-size:11px;color:var(--fc-text-muted);">Closed</span>
                    </c:if>
                </td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<c:set var="extraScripts">
<script>
function filterOrders(status) {
    const rows = document.querySelectorAll('#ordersTable tbody tr');
    rows.forEach(row => {
        row.style.display = (status === 'ALL' || row.dataset.status === status) ? '' : 'none';
    });
    document.querySelectorAll('.active-filter').forEach(b => b.className = 'fc-btn fc-btn-sm fc-btn-ghost');
    event.target.className = 'fc-btn fc-btn-sm fc-btn-secondary active-filter';
}
</script>
</c:set>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
