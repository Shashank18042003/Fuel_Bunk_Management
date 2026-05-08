<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Reports & Analytics"/>
<c:set var="currentPage" value="admin-reports"/>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- Summary Stats -->
<div class="fc-stats fc-mb-6">
    <div class="fc-stat success">
        <div class="fc-stat-label">Total Revenue</div>
        <div class="fc-stat-value" style="font-size:22px;">
            ₹<fmt:formatNumber value="${totalRevenue != null ? totalRevenue : 0}" maxFractionDigits="0"/>
        </div>
        <div class="fc-stat-sub">All delivered orders</div>
    </div>
    <div class="fc-stat">
        <div class="fc-stat-label">Petrol in System</div>
        <div class="fc-stat-value" style="font-size:22px;color:var(--fc-petrol);">
            <fmt:formatNumber value="${petrolLitres != null ? petrolLitres : 0}" maxFractionDigits="0"/>L
        </div>
    </div>
    <div class="fc-stat">
        <div class="fc-stat-label">Diesel in System</div>
        <div class="fc-stat-value" style="font-size:22px;color:var(--fc-diesel);">
            <fmt:formatNumber value="${dieselLitres != null ? dieselLitres : 0}" maxFractionDigits="0"/>L
        </div>
    </div>
</div>

<!-- Branch Performance Table -->
<div class="fc-card">
    <div class="fc-card-header"><span class="fc-card-title">▦ Branch-wise Performance</span></div>
    <c:choose>
        <c:when test="${empty branchPerformance}">
            <div class="fc-card-body" style="text-align:center;color:var(--fc-text-muted);padding:40px;">
                No delivered orders yet. Data will appear here once orders are fulfilled.
            </div>
        </c:when>
        <c:otherwise>
            <table class="fc-table">
                <thead>
                    <tr><th>Branch</th><th>Completed Orders</th><th>Total Revenue</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="row" items="${branchPerformance}">
                    <tr>
                        <td><strong>${row[0]}</strong></td>
                        <td class="fc-mono">${row[1]}</td>
                        <td class="fc-mono" style="color:var(--fc-amber);">
                            ₹<fmt:formatNumber value="${row[2]}" maxFractionDigits="2"/>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
