<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Inventory — ${branch.branchName}"/>
<c:set var="currentPage" value="branch-inventory"/>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<c:forEach var="inv" items="${inventories}">
<div class="fc-card fc-mb-6">
    <div class="fc-card-header">
        <span class="fc-card-title">
            <c:if test="${inv.fuelType == 'PETROL'}"><span class="fuel-petrol">⛽ Petrol</span></c:if>
            <c:if test="${inv.fuelType == 'DIESEL'}"><span class="fuel-diesel">🔧 Diesel</span></c:if>
            &nbsp;—&nbsp; ${branch.branchName}
        </span>
        <span class="fc-badge ${inv.status == 'AVAILABLE' ? 'success' : inv.status == 'LOW' ? 'warning' : 'danger'}">
            ${inv.status.displayName}
        </span>
    </div>
    <div class="fc-card-body">
        <div class="fc-grid-3" style="margin-bottom:20px;">
            <div>
                <div class="fc-stat-label">Available Volume</div>
                <div class="fc-mono" style="font-size:28px;font-weight:700;letter-spacing:-1px;">
                    <fmt:formatNumber value="${inv.availableVolumeLitres}" maxFractionDigits="1"/>
                    <span style="font-size:14px;color:var(--fc-text-muted);"> L</span>
                </div>
            </div>
            <div>
                <div class="fc-stat-label">Current Density</div>
                <div class="fc-mono" style="font-size:24px;font-weight:600;">
                    ${inv.densityKgPerLitre}
                    <span style="font-size:13px;color:var(--fc-text-muted);"> kg/L</span>
                </div>
            </div>
            <div>
                <div class="fc-stat-label">Total Weight</div>
                <div class="fc-mono" style="font-size:24px;font-weight:600;">
                    <fmt:formatNumber value="${inv.totalWeightKg}" maxFractionDigits="1"/>
                    <span style="font-size:13px;color:var(--fc-text-muted);"> kg</span>
                </div>
            </div>
        </div>

        <!-- Tank Level Visual -->
        <div style="margin-bottom:20px;">
            <div style="font-size:11px;font-family:var(--font-mono);color:var(--fc-text-muted);margin-bottom:6px;letter-spacing:1px;">
                TANK LEVEL — <fmt:formatNumber value="${inv.volumePercentage}" maxFractionDigits="1"/>%
                (<fmt:formatNumber value="${inv.availableVolumeLitres}" maxFractionDigits="0"/>
                / <fmt:formatNumber value="${inv.tankCapacityLitres}" maxFractionDigits="0"/> L)
            </div>
            <div class="fc-gauge-bar" style="height:14px;border-radius:7px;">
                <div class="fc-gauge-fill ${inv.status == 'OUT_OF_STOCK' ? 'empty' : inv.status == 'LOW' ? 'low' : inv.fuelType == 'PETROL' ? 'petrol' : 'diesel'}"
                     style="width:${inv.volumePercentage}%;border-radius:7px;"></div>
            </div>
        </div>

        <!-- Update Density -->
        <form method="post" action="${pageContext.request.contextPath}/branch/inventory/update-density"
              class="fc-flex fc-gap-3" style="flex-wrap:wrap;align-items:flex-end;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="branchId" value="${branch.id}"/>
            <input type="hidden" name="fuelType" value="${inv.fuelType}"/>
            <div class="fc-form-group" style="margin:0;flex:1;min-width:200px;">
                <label>Update Density Reading (kg/L)</label>
                <input type="number" name="density" step="0.0001" min="0.5" max="1.2"
                       class="fc-input" value="${inv.densityKgPerLitre}" required>
            </div>
            <button type="submit" class="fc-btn fc-btn-secondary">Update Density</button>
        </form>
    </div>
</div>
</c:forEach>

<div class="fc-alert info">
    ℹ To replenish stock, please contact the admin or request stock update through admin portal.
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
