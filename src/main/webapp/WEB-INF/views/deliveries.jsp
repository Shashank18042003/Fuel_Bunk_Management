<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Deliveries</title>
</head>
<body>

	<h2>Delivery Details</h2>

	<table border="1">

		<tr>
			<th>ID</th>
			<th>Status</th>
			<th>Dispatch Time</th>
			<th>Delivery Time</th>
		</tr>

		<c:forEach items="${deliveries}" var="d">

			<tr>
				<td>${d.id}</td>
				<td>${d.status}</td>
				<td>${d.dispatchTime}</td>
				<td>${d.deliveryTime}</td>
			</tr>

		</c:forEach>

	</table>

</body>
</html>