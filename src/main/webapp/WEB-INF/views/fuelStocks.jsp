<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fuel Stocks</title>
</head>
<body>

	<h2>Fuel Stocks</h2>

	<a href="add">Add Fuel</a>

	<br>
	<br>

	<table border="1">

		<tr>
			<th>ID</th>
			<th>Fuel Type</th>
			<th>Available Liters</th>
			<th>Density</th>
			<th>Status</th>
		</tr>

		<c:forEach items="${stocks}" var="s">

			<tr>
				<td>${s.id}</td>
				<td>${s.fuelType}</td>
				<td>${s.availableLiters}</td>
				<td>${s.density}</td>
				<td>${s.status}</td>
			</tr>

		</c:forEach>

	</table>

</body>
</html>