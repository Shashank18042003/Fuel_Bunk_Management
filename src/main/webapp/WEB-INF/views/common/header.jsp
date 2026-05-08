<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} — FuelCore</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/fuelcore.css">
    <style>
        /* Inline extra overrides if needed per-page */
        ${extraStyles}
    </style>
</head>
<body>
<div class="fc-layout">
    <!-- Sidebar -->
    <aside class="fc-sidebar" id="sidebar">
        <div class="fc-logo">
            <a href="${pageContext.request.contextPath}/" class="fc-logo-mark">
                <div class="fc-logo-icon">⛽</div>
                <div>
                    <div class="fc-logo-text">FuelCore</div>
                    <div class="fc-logo-sub">Bunk Management</div>
                </div>
            </a>
        </div>

        <nav class="fc-nav">
            <!-- ADMIN NAV -->
            <sec:authorize access="hasRole('ADMIN')">
                <div class="fc-nav-section">Admin</div>
                <a href="${pageContext.request.contextPath}/admin/dashboard"
                   class="${currentPage == 'admin-dashboard' ? 'active' : ''}">
                    <span class="nav-icon">◈</span> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/admin/branches"
                   class="${currentPage == 'admin-branches' ? 'active' : ''}">
                    <span class="nav-icon">⊞</span> Branches
                </a>
                <a href="${pageContext.request.contextPath}/admin/inventory"
                   class="${currentPage == 'admin-inventory' ? 'active' : ''}">
                    <span class="nav-icon">◉</span> Fuel Inventory
                </a>
                <a href="${pageContext.request.contextPath}/admin/orders"
                   class="${currentPage == 'admin-orders' ? 'active' : ''}">
                    <span class="nav-icon">⊡</span> All Orders
                </a>
                <a href="${pageContext.request.contextPath}/admin/payments"
                   class="${currentPage == 'admin-payments' ? 'active' : ''}">
                    <span class="nav-icon">₹</span> Payments
                </a>
                <a href="${pageContext.request.contextPath}/admin/users"
                   class="${currentPage == 'admin-users' ? 'active' : ''}">
                    <span class="nav-icon">⊛</span> Users & Managers
                </a>
                <a href="${pageContext.request.contextPath}/admin/reports"
                   class="${currentPage == 'admin-reports' ? 'active' : ''}">
                    <span class="nav-icon">▦</span> Reports
                </a>
            </sec:authorize>

            <!-- MANAGER NAV -->
            <sec:authorize access="hasRole('MANAGER')">
                <div class="fc-nav-section">Branch</div>
                <a href="${pageContext.request.contextPath}/branch/dashboard"
                   class="${currentPage == 'branch-dashboard' ? 'active' : ''}">
                    <span class="nav-icon">◈</span> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/branch/inventory"
                   class="${currentPage == 'branch-inventory' ? 'active' : ''}">
                    <span class="nav-icon">◉</span> Fuel Inventory
                </a>
                <a href="${pageContext.request.contextPath}/branch/orders"
                   class="${currentPage == 'branch-orders' ? 'active' : ''}">
                    <span class="nav-icon">⊡</span> Orders
                </a>
            </sec:authorize>

            <!-- USER NAV -->
            <sec:authorize access="hasRole('USER')">
                <div class="fc-nav-section">User</div>
                <a href="${pageContext.request.contextPath}/user/dashboard"
                   class="${currentPage == 'user-dashboard' ? 'active' : ''}">
                    <span class="nav-icon">◈</span> Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/user/order/new"
                   class="${currentPage == 'user-order-new' ? 'active' : ''}">
                    <span class="nav-icon">⚡</span> Emergency Fuel
                </a>
                <a href="${pageContext.request.contextPath}/user/orders"
                   class="${currentPage == 'user-orders' ? 'active' : ''}">
                    <span class="nav-icon">⊡</span> My Orders
                </a>
                <a href="${pageContext.request.contextPath}/user/branches"
                   class="${currentPage == 'user-branches' ? 'active' : ''}">
                    <span class="nav-icon">⊞</span> Find Branch
                </a>
                <a href="${pageContext.request.contextPath}/user/profile"
                   class="${currentPage == 'user-profile' ? 'active' : ''}">
                    <span class="nav-icon">⊛</span> My Profile
                </a>
            </sec:authorize>
        </nav>

        <div class="fc-sidebar-footer">
            <div class="fc-sidebar-user">
                <div class="fc-avatar">
                    <sec:authentication property="principal.username" var="userEmail"/>
                    ${userEmail.substring(0,1).toUpperCase()}
                </div>
                <div class="fc-user-info">
                    <strong style="font-size:12px;">${userEmail}</strong>
                    <small>
                        <sec:authorize access="hasRole('ADMIN')">ADMIN</sec:authorize>
                        <sec:authorize access="hasRole('MANAGER')">MANAGER</sec:authorize>
                        <sec:authorize access="hasRole('USER')">USER</sec:authorize>
                    </small>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="fc-logout">
                <span>⏻</span> Sign out
            </a>
        </div>
    </aside>

    <!-- Main area -->
    <div class="fc-main">
        <div class="fc-topbar">
            <div class="fc-page-title">${pageTitle}</div>
            <div class="fc-topbar-actions">
                <div class="fc-live"><span class="fc-live-dot"></span> LIVE</div>
                <sec:authorize access="hasRole('USER')">
                    <a href="${pageContext.request.contextPath}/user/order/new" class="fc-btn fc-btn-primary fc-btn-sm">
                        ⚡ Emergency Fuel
                    </a>
                </sec:authorize>
            </div>
        </div>

        <div class="fc-content">
            <!-- Flash messages -->
            <c:if test="${not empty success}">
                <div class="fc-alert success">✓ ${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="fc-alert danger">✕ ${error}</div>
            </c:if>
            <c:if test="${not empty warning}">
                <div class="fc-alert warning">⚠ ${warning}</div>
            </c:if>
