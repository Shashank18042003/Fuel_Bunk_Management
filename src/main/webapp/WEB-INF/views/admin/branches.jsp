<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FuelCore - All Branches</title>

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

/* BRANCH CARDS */
.branch-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 22px;
	margin-top: 30px;
}

.branch-card {
	background: #070b1c;
	border: 1px solid rgba(255, 255, 255, 0.06);
	border-radius: 16px;
	padding: 22px;
}

.branch-card h2 {
	font-size: 20px;
	margin-bottom: 8px;
}

.location {
	color: #5c63ff;
	font-size: 13px;
	margin-bottom: 22px;
}

.fuel-row {
	margin-bottom: 18px;
}

.fuel-top {
	display: flex;
	justify-content: space-between;
	margin-bottom: 8px;
	font-size: 13px;
}

.petrol {
	color: #ff6b00;
}

.diesel {
	color: #3b82f6;
}

.status {
	padding: 4px 10px;
	border-radius: 6px;
	font-size: 11px;
	font-weight: 600;
}

.available {
	background: #052e2b;
	color: #00ffbf;
}

.critical {
	background: #341212;
	color: #ff5c5c;
}

.out {
	background: #3b1010;
	color: #ff4d4d;
}

.progress {
	width: 100%;
	height: 6px;
	background: #141936;
	border-radius: 20px;
	overflow: hidden;
}

.fill {
	height: 100%;
	border-radius: 20px;
}

.petrol-fill {
	background: #00e0b8;
}

.diesel-fill {
	background: #ff4d4d;
}

.bottom-info {
	margin-top: 18px;
	display: flex;
	gap: 18px;
	font-size: 12px;
	color: #8b93c7;
}

@media ( max-width :950px) {
	.branch-grid {
		grid-template-columns: 1fr;
	}
	.container {
		width: 90%;
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

			<button class="logout" onclick="window.location.href='/logout'">Logout</button>


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

		<!-- TABS -->

		<div class="tabs">

			<a href="/admin/dashboard">Overview</a>
<a href="/branch/all">All Branches</a>
<a href="/payment/all">Payments</a>
<a href="/report/all">Reports</a>
<a href="/globalprices/prices">Global Prices</a>
		</div>

		<!-- BRANCHES -->

		<div class="branch-grid">

			<!-- CARD 1 -->

			<div class="branch-card">

				<h2>FuelCore Hitech City</h2>

				<div class="location">Hyderabad · Ravi Kumar</div>

				<div class="fuel-row">

					<div class="fuel-top">
						<span class="petrol">Petrol — 4,800L</span> <span
							class="status available">AVAILABLE</span>
					</div>

					<div class="progress">
						<div class="fill petrol-fill" style="width: 50%"></div>
					</div>

				</div>

				<div class="fuel-row">

					<div class="fuel-top">
						<span class="diesel">Diesel — 1,200L</span> <span
							class="status critical">CRITICAL</span>
					</div>

					<div class="progress">
						<div class="fill diesel-fill" style="width: 12%"></div>
					</div>

				</div>

				<div class="bottom-info">
					<span>₹102.89/L</span> <span>₹89.62/L</span> <span>2 orders
						today</span>
				</div>

			</div>

			<!-- CARD 2 -->

			<div class="branch-card">

				<h2>FuelCore Madhapur</h2>

				<div class="location">Hyderabad · Sneha Patel</div>

				<div class="fuel-row">

					<div class="fuel-top">
						<span class="petrol">Petrol — 0L</span> <span class="status out">OUT</span>
					</div>

					<div class="progress">
						<div class="fill diesel-fill" style="width: 0%"></div>
					</div>

				</div>

				<div class="fuel-row">

					<div class="fuel-top">
						<span class="diesel">Diesel — 8,900L</span> <span
							class="status available">AVAILABLE</span>
					</div>

					<div class="progress">
						<div class="fill petrol-fill" style="width: 68%"></div>
					</div>

				</div>

				<div class="bottom-info">
					<span>₹102.89/L</span> <span>₹89.62/L</span> <span>1 orders
						today</span>
				</div>

			</div>

			<!-- CARD 3 -->

			<div class="branch-card">

				<h2>FuelCore Gachibowli</h2>

				<div class="location">Hyderabad · Arjun Sharma</div>

				<div class="fuel-row">

					<div class="fuel-top">
						<span class="petrol">Petrol — 7,200L</span> <span
							class="status available">AVAILABLE</span>
					</div>

					<div class="progress">
						<div class="fill petrol-fill" style="width: 72%"></div>
					</div>

				</div>

				<div class="fuel-row">

					<div class="fuel-top">
						<span class="diesel">Diesel — 500L</span> <span
							class="status critical">CRITICAL</span>
					</div>

					<div class="progress">
						<div class="fill diesel-fill" style="width: 8%"></div>
					</div>

				</div>

				<div class="bottom-info">
					<span>₹102.89/L</span> <span>₹89.62/L</span> <span>1 orders
						today</span>
				</div>

			</div>

			<!-- CARD 4 -->

			<div class="branch-card">

				<h2>FuelCore Kondapur</h2>

				<div class="location">Hyderabad · Priya Nair</div>

				<div class="fuel-row">

					<div class="fuel-top">
						<span class="petrol">Petrol — 3,100L</span> <span
							class="status available">AVAILABLE</span>
					</div>

					<div class="progress">
						<div class="fill petrol-fill" style="width: 32%"></div>
					</div>

				</div>

				<div class="fuel-row">

					<div class="fuel-top">
						<span class="diesel">Diesel — 11,200L</span> <span
							class="status available">AVAILABLE</span>
					</div>

					<div class="progress">
						<div class="fill petrol-fill" style="width: 76%"></div>
					</div>

				</div>

				<div class="bottom-info">
					<span>₹102.89/L</span> <span>₹89.62/L</span> <span>1 orders
						today</span>
				</div>

			</div>

		</div>

	</div>

</body>
</html>