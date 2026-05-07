<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payments</title>
</head>
<body>

	<h2>Payment History</h2>

	<table border="1">

		<tr>
			<th>ID</th>
			<th>Amount</th>
			<th>Mode</th>
			<th>Status</th>
		</tr>

		<c:forEach items="${payments}" var="p">

			<tr>
				<td>${p.id}</td>
				<td>${p.amount}</td>
				<td>${p.paymentMode}</td>
				<td>${p.paymentStatus}</td>
			</tr>

		</c:forEach>

	</table>

</body>
</html>