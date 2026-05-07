<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Branch</title>
</head>
<body>

	<h2>Add Branch</h2>

	<form action="save" method="post">

		Branch Name : <input type="text" name="branchName"> <br>
		<br> Location : <input type="text" name="location"> <br>
		<br> Latitude : <input type="text" name="latitude"> <br>
		<br> Longitude : <input type="text" name="longitude"> <br>
		<br> <input type="submit" value="Save Branch">

	</form>

</body>
</html>