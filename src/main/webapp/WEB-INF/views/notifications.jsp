<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notifications</title>
</head>
<body>

	<h2>Notifications</h2>

	<c:forEach items="${notifications}" var="n">

		<p>
			${n.title} <br> ${n.message}
		</p>

		<hr>

	</c:forEach>

</body>
</html>