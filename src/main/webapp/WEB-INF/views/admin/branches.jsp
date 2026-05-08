<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="pageTitle" value="Branch Management"/>
<c:set var="currentPage" value="admin-branches"/>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- Create Branch Form -->
<div class="fc-card fc-mb-6">
    <div class="fc-card-header">
        <span class="fc-card-title">⊞ Add New Branch</span>
    </div>
    <div class="fc-card-body">
        <form method="post" action="${pageContext.request.contextPath}/admin/branches/create">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(200px,1fr));gap:14px;">
                <div class="fc-form-group" style="margin:0;">
                    <label>Branch Code</label>
                    <input type="text" name="branchCode" class="fc-input" placeholder="FC-HYD-004" required>
                </div>
                <div class="fc-form-group" style="margin:0;">
                    <label>Branch Name</label>
                    <input type="text" name="branchName" class="fc-input" placeholder="Kukatpally" required>
                </div>
                <div class="fc-form-group" style="margin:0;">
                    <label>Address</label>
                    <input type="text" name="address" class="fc-input" placeholder="Plot 5, KPHB Colony" required>
                </div>
                <div class="fc-form-group" style="margin:0;">
                    <label>City</label>
                    <input type="text" name="city" class="fc-input" placeholder="Hyderabad" required>
                </div>
                <div class="fc-form-group" style="margin:0;">
                    <label>State</label>
                    <input type="text" name="state" class="fc-input" placeholder="Telangana" required>
                </div>
                <div class="fc-form-group" style="margin:0;">
                    <label>Pin Code</label>
                    <input type="text" name="pinCode" class="fc-input" placeholder="500072" required>
                </div>
                <div class="fc-form-group" style="margin:0;">
                    <label>Phone</label>
                    <input type="text" name="phone" class="fc-input" placeholder="040-XXXXXXXX">
                </div>
                <div class="fc-form-group" style="margin:0;">
                    <label>Latitude</label>
                    <input type="number" name="latitude" step="0.0001" class="fc-input" placeholder="17.4850">
                </div>
                <div class="fc-form-group" style="margin:0;">
                    <label>Longitude</label>
                    <input type="number" name="longitude" step="0.0001" class="fc-input" placeholder="78.3867">
                </div>
            </div>
            <div style="margin-top:16px;">
                <button type="submit" class="fc-btn fc-btn-primary">Create Branch + Initialize Inventory</button>
            </div>
        </form>
    </div>
</div>

<!-- Branches Table -->
<div class="fc-card">
    <div class="fc-card-header">
        <span class="fc-card-title">All Branches (${branches.size()})</span>
    </div>
    <table class="fc-table">
        <thead>
            <tr>
                <th>Code</th>
                <th>Branch Name</th>
                <th>Location</th>
                <th>Phone</th>
                <th>GPS</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="branch" items="${branches}">
            <tr>
                <td class="fc-mono" style="font-size:12px;">${branch.branchCode}</td>
                <td><strong>${branch.branchName}</strong></td>
                <td>
                    ${branch.address}<br>
                    <small style="color:var(--fc-text-muted);">${branch.city}, ${branch.state} — ${branch.pinCode}</small>
                </td>
                <td class="fc-mono" style="font-size:12px;">${branch.phone}</td>
                <td class="fc-mono" style="font-size:11px;color:var(--fc-text-muted);">
                    <c:if test="${not empty branch.latitude}">${branch.latitude}, ${branch.longitude}</c:if>
                    <c:if test="${empty branch.latitude}">—</c:if>
                </td>
                <td>
                    <span class="fc-badge ${branch.active ? 'success' : 'danger'}">
                        ${branch.active ? 'Active' : 'Inactive'}
                    </span>
                </td>
                <td>
                    <form method="post" action="${pageContext.request.contextPath}/admin/branches/${branch.id}/toggle"
                          style="display:inline;">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <button type="submit" class="fc-btn fc-btn-sm ${branch.active ? 'fc-btn-danger' : 'fc-btn-secondary'}">
                            ${branch.active ? 'Deactivate' : 'Activate'}
                        </button>
                    </form>
                </td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
