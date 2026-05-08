<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="pageTitle" value="Fuel Inventory"/>
<c:set var="currentPage" value="admin-inventory"/>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- Price Update Panel -->
<div class="fc-grid-2 fc-mb-6">
    <div class="fc-card">
        <div class="fc-card-header">
            <span class="fc-card-title">⛽ Update Petrol Price (Global)</span>
        </div>
        <div class="fc-card-body">
            <form method="post" action="${pageContext.request.contextPath}/admin/inventory/price-update" class="fc-flex fc-gap-3">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="fuelType" value="PETROL"/>
                <input type="number" name="price" step="0.01" min="50" max="200"
                       class="fc-input" placeholder="₹ per litre" required style="flex:1;">
                <button type="submit" class="fc-btn fc-btn-primary">Apply to All Branches</button>
            </form>
        </div>
    </div>
    <div class="fc-card">
        <div class="fc-card-header">
            <span class="fc-card-title">🔧 Update Diesel Price (Global)</span>
        </div>
        <div class="fc-card-body">
            <form method="post" action="${pageContext.request.contextPath}/admin/inventory/price-update" class="fc-flex fc-gap-3">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="fuelType" value="DIESEL"/>
                <input type="number" name="price" step="0.01" min="50" max="200"
                       class="fc-input" placeholder="₹ per litre" required style="flex:1;">
                <button type="submit" class="fc-btn fc-btn-primary">Apply to All Branches</button>
            </form>
        </div>
    </div>
</div>

<!-- Replenish Stock -->
<div class="fc-card fc-mb-6">
    <div class="fc-card-header">
        <span class="fc-card-title">↑ Replenish Stock</span>
    </div>
    <div class="fc-card-body">
        <form method="post" action="${pageContext.request.contextPath}/admin/inventory/replenish"
              style="display:flex;gap:12px;flex-wrap:wrap;align-items:flex-end;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div class="fc-form-group" style="margin:0;flex:1;min-width:180px;">
                <label>Branch</label>
                <select name="branchId" class="fc-select" required>
                    <option value="">Select Branch</option>
                    <c:forEach var="branch" items="${branches}">
                        <option value="${branch.id}">${branch.branchName} (${branch.branchCode})</option>
                    </c:forEach>
                </select>
            </div>
            <div class="fc-form-group" style="margin:0;flex:1;min-width:140px;">
                <label>Fuel Type</label>
                <select name="fuelType" class="fc-select" required>
                    <option value="PETROL">⛽ Petrol</option>
                    <option value="DIESEL">🔧 Diesel</option>
                </select>
            </div>
            <div class="fc-form-group" style="margin:0;flex:1;min-width:140px;">
                <label>Quantity (Litres)</label>
                <input type="number" name="litres" step="0.01" min="1" max="10000"
                       class="fc-input" placeholder="e.g. 5000" required>
            </div>
            <button type="submit" class="fc-btn fc-btn-primary">Replenish ↑</button>
        </form>
    </div>
</div>

<!-- Full Inventory Table -->
<div class="fc-card">
    <div class="fc-card-header">
        <span class="fc-card-title">All Branch Inventory</span>
        <div class="fc-live"><span class="fc-live-dot"></span> REAL-TIME</div>
    </div>
    <table class="fc-table">
        <thead>
            <tr>
                <th>Branch</th>
                <th>Fuel Type</th>
                <th>Available (L)</th>
                <th>Capacity (L)</th>
                <th>Tank Level</th>
                <th>Density (kg/L)</th>
                <th>Weight (kg)</th>
                <th>Price / L</th>
                <th>Status</th>
                <th>Last Replenished</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="inv" items="${inventories}">
            <tr>
                <td>
                    <strong>${inv.branch.branchName}</strong><br>
                    <small class="fc-mono" style="color:var(--fc-text-muted);">${inv.branch.branchCode}</small>
                </td>
                <td>
                    <c:if test="${inv.fuelType == 'PETROL'}"><span class="fuel-petrol">⛽ Petrol</span></c:if>
                    <c:if test="${inv.fuelType == 'DIESEL'}"><span class="fuel-diesel">🔧 Diesel</span></c:if>
                </td>
                <td class="fc-mono"><fmt:formatNumber value="${inv.availableVolumeLitres}" maxFractionDigits="1"/></td>
                <td class="fc-mono" style="color:var(--fc-text-muted);"><fmt:formatNumber value="${inv.tankCapacityLitres}" maxFractionDigits="0"/></td>
                <td style="min-width:130px;">
                    <div class="fc-gauge-bar">
                        <div class="fc-gauge-fill ${inv.status == 'OUT_OF_STOCK' ? 'empty' : inv.status == 'LOW' ? 'low' : inv.fuelType == 'PETROL' ? 'petrol' : 'diesel'}"
                             style="width:${inv.volumePercentage}%"></div>
                    </div>
                    <div style="font-size:10px;font-family:var(--font-mono);color:var(--fc-text-muted);margin-top:2px;">
                        <fmt:formatNumber value="${inv.volumePercentage}" maxFractionDigits="1"/>%
                    </div>
                </td>
                <td class="fc-mono">${inv.densityKgPerLitre}</td>
                <td class="fc-mono"><fmt:formatNumber value="${inv.totalWeightKg}" maxFractionDigits="1"/></td>
                <td class="fc-mono" style="color:var(--fc-amber);">₹${inv.pricePerLitre}</td>
                <td>
                    <span class="fc-badge ${inv.status == 'AVAILABLE' ? 'success' : inv.status == 'LOW' ? 'warning' : inv.status == 'OUT_OF_STOCK' ? 'danger' : 'info'}">
                        ${inv.status.displayName}
                    </span>
                </td>
                <td style="font-size:11px;color:var(--fc-text-muted);">
                    <c:choose>
                        <c:when test="${not empty inv.lastReplenishedAt}">
                            <fmt:formatDate value="${inv.lastReplenishedAt}" pattern="dd MMM, HH:mm"/>
                        </c:when>
                        <c:otherwise>Never</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
