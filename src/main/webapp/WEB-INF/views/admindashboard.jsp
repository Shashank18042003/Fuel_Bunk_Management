<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FuelCore Admin Dashboard</title>

<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
	color: white;
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

/* ALERT BOX */
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

/* CARDS */
.cards {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 16px;
	margin-top: 20px;
}

.card {
	background: #070b1c;
	border: 1px solid rgba(255, 255, 255, 0.06);
	border-radius: 12px;
	padding: 20px;
}

.card h4 {
	color: #5c63ff;
	font-size: 12px;
	margin-bottom: 12px;
	font-weight: 500;
}

.card h2 {
	color: #ff6b00;
	font-size: 28px;
	font-weight: 700;
}

/* CHART */
.chart-box {
	margin-top: 28px;
	background: #070b1c;
	border: 1px solid rgba(255, 255, 255, 0.06);
	border-radius: 14px;
	padding: 22px;
	height: 380px;
}

.chart-title {
	margin-bottom: 18px;
	font-size: 17px;
	font-weight: 600;
}

/* RESPONSIVE */
@media ( max-width :1100px) {
	.cards {
		grid-template-columns: repeat(2, 1fr);
	}
	.container {
		width: 90%;
	}
}

@media ( max-width :700px) {
	.cards {
		grid-template-columns: 1fr;
	}
	.tabs {
		flex-wrap: wrap;
	}
	.navbar {
		flex-direction: column;
		height: auto;
		padding: 15px;
		gap: 12px;
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
				Signed in as <b> Admin</b>
			</div>

			<button class="logout" onclick="window.location.href='login.jsp'">
				Logout</button>

		</div>

	</div>

	<!-- MAIN CONTAINER -->

	<div class="container">

		<!-- ALERTS -->

		<div class="warning-box">⚠ FuelCore Hitech City — Diesel is
			critical</div>

		<div class="warning-box">⚠ FuelCore Madhapur — Petrol is out</div>

		<div class="warning-box">⚠ FuelCore Gachibowli — Diesel is
			critical</div>

		<!-- NAVIGATION -->

		<div class="tabs">

			<a href="adminDashboard.jsp" class="active"> Overview </a> <a
				href="branches.jsp"> All Branches </a> <a href="payments.jsp">
				Payments </a> <a href="reports.jsp"> Reports </a> <a
				href="globalPrices.jsp"> Global Prices </a>

		</div>

		<!-- CARDS -->

		<div class="cards">

			<div class="card">
				<h4>Total Revenue</h4>
				<h2>
					₹<%= request.getAttribute("totalRevenue") %>
				</h2>
			</div>

			<div class="card">
				<h4>Total Orders</h4>
				<h2>
					<%= request.getAttribute("totalOrders") %>
				</h2>
			</div>

			<div class="card">
				<h4>Pending</h4>
				<h2>
					<%= request.getAttribute("pendingOrders") %>
				</h2>
			</div>

			<div class="card">
				<h4>Delivered</h4>
				<h2>
					<%= request.getAttribute("deliveredOrders") %>
				</h2>
			</div>

		</div>

		<!-- CHART -->

		<div class="chart-box">

			<div class="chart-title">Weekly Sales</div>

			<canvas id="salesChart"></canvas>

		</div>

	</div>

	<script>

const ctx = document.getElementById('salesChart');

new Chart(ctx, {

    type: 'line',

    data: {

        labels: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'],

        datasets: [

            {
                label: 'Petrol',
                data: [12,18,10,25,30,42,28],
                borderColor: '#ff6b00',
                backgroundColor:'rgba(255,107,0,0.08)',
                tension:0.4,
                fill:true
            },

            {
                label: 'Diesel',
                data: [8,12,16,10,22,26,18],
                borderColor: '#3b82f6',
                backgroundColor:'rgba(59,130,246,0.08)',
                tension:0.4,
                fill:true
            }

        ]
    },

    options:{

        responsive:true,
        maintainAspectRatio:false,

        plugins:{
            legend:{
                labels:{
                    color:'white',
                    font:{
                        size:11
                    }
                }
            }
        },

        scales:{

            x:{
                ticks:{
                    color:'#9ca3af',
                    font:{
                        size:11
                    }
                },
                grid:{
                    color:'rgba(255,255,255,0.03)'
                }
            },

            y:{
                ticks:{
                    color:'#9ca3af',
                    font:{
                        size:11
                    }
                },
                grid:{
                    color:'rgba(255,255,255,0.03)'
                }
            }

        }

    }

});

</script>

</body>
</html>