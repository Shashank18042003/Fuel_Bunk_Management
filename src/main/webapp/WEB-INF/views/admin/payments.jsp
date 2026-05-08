<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Payment History"/>
<c:set var="currentPage" value="admin-payments"/>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="fc-card">
    <div class="fc-card-header">
        <span class="fc-card-title">₹ All Transactions</span>
    </div>
    <table class="fc-table">
        <thead>
            <tr>
                <th>Transaction ID</th>
                <th>Order #</th>
                <th>User</th>
                <th>Method</th>
                <th>Amount</th>
                <th>Status</th>
                <th>Invoice</th>
                <th>Date</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="p" items="${payments}">
            <tr>
                <td class="fc-mono" style="font-size:11px;">${p.transactionId}</td>
                <td class="fc-mono" style="font-size:11px;">${p.order.orderNumber}</td>
                <td>${p.order.user.fullName}</td>
                <td style="font-size:12px;">${p.method.displayName}</td>
                <td class="fc-mono" style="color:var(--fc-amber);">
                    ₹<fmt:formatNumber value="${p.amount}" maxFractionDigits="2"/>
                </td>
                <td>
                    <span class="fc-badge ${p.status == 'SUCCESS' ? 'success' : p.status == 'PENDING' ? 'warning' : p.status == 'REFUNDED' ? 'info' : 'danger'}">
                        ${p.status.displayName}
                    </span>
                </td>
                <td class="fc-mono" style="font-size:11px;color:var(--fc-text-muted);">
                    <c:choose>
                        <c:when test="${not empty p.invoiceNumber}">${p.invoiceNumber}</c:when>
                        <c:otherwise>—</c:otherwise>
                    </c:choose>
                </td>
                <td style="font-size:11px;color:var(--fc-text-muted);">
                    <fmt:formatDate value="${p.createdAt}" pattern="dd MMM yyyy HH:mm"/>
                </td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
