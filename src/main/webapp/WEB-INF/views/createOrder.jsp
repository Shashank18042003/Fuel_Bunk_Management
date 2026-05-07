<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Order</title>
</head>
<body>

	<h2>Create Fuel Order</h2>

	<form action="save" method="post">

		Fuel Type : <select name="fuelType">
			<option>PETROL</option>
			<option>DIESEL</option>
		</select> <br>
		<br> Quantity : <input type="text" name="quantity"> <br>
		<br> Vehicle Number : <input type="text" name="vehicleNumber">

		<br>
		<br> Vehicle Type : <select name="vehicleType">
			<option>BIKE</option>
			<option>CAR</option>
			<option>TRUCK</option>
		</select> <br>
		<br> Delivery Address :
		<textarea name="deliveryAddress"></textarea>

		<br>
		<br> <input type="submit" value="Place Order">

	</form>

</body>
</html>