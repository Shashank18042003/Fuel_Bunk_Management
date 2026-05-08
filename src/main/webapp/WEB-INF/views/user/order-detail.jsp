<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Order — ${order.orderNumber}"/>
<c:set var="currentPage" value="user-orders"/>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div style="max-width:680px;">
    <!-- Order Header -->
    <div class="fc-card fc-mb-6" style="border-left:3px solid var(--fc-amber);">
        <div class="fc-card-body">
            <div class="fc-flex fc-gap-3" style="justify-content:space-between;flex-wrap:wrap;">
                <div>
                    <div class="fc-mono" style="font-size:11px;color:var(--fc-text-muted);margin-bottom:4px;">ORDER NUMBER</div>
                    <div class="fc-mono" style="font-size:20px;font-weight:700;letter-spacing:-0.5px;">${order.orderNumber}</div>
                </div>
                <span class="fc-badge ${order.status == 'DELIVERED' ? 'success' : order.status == 'PENDING' ? 'warning' : order.status == 'DISPATCHED' ? 'info' : order.status == 'CANCELLED' ? 'danger' : 'muted'}"
                      style="font-size:13px;padding:6px 14px;">
                    ${order.status.displayName}
                </span>
            </div>
        </div>
    </div>

    <!-- Delivery Timeline -->
    <div class="fc-card fc-mb-6">
        <div class="fc-card-header"><span class="fc-card-title">Delivery Status</span></div>
        <div class="fc-card-body">
            <div style="position:relative;padding-left:24px;">
                <c:set var="statuses" value="PENDING,CONFIRMED,DISPATCHED,DELIVERED"/>
                <c:forEach var="step" items="${'PENDING,CONFIRMED,DISPATCHED,DELIVERED'.split(',')}" varStatus="loop">
                    <c:set var="isDone" value="${order.status == 'DELIVERED' || (order.status == 'DISPATCHED' && (step == 'PENDING' || step == 'CONFIRMED' || step == 'DISPATCHED')) || (order.status == 'CONFIRMED' && (step == 'PENDING' || step == 'CONFIRMED')) || (order.status == 'PENDING' && step == 'PENDING')}"/>
                    <div style="display:flex;align-items:flex-start;gap:14px;margin-bottom:${loop.last ? '0' : '20px'};position:relative;">
                        <div style="position:absolute;left:-24px;top:0;">
                            <div style="width:14px;height:14px;border-radius:50%;background:${isDone ? 'var(--fc-success)' : 'var(--fc-surface3)'};border:2px solid ${isDone ? 'var(--fc-success)' : 'var(--fc-border)'};margin:2px 0;"></div>
                            <c:if test="${!loop.last}">
                                <div style="width:2px;height:26px;background:${isDone ? 'var(--fc-success)' : 'var(--fc-border)'};margin:0 auto;"></div>
                            </c:if>
                        </div>
                        <div>
                            <div style="font-weight:600;font-size:13px;color:${isDone ? 'var(--fc-text)' : 'var(--fc-text-muted)'};">
                                <c:choose>
                                    <c:when test="${step == 'PENDING'}">Order Placed</c:when>
                                    <c:when test="${step == 'CONFIRMED'}">Order Confirmed</c:when>
                                    <c:when test="${step == 'DISPATCHED'}">Agent Dispatched</c:when>
                                    <c:when test="${step == 'DELIVERED'}">Fuel Delivered</c:when>
                                </c:choose>
                            </div>
                            <c:if test="${step == 'DISPATCHED' && not empty order.deliveryAgent}">
                                <div style="font-size:12px;color:var(--fc-text-muted);margin-top:2px;">
                                    Agent: ${order.deliveryAgent.fullName}
                                </div>
                            </c:if>
                            <c:if test="${step == 'DELIVERED' && not empty order.actualDeliveryTime}">
                                <div style="font-size:11px;color:var(--fc-success);margin-top:2px;font-family:var(--font-mono);">
                                    Delivered at: <fmt:formatDate value="${order.actualDeliveryTime}" pattern="dd MMM HH:mm"/>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <!-- Order Details Grid -->
    <div class="fc-grid-2 fc-mb-6">
        <div class="fc-card">
            <div class="fc-card-header"><span class="fc-card-title">Fuel Details</span></div>
            <div class="fc-card-body">
                <table style="width:100%;border-collapse:collapse;">
                    <tr>
                        <td style="padding:6px 0;color:var(--fc-text-muted);font-size:12px;">Type</td>
                        <td style="padding:6px 0;font-weight:600;">
                            <c:if test="${order.fuelType == 'PETROL'}"><span class="fuel-petrol">⛽ Petrol</span></c:if>
                            <c:if test="${order.fuelType == 'DIESEL'}"><span class="fuel-diesel">🔧 Diesel</span></c:if>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding:6px 0;color:var(--fc-text-muted);font-size:12px;">Quantity</td>
                        <td class="fc-mono" style="padding:6px 0;font-weight:600;">${order.quantityLitres} L</td>
                    </tr>
                    <tr>
                        <td style="padding:6px 0;color:var(--fc-text-muted);font-size:12px;">Price / L</td>
                        <td class="fc-mono" style="padding:6px 0;">₹${order.pricePerLitre}</td>
                    </tr>
                    <tr>
                        <td style="padding:6px 0;color:var(--fc-text-muted);font-size:12px;">Fuel Total</td>
                        <td class="fc-mono" style="padding:6px 0;">₹<fmt:formatNumber value="${order.totalAmount}" maxFractionDigits="2"/></td>
                    </tr>
                    <tr>
                        <td style="padding:6px 0;color:var(--fc-text-muted);font-size:12px;">Delivery</td>
                        <td class="fc-mono" style="padding:6px 0;">₹<fmt:formatNumber value="${order.deliveryCharge}" maxFractionDigits="2"/></td>
                    </tr>
                    <tr style="border-top:1px solid var(--fc-border);">
                        <td style="padding:10px 0 4px;font-weight:700;">Grand Total</td>
                        <td class="fc-mono" style="padding:10px 0 4px;font-size:18px;font-weight:700;color:var(--fc-amber);">
                            ₹<fmt:formatNumber value="${order.grandTotal}" maxFractionDigits="2"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="fc-card">
            <div class="fc-card-header"><span class="fc-card-title">Payment</span></div>
            <div class="fc-card-body">
                <div style="margin-bottom:10px;">
                    <div class="fc-stat-label">Method</div>
                    <div style="font-weight:600;margin-top:4px;">${order.paymentMethod.displayName}</div>
                </div>
                <c:if test="${not empty order.payment}">
                    <div style="margin-bottom:10px;">
                        <div class="fc-stat-label">Status</div>
                        <span class="fc-badge ${order.payment.status == 'SUCCESS' ? 'success' : order.payment.status == 'PENDING' ? 'warning' : 'danger'}" style="margin-top:4px;display:inline-block;">
                            ${order.payment.status.displayName}
                        </span>
                    </div>
                    <div style="margin-bottom:10px;">
                        <div class="fc-stat-label">Transaction ID</div>
                        <div class="fc-mono" style="font-size:11px;margin-top:4px;color:var(--fc-text-muted);">
                            ${order.payment.transactionId}
                        </div>
                    </div>
                    <c:if test="${not empty order.payment.invoiceNumber}">
                        <div>
                            <div class="fc-stat-label">Invoice</div>
                            <div class="fc-mono" style="font-size:12px;color:var(--fc-success);margin-top:4px;">
                                ${order.payment.invoiceNumber}
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Branch and Location -->
    <div class="fc-card fc-mb-6">
        <div class="fc-card-header"><span class="fc-card-title">Branch & Delivery</span></div>
        <div class="fc-card-body fc-grid-2">
            <div>
                <div class="fc-stat-label">Fulfilling Branch</div>
                <div style="font-weight:600;margin-top:4px;">${order.branch.branchName}</div>
                <div style="font-size:12px;color:var(--fc-text-muted);margin-top:2px;">${order.branch.address}</div>
                <div class="fc-mono" style="font-size:11px;color:var(--fc-text-muted);">${order.branch.phone}</div>
            </div>
            <div>
                <div class="fc-stat-label">Delivery Location</div>
                <div style="font-size:13px;margin-top:4px;">
                    <c:choose>
                        <c:when test="${not empty order.deliveryAddress}">${order.deliveryAddress}</c:when>
                        <c:otherwise><span style="color:var(--fc-text-muted);">Not specified</span></c:otherwise>
                    </c:choose>
                </div>
                <c:if test="${not empty order.vehicleNumber}">
                    <div class="fc-mono" style="font-size:12px;color:var(--fc-text-muted);margin-top:6px;">
                        Vehicle: ${order.vehicleNumber}
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <a href="${pageContext.request.contextPath}/user/orders" class="fc-btn fc-btn-secondary">
        ← Back to Orders
    </a>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
