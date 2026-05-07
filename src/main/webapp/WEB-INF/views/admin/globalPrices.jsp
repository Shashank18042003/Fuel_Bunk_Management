<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FuelCore - Global Prices</title>

<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

body {
	background: #050816;
	color: white;
	overflow-x: hidden;
}

/* NAVBAR */
.navbar {
	width: 100%;
	height: 58px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.06);
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 28px;
	background: #070b1c;
}

.logo {
	display: flex;
	align-items: center;
	gap: 10px;
}

.logo h2 {
	font-size: 24px;
	font-weight: 700;
}

.branch {
	color: #5c63ff;
	font-size: 12px;
}

.right-nav {
	display: flex;
	align-items: center;
	gap: 14px;
}

.alert {
	background: #1b0b12;
	color: #ff4d4d;
	padding: 6px 12px;
	border-radius: 8px;
	border: 1px solid rgba(255, 77, 77, 0.2);
	font-size: 12px;
}

.admin {
	background: #0c1026;
	padding: 8px 14px;
	border-radius: 8px;
	border: 1px solid rgba(255, 255, 255, 0.06);
	color: #cbd5e1;
	font-size: 12px;
}

.logout {
	background: transparent;
	border: 1px solid rgba(255, 255, 255, 0.08);
	color: #9ca3af;
	padding: 8px 16px;
	border-radius: 8px;
	cursor: pointer;
	font-size: 12px;
}

/* MAIN */
.container {
	width: 78%;
	margin: auto;
	padding: 20px 0;
}

/* ALERTS */
.warning-box {
	width: 100%;
	background: #1b0b12;
	border: 1px solid rgba(255, 77, 77, 0.2);
	color: #ff6b4a;
	padding: 14px 18px;
	border-radius: 10px;
	margin-bottom: 14px;
	font-size: 13px;
}

/* NAVIGATION */
.tabs {
	display: flex;
	gap: 28px;
	margin: 22px 0;
	border-bottom: 1px solid rgba(255, 255, 255, 0.06);
	padding-bottom: 12px;
}

.tabs a {
	text-decoration: none;
	color: #5c63ff;
	font-size: 14px;
}

.tabs a.active {
	color: #ff6b00;
	font-weight: 600;
	border-bottom: 2px solid #ff6b00;
	padding-bottom: 10px;
}

/* PAGE TITLE */
.page-title {
	margin-top: 24px;
}

.page-title h2 {
	font-size: 18px;
	margin-bottom: 8px;
}

.page-title p {
	color: #5c63ff;
	font-size: 14px;
}

/* PRICE CARD */
.price-card {
	margin-top: 24px;
	width: 430px;
	background: #070b1c;
	border: 1px solid rgba(255, 255, 255, 0.06);
	border-radius: 18px;
	padding: 22px;
}

/* INPUT GROUP */
.input-group {
	margin-bottom: 22px;
}

.input-group label {
	display: block;
	margin-bottom: 10px;
	font-size: 12px;
	font-weight: 600;
	text-transform: uppercase;
}

.petrol-label {
	color: #ff6b00;
}

.diesel-label {
	color: #3b82f6;
}

.input-group input {
	width: 100%;
	height: 48px;
	background: #050816;
	border: 1px solid rgba(255, 255, 255, 0.06);
	border-radius: 10px;
	padding: 0 14px;
	color: white;
	font-size: 15px;
	outline: none;
	transition: 0.3s;
}

.input-group input:focus {
	border: 1px solid #ff6b00;
}

/* BUTTON */
.update-btn {
	width: 100%;
	height: 48px;
	border: none;
	border-radius: 10px;
	background: #ff6b00;
	color: white;
	font-size: 15px;
	font-weight: 600;
	cursor: pointer;
	transition: 0.3s;
}

.update-btn:hover {
	background: #ff7a1a;
}

/* RESPONSIVE */
@media ( max-width :700px) {
	.container {
		width: 92%;
	}
	.price-card {
		width: 100%;
	}
}
</style>

</head>

<body>

	<!-- NAVBAR -->

	<div class="navbar">

		<div class="logo">

			<h2>FuelCore</h2>

			<div class="branch">| FuelCore Hitech City</div>

		</div>

		<div class="right-nav">

			<div class="alert">● 3 alerts</div>

			<div class="admin">
				Signed in as <b>Admin</b>
			</div>

			<button class="logout" onclick="window.location.href='login.jsp'">
				Logout</button>
		</div>

	</div>

	<!-- MAIN -->

	<div class="container">

		<!-- ALERTS -->

		<div class="warning-box">⚠ FuelCore Hitech City — Diesel is
			critical</div>

		<div class="warning-box">⚠ FuelCore Madhapur — Petrol is out</div>

		<div class="warning-box">⚠ FuelCore Gachibowli — Diesel is
			critical</div>

		<!-- NAVIGATION -->

		<div class="tabs">

			<a href="admindashboard.jsp"> Overview </a> <a href="branches.jsp">
				All Branches </a> <a href="payments.jsp"> Payments </a> <a
				href="reports.jsp"> Reports </a> <a href="globalPrices.jsp"
				class="active"> Global Prices </a>

		</div>

		<!-- PAGE TITLE -->

		<div class="page-title">

			<h2>Global Price Control</h2>

			<p>Push price changes to all branches simultaneously</p>

		</div>

		<!-- PRICE CARD -->

		<div class="price-card">

			<form action="updatePrices" method="post">

				<!-- PETROL -->

				<div class="input-group">

					<label class="petrol-label"> Petrol Price (₹/L) </label> <input
						type="text" name="petrolPrice" value="102.89">

				</div>

				<!-- DIESEL -->

				<div class="input-group">

					<label class="diesel-label"> Diesel Price (₹/L) </label> <input
						type="text" name="dieselPrice" value="89.62">

				</div>

				<!-- BUTTON -->

				<button class="update-btn">Apply to All Branches</button>

			</form>

		</div>

	</div>

</body>
</html>