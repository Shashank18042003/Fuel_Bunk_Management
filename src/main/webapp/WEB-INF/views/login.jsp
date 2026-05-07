<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h2>Login</h2>

	<form action="login" method="post">

		Email : <input type="email" name="email" required> <br>
		<br> Password : <input type="password" name="password" required>
		<br>
		<br> <input type="submit" value="Login">

	</form>

	<br>

	<a href="${pageContext.request.contextPath}/register">Register Here</a>

	<h3>${message}</h3>

</body>
</html>