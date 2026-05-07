<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FuelCore - Payments</title>

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

/* TABS */
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

/* TITLE */
.page-title {
	font-size: 18px;
	font-weight: 600;
	margin: 26px 0 18px;
}

/* TABLE */
.table-wrapper {
	background: #070b1c;
	border: 1px solid rgba(255, 255, 255, 0.06);
	border-radius: 16px;
	overflow: hidden;
}

table {
	width: 100%;
	border-collapse: collapse;
}

thead {
	background: #0c1128;
}

thead th {
	padding: 18px 14px;
	text-align: left;
	color: #5c63ff;
	font-size: 11px;
	font-weight: 600;
	text-transform: uppercase;
}

tbody tr {
	border-top: 1px solid rgba(255, 255, 255, 0.04);
	transition: 0.3s;
}

tbody tr:hover {
	background: #0d1229;
}

tbody td {
	padding: 18px 14px;
	font-size: 13px;
	color: #d1d5db;
}

/* BADGES */
.badge {
	padding: 5px 10px;
	border-radius: 6px;
	font-size: 10px;
	font-weight: 600;
	display: inline-block;
}

.petrol {
	background: #2d160b;
	color: #ff6b00;
}

.diesel {
	background: #0b1d3b;
	color: #3b82f6;
}

.online {
	background: #052e2b;
	color: #00ffbf;
}

.cod {
	background: #33240a;
	color: #ffc14d;
}

.success {
	background: #052e2b;
	color: #00ffbf;
}

.pending {
	background: #23124a;
	color: #9b6dff;
}

.dispatched {
	background: #0b1d3b;
	color: #4da3ff;
}

/* REVENUE CARD */
.revenue-box {
	margin-top: 16px;
	background: #070b1c;
	border: 1px solid rgba(255, 255, 255, 0.06);
	border-radius: 14px;
	padding: 22px;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.revenue-box h4 {
	color: #5c63ff;
	font-size: 14px;
	font-weight: 500;
}

.revenue-box h1 {
	color: #ff6b00;
	font-size: 42px;
}

/* RESPONSIVE */
@media ( max-width :1100px) {
	.container {
		width: 92%;
	}
	.table-wrapper {
		overflow-x: auto;
	}
	table {
		min-width: 1000px;
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
				All Branches </a> <a href="payments.jsp" class="active"> Payments </a> <a
				href="reports.jsp"> Reports </a> <a href="globalPrices.jsp">
				Global Prices </a>

		</div>

		<!-- TITLE -->

		<div class="page-title">Payment History</div>

		<!-- TABLE -->

		<div class="table-wrapper">

			<table>

				<thead>

					<tr>

						<th>Order ID</th>
						<th>Customer</th>
						<th>Branch</th>
						<th>Fuel</th>
						<th>Vol</th>
						<th>Amount</th>
						<th>Method</th>
						<th>Timestamp</th>
						<th>Status</th>

					</tr>

				</thead>

				<tbody>

					<tr>

						<td>ORD001</td>
						<td>Kiran Reddy</td>
						<td>Hitech City</td>

						<td><span class="badge petrol"> PETROL </span></td>

						<td>5L</td>

						<td><b>₹514.45</b></td>

						<td><span class="badge online"> ONLINE </span></td>

						<td>06/05/26, 9:15 AM</td>

						<td><span class="badge success"> SUCCESS </span></td>

					</tr>

					<tr>

						<td>ORD002</td>
						<td>Meena Das</td>
						<td>FuelCore Gachibowli</td>

						<td><span class="badge diesel"> DIESEL </span></td>

						<td>10L</td>

						<td><b>₹896.20</b></td>

						<td><span class="badge cod"> COD </span></td>

						<td>07/05/26, 8:30 AM</td>

						<td><span class="badge dispatched"> DISPATCHED </span></td>

					</tr>

					<tr>

						<td>ORD003</td>
						<td>Sanjay V</td>
						<td>Hitech City</td>

						<td><span class="badge petrol"> PETROL </span></td>

						<td>3L</td>

						<td><b>₹308.67</b></td>

						<td><span class="badge online"> ONLINE </span></td>

						<td>07/05/26, 9:45 AM</td>

						<td><span class="badge pending"> PENDING </span></td>

					</tr>

					<tr>

						<td>ORD004</td>
						<td>Ananya K</td>
						<td>FuelCore Kondapur</td>

						<td><span class="badge diesel"> DIESEL </span></td>

						<td>8L</td>

						<td><b>₹716.96</b></td>

						<td><span class="badge cod"> COD </span></td>

						<td>06/05/26, 1:20 PM</td>

						<td><span class="badge success"> SUCCESS </span></td>

					</tr>

					<tr>

						<td>ORD005</td>
						<td>Rahul M</td>
						<td>FuelCore Madhapur</td>

						<td><span class="badge petrol"> PETROL </span></td>

						<td>5L</td>

						<td><b>₹514.45</b></td>

						<td><span class="badge online"> ONLINE </span></td>

						<td>07/05/26, 10:00 AM</td>

						<td><span class="badge pending"> PENDING </span></td>

					</tr>

				</tbody>

			</table>

		</div>

		<!-- REVENUE -->

		<div class="revenue-box">

			<h4>Total Revenue</h4>

			<h1>₹2,950.73</h1>

		</div>

	</div>

</body>
</html>