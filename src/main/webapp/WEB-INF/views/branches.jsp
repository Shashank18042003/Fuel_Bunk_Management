<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Branches</title>
</head>
<body>

	<h2>All Branches</h2>

	<a href="add">Add Branch</a>

	<br>
	<br>

	<table border="1">

		<tr>
			<th>ID</th>
			<th>Branch Name</th>
			<th>Location</th>
			<th>Status</th>
		</tr>

		<c:forEach items="${branches}" var="b">

			<tr>
				<td>${b.id}</td>
				<td>${b.branchName}</td>
				<td>${b.location}</td>
				<td>${b.status}</td>
			</tr>

		</c:forEach>

	</table>

</body>
</html>