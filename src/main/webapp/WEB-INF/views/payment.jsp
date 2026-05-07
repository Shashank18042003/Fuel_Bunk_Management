<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment</title>
</head>
<body>

	<h2>Payment</h2>

	<form action="save" method="post">

		Amount : <input type="text" name="amount"> <br>
		<br> Payment Mode : <select name="paymentMode">
			<option>COD</option>
			<option>ONLINE</option>
		</select> <br>
		<br> Transaction ID : <input type="text" name="transactionId">

		<br>
		<br> <input type="submit" value="Pay">

	</form>

</body>
</html>