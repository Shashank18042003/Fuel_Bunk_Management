<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register — FuelCore</title>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/fuelcore.css">
</head>
<body>
<div class="fc-auth-bg">
    <div class="fc-auth-card" style="width:460px;">
        <div class="fc-auth-logo">
            <div class="icon">⛽</div>
            <div style="font-size:20px;font-weight:700;">Create Account</div>
            <div style="font-size:12px;color:var(--fc-text-muted);margin-top:4px;">Register to use FuelCore emergency delivery</div>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="fc-alert danger">✕ ${errorMessage}</div>
        </c:if>

        <form:form method="post" action="${pageContext.request.contextPath}/register" modelAttribute="user">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div class="fc-grid-2">
                <div class="fc-form-group">
                    <label>Full Name</label>
                    <form:input path="fullName" cssClass="fc-input" placeholder="" required="true"/>
                    <form:errors path="fullName" cssStyle="color:var(--fc-danger);font-size:11px;"/>
                </div>
                <div class="fc-form-group">
                    <label>Phone</label>
                    <form:input path="phone" cssClass="fc-input" placeholder=""/>
                </div>
            </div>

            <div class="fc-form-group">
                <label>Email Address</label>
                <form:input path="email" type="email" cssClass="fc-input" placeholder="you@example.com" required="true"/>
                <form:errors path="email" cssStyle="color:var(--fc-danger);font-size:11px;"/>
            </div>

            <div class="fc-grid-2">
                <div class="fc-form-group">
                    <label>Password</label>
                    <form:password path="password" cssClass="fc-input" placeholder="Min 6 chars" required="true"/>
                </div>
                <div class="fc-form-group">
                    <label>Confirm Password</label>
                    <input type="password" name="confirmPassword" class="fc-input" placeholder="Repeat password" required>
                </div>
            </div>

            <div class="fc-grid-2">
                <div class="fc-form-group">
                    <label>Vehicle Type</label>
                    <form:select path="vehicleType" cssClass="fc-select">
                        <form:option value="">— Select —</form:option>
                        <form:option value="BIKE">Bike (Petrol, max 5L)</form:option>
                        <form:option value="CAR">Car (max 10L)</form:option>
                        <form:option value="TRUCK">Truck (Diesel, max 10L)</form:option>
                        <form:option value="AUTO">Auto Rickshaw (max 5L)</form:option>
                    </form:select>
                </div>
                <div class="fc-form-group">
                    <label>Vehicle Number</label>
                    <form:input path="vehicleNumber" cssClass="fc-input" placeholder="TS09AB1234"/>
                </div>
            </div>

            <button type="submit" class="fc-btn fc-btn-primary" style="width:100%;justify-content:center;padding:11px;margin-top:8px;">
                Create Account →
            </button>
        </form:form>

        <div style="text-align:center;margin-top:16px;font-size:12px;color:var(--fc-text-muted);">
            Already registered? <a href="${pageContext.request.contextPath}/login"
                style="color:var(--fc-amber);text-decoration:none;font-weight:600;">Sign in</a>
        </div>
    </div>
</div>
</body>
</html>
