<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In — FuelCore</title>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/fuelcore.css">
</head>
<body>
<div class="fc-auth-bg">
    <div class="fc-auth-card">
        <div class="fc-auth-logo">
            <div class="icon">⛽</div>
            <div style="font-size:22px;font-weight:700;letter-spacing:-0.5px;">FuelCore</div>
            <div style="font-size:11px;color:var(--fc-text-muted);font-family:var(--font-mono);letter-spacing:2px;margin-top:3px;">BUNK MANAGEMENT SYSTEM</div>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="fc-alert danger" style="margin-bottom:20px;">✕ ${errorMessage}</div>
        </c:if>
        <c:if test="${not empty successMessage}">
            <div class="fc-alert success" style="margin-bottom:20px;">✓ ${successMessage}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/login">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div class="fc-form-group">
                <label>Email Address</label>
                <input type="email" name="email" class="fc-input" placeholder="you@example.com" required autofocus>
            </div>

            <div class="fc-form-group" style="margin-bottom:24px;">
                <label>Password</label>
                <input type="password" name="password" class="fc-input" placeholder="••••••••" required>
            </div>

            <button type="submit" class="fc-btn fc-btn-primary" style="width:100%;justify-content:center;padding:11px;">
                Sign In →
            </button>
        </form>

        <div style="text-align:center;margin-top:20px;font-size:12px;color:var(--fc-text-muted);">
            No account? <a href="${pageContext.request.contextPath}/register"
                style="color:var(--fc-amber);text-decoration:none;font-weight:600;">Register here</a>
        </div>
    </div>
</div>
</body>
</html>
