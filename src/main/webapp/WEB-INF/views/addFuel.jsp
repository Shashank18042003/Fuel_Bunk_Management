<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Fuel</title>
</head>
<body>

	<h2>Add Fuel Stock</h2>

	<form action="save" method="post">

		Fuel Type : <select name="fuelType">
			<option>PETROL</option>
			<option>DIESEL</option>
		</select> <br>
		<br> Available Liters : <input type="text" name="availableLiters">

		<br>
		<br> Density : <input type="text" name="density"> <br>
		<br> <input type="submit" value="Save Fuel">

	</form>

</body>
</html>