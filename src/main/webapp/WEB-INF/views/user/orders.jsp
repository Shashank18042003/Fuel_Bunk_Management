<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="My Orders"/>
<c:set var="currentPage" value="user-orders"/>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<c:choose>
    <c:when test="${empty orders}">
        <div class="fc-card">
            <div class="fc-card-body" style="text-align:center;padding:60px 20px;">
                <div style="font-size:40px;margin-bottom:12px;">⛽</div>
                <div style="font-size:18px;font-weight:600;margin-bottom:8px;">No orders yet</div>
                <div style="color:var(--fc-text-muted);margin-bottom:20px;">Place your first emergency fuel delivery order</div>
                <a href="${pageContext.request.contextPath}/user/order/new" class="fc-btn fc-btn-primary">
                    ⚡ Order Emergency Fuel
                </a>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="fc-card">
            <div class="fc-card-header">
                <span class="fc-card-title">All My Orders (${orders.size()})</span>
                <a href="${pageContext.request.contextPath}/user/order/new" class="fc-btn fc-btn-primary fc-btn-sm">
                    + New Order
                </a>
            </div>
            <table class="fc-table">
                <thead>
                    <tr>
                        <th>Order #</th>
                        <th>Branch</th>
                        <th>Fuel</th>
                        <th>Qty</th>
                        <th>Amount</th>
                        <th>Payment</th>
                        <th>Agent</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th>Detail</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                    <tr>
                        <td class="fc-mono" style="font-size:11px;">${order.orderNumber}</td>
                        <td style="font-size:12px;">${order.branch.branchName}</td>
                        <td>
                            <c:if test="${order.fuelType == 'PETROL'}"><span class="fuel-petrol">⛽ Petrol</span></c:if>
                            <c:if test="${order.fuelType == 'DIESEL'}"><span class="fuel-diesel">🔧 Diesel</span></c:if>
                        </td>
                        <td class="fc-mono">${order.quantityLitres}L</td>
                        <td class="fc-mono">₹<fmt:formatNumber value="${order.grandTotal}" maxFractionDigits="2"/></td>
                        <td style="font-size:12px;">${order.paymentMethod.displayName}</td>
                        <td style="font-size:12px;">
                            <c:choose>
                                <c:when test="${not empty order.deliveryAgent}">${order.deliveryAgent.fullName}</c:when>
                                <c:otherwise><span style="color:var(--fc-text-muted);">—</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <span class="fc-badge ${order.status == 'DELIVERED' ? 'success' : order.status == 'PENDING' ? 'warning' : order.status == 'DISPATCHED' ? 'info' : order.status == 'CANCELLED' ? 'danger' : 'muted'}">
                                ${order.status.displayName}
                            </span>
                        </td>
                        <td style="font-size:11px;color:var(--fc-text-muted);">
                            <fmt:formatDate value="${order.createdAt}" pattern="dd MMM HH:mm"/>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/user/orders/${order.id}"
                               class="fc-btn fc-btn-ghost fc-btn-sm">View</a>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:otherwise>
</c:choose>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
