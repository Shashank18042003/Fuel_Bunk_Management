<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Orders — ${branch.branchName}"/>
<c:set var="currentPage" value="branch-orders"/>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="fc-card">
    <div class="fc-card-header">
        <span class="fc-card-title">Order Queue (${orders.size()})</span>
        <div class="fc-flex fc-gap-2">
            <button class="fc-btn fc-btn-sm fc-btn-secondary" onclick="filterOrders('ALL')">All</button>
            <button class="fc-btn fc-btn-sm fc-btn-ghost" onclick="filterOrders('PENDING')">Pending</button>
            <button class="fc-btn fc-btn-sm fc-btn-ghost" onclick="filterOrders('CONFIRMED')">Confirmed</button>
            <button class="fc-btn fc-btn-sm fc-btn-ghost" onclick="filterOrders('DISPATCHED')">Dispatched</button>
        </div>
    </div>
    <table class="fc-table" id="ordersTable">
        <thead>
            <tr>
                <th>Order #</th>
                <th>Customer</th>
                <th>Vehicle</th>
                <th>Fuel / Qty</th>
                <th>Delivery Address</th>
                <th>Amount</th>
                <th>Payment</th>
                <th>Status</th>
                <th>Time</th>
                <th>Update Status</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${orders}">
            <tr data-status="${order.status}">
                <td class="fc-mono" style="font-size:11px;">${order.orderNumber}</td>
                <td>
                    <strong>${order.user.fullName}</strong><br>
                    <small style="color:var(--fc-text-muted);">${order.user.phone}</small>
                </td>
                <td>
                    <c:if test="${not empty order.vehicleType}">
                        <span class="fc-badge muted">${order.vehicleType.displayName}</span><br>
                        <small class="fc-mono">${order.vehicleNumber}</small>
                    </c:if>
                </td>
                <td>
                    <c:if test="${order.fuelType == 'PETROL'}"><span class="fuel-petrol">⛽ Petrol</span></c:if>
                    <c:if test="${order.fuelType == 'DIESEL'}"><span class="fuel-diesel">🔧 Diesel</span></c:if>
                    <br><span class="fc-mono">${order.quantityLitres}L</span>
                </td>
                <td style="font-size:12px;max-width:160px;">
                    <c:choose>
                        <c:when test="${not empty order.deliveryAddress}">${order.deliveryAddress}</c:when>
                        <c:when test="${not empty order.deliveryLatitude}">
                            <span class="fc-mono" style="font-size:10px;">
                                ${order.deliveryLatitude}, ${order.deliveryLongitude}
                            </span>
                        </c:when>
                        <c:otherwise><span style="color:var(--fc-text-muted);">—</span></c:otherwise>
                    </c:choose>
                </td>
                <td class="fc-mono">₹<fmt:formatNumber value="${order.grandTotal}" maxFractionDigits="2"/></td>
                <td style="font-size:12px;">${order.paymentMethod.displayName}</td>
                <td>
                    <span class="fc-badge ${order.status == 'DELIVERED' ? 'success' : order.status == 'PENDING' ? 'warning' : order.status == 'CANCELLED' ? 'danger' : 'info'}">
                        ${order.status.displayName}
                    </span>
                </td>
                <td style="font-size:11px;color:var(--fc-text-muted);">
                    <fmt:formatDate value="${order.createdAt}" pattern="dd MMM HH:mm"/>
                </td>
                <td>
                    <c:if test="${order.status != 'DELIVERED' && order.status != 'CANCELLED'}">
                    <form method="post" action="${pageContext.request.contextPath}/branch/orders/${order.id}/status"
                          style="display:flex;gap:4px;">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <select name="status" class="fc-select" style="padding:4px 6px;font-size:11px;width:auto;">
                            <c:forEach var="s" items="${statuses}">
                                <option value="${s}" ${s == order.status ? 'selected' : ''}>${s.displayName}</option>
                            </c:forEach>
                        </select>
                        <button type="submit" class="fc-btn fc-btn-primary fc-btn-sm">→</button>
                    </form>
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
    document.querySelectorAll('#ordersTable tbody tr').forEach(r => {
        r.style.display = (status === 'ALL' || r.dataset.status === status) ? '' : 'none';
    });
}
</script>
</c:set>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
