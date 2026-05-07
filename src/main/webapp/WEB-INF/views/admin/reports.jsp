<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FuelCore - Reports</title>

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

/* CHART SECTION */
.chart-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 18px;
	margin-top: 24px;
}

.chart-card {
	background: #070b1c;
	border: 1px solid rgba(255, 255, 255, 0.06);
	border-radius: 16px;
	padding: 20px;
	height: 300px;
}

.chart-title {
	font-size: 15px;
	font-weight: 600;
	margin-bottom: 18px;
}

/* REPORT CARDS */
.report-grid {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 16px;
	margin-top: 18px;
}

.report-card {
	background: #070b1c;
	border: 1px solid rgba(255, 255, 255, 0.06);
	border-radius: 14px;
	padding: 18px;
}

.report-card h5 {
	color: #5c63ff;
	font-size: 12px;
	margin-bottom: 10px;
	font-weight: 500;
}

.report-card h2 {
	color: #ff6b00;
	font-size: 28px;
	margin-bottom: 8px;
}

.report-card p {
	color: #8b93c7;
	font-size: 12px;
}

@media ( max-width :1000px) {
	.chart-grid {
		grid-template-columns: 1fr;
	}
	.report-grid {
		grid-template-columns: repeat(2, 1fr);
	}
	.container {
		width: 92%;
	}
}

@media ( max-width :700px) {
	.report-grid {
		grid-template-columns: 1fr;
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
				href="reports.jsp" class="active"> Reports </a> <a
				href="globalPrices.jsp"> Global Prices </a>

		</div>

		<!-- CHARTS -->

		<div class="chart-grid">

			<!-- SALES TREND -->

			<div class="chart-card">

				<div class="chart-title">Daily Sales Trend</div>

				<canvas id="salesChart"></canvas>

			</div>

			<!-- ORDERS -->

			<div class="chart-card">

				<div class="chart-title">Orders by Branch</div>

				<canvas id="ordersChart"></canvas>

			</div>

		</div>

		<!-- REPORT SUMMARY -->

		<div class="report-grid">

			<div class="report-card">

				<h5>Hitech City</h5>

				<h2>₹823.12</h2>

				<p>2 orders</p>

			</div>

			<div class="report-card">

				<h5>Madhapur</h5>

				<h2>₹514.45</h2>

				<p>1 orders</p>

			</div>

			<div class="report-card">

				<h5>Gachibowli</h5>

				<h2>₹896.20</h2>

				<p>1 orders</p>

			</div>

			<div class="report-card">

				<h5>Kondapur</h5>

				<h2>₹716.96</h2>

				<p>1 orders</p>

			</div>

		</div>

	</div>

	<script>

/* LINE CHART */

const salesCtx =
document.getElementById('salesChart');

new Chart(salesCtx, {

    type:'line',

    data:{

        labels:[
            'Mon',
            'Tue',
            'Wed',
            'Thu',
            'Fri',
            'Sat',
            'Sun'
        ],

        datasets:[

            {
                label:'Petrol',

                data:[
                    12000,
                    15000,
                    9000,
                    20000,
                    23000,
                    29000,
                    19000
                ],

                borderColor:'#ff6b00',

                backgroundColor:'rgba(255,107,0,0.08)',

                tension:0.4,

                fill:true
            },

            {
                label:'Diesel',

                data:[
                    9000,
                    11000,
                    13000,
                    10000,
                    17000,
                    19000,
                    14000
                ],

                borderColor:'#3b82f6',

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
                    color:'white'
                }
            }
        },

        scales:{

            x:{
                ticks:{
                    color:'#8b93c7'
                },
                grid:{
                    color:'rgba(255,255,255,0.03)'
                }
            },

            y:{
                ticks:{
                    color:'#8b93c7'
                },
                grid:{
                    color:'rgba(255,255,255,0.03)'
                }
            }

        }

    }

});

/* BAR CHART */

const ordersCtx =
document.getElementById('ordersChart');

new Chart(ordersCtx, {

    type:'bar',

    data:{

        labels:[
            'Hitech',
            'Madhapur',
            'Gachibowli',
            'Kondapur'
        ],

        datasets:[

            {

                label:'Orders',

                data:[
                    38,
                    27,
                    51,
                    24
                ],

                backgroundColor:[
                    '#16c79a',
                    '#16c79a',
                    '#16c79a',
                    '#16c79a'
                ],

                borderRadius:6

            }

        ]

    },

    options:{

        responsive:true,

        maintainAspectRatio:false,

        plugins:{
            legend:{
                labels:{
                    color:'white'
                }
            }
        },

        scales:{

            x:{
                ticks:{
                    color:'#8b93c7'
                },
                grid:{
                    color:'rgba(255,255,255,0.03)'
                }
            },

            y:{
                ticks:{
                    color:'#8b93c7'
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