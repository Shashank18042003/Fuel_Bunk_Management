<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FuelCore - My Orders</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    background:#050816;
    color:white;
    overflow-x:hidden;
    zoom:85%;
}

/* NAVBAR */

.navbar{
    width:100%;
    height:52px;
    border-bottom:1px solid rgba(255,255,255,0.05);
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:0 24px;
    background:#070b1c;
}

.logo{
    display:flex;
    align-items:center;
    gap:8px;
}

.logo h2{
    font-size:21px;
    font-weight:700;
}

.branch{
    color:#5c63ff;
    font-size:10px;
}

.right-nav{
    display:flex;
    align-items:center;
    gap:10px;
}

.user-box{
    background:#0c1026;
    padding:6px 12px;
    border-radius:8px;
    border:1px solid rgba(255,255,255,0.05);
    color:#cbd5e1;
    font-size:10px;
}

.role{
    background:rgba(255,255,255,0.08);
    padding:3px 7px;
    border-radius:5px;
    margin-left:7px;
    font-size:9px;
    font-weight:600;
}

.logout{
    background:transparent;
    border:1px solid rgba(255,255,255,0.08);
    color:#9ca3af;
    padding:6px 14px;
    border-radius:8px;
    cursor:pointer;
    font-size:10px;
}

/* MAIN */

.container{
    width:68%;
    margin:auto;
    padding:20px 0;
}

/* TABS */

.tabs{
    display:flex;
    gap:22px;
    border-bottom:1px solid rgba(255,255,255,0.05);
    padding-bottom:11px;
    margin-bottom:26px;
}

.tabs a{
    text-decoration:none;
    color:#5c63ff;
    font-size:12px;
}

.tabs a.active{
    color:#ff6b00;
    font-weight:600;
    border-bottom:2px solid #ff6b00;
    padding-bottom:9px;
}

/* TITLE */

.page-title{
    font-size:18px;
    font-weight:700;
    margin-bottom:24px;
}

/* ORDER CARD */

.order-card{
    background:#070b1c;
    border:1px solid rgba(255,255,255,0.05);
    border-radius:16px;
    padding:18px;
    margin-bottom:20px;
}

/* TOP */

.order-top{
    display:flex;
    justify-content:space-between;
    align-items:flex-start;
    margin-bottom:18px;
}

.order-id{
    color:#5c63ff;
    font-size:11px;
    margin-bottom:10px;
}

.order-title{
    font-size:16px;
    font-weight:700;
}

.amount{
    font-size:16px;
    font-weight:700;
}

.status{
    padding:5px 10px;
    border-radius:6px;
    font-size:10px;
    font-weight:600;
    margin-bottom:10px;
    display:inline-block;
}

.success{
    background:#052e2b;
    color:#00ffbf;
}

.failed{
    background:#341212;
    color:#ff5c5c;
}

/* INFO */

.order-info{
    display:flex;
    gap:16px;
    color:#8b93c7;
    font-size:11px;
    margin-bottom:22px;
}

/* TRACK */

.track{
    display:flex;
    align-items:center;
    justify-content:space-between;
    position:relative;
}

.line{
    position:absolute;
    top:11px;
    left:40px;
    right:40px;
    height:2px;
    background:#00e0b8;
}

.line.failed-line{
    background:#ff4d4d;
}

.step{
    position:relative;
    z-index:2;
    text-align:center;
    font-size:9px;
    color:#8b93c7;
}

.circle{
    width:22px;
    height:22px;
    border-radius:50%;
    display:flex;
    align-items:center;
    justify-content:center;
    margin:auto;
    margin-bottom:6px;
    font-size:11px;
    font-weight:700;
}

.done{
    background:#00e0b8;
    color:black;
}

.fail{
    background:#ff4d4d;
    color:white;
}

.pending{
    background:#1c2345;
    color:#5c63ff;
}

@media(max-width:900px){

    .container{
        width:92%;
    }

    .track{
        gap:10px;
    }

}

</style>

</head>

<body>

<!-- NAVBAR -->

<div class="navbar">

    <div class="logo">

        <h2>FuelCore</h2>

        <div class="branch">
            | FuelCore Hitech City
        </div>

    </div>

    <div class="right-nav">

        <div class="user-box">

            Signed in as <b>Kiran Reddy</b>

            <span class="role">
                USER
            </span>

        </div>

        <button class="logout"
        onclick="window.location.href='login.jsp'">

            Logout

        </button>

    </div>

</div>

<!-- MAIN -->

<div class="container">

    <!-- NAVIGATION -->

    <div class="tabs">

        <a href="userDashboard.jsp">
            Fuel Status
        </a>

        <a href="emergencyOrder.jsp">
            Emergency Order
        </a>

        <a href="orders.jsp" class="active">
            My Orders
        </a>

    </div>

    <!-- TITLE -->

    <div class="page-title">
        My Orders
    </div>

    <!-- SUCCESS ORDER -->

    <div class="order-card">

        <div class="order-top">

            <div>

                <div class="order-id">
                    ORD001 · 06/05/26, 9:15 AM
                </div>

                <div class="order-title">
                    5L Petrol
                </div>

            </div>

            <div style="text-align:right;">

                <div class="status success">
                    DELIVERED
                </div>

                <div class="amount">
                    ₹514.45
                </div>

            </div>

        </div>

        <div class="order-info">

            <span>🕘 10:00 AM</span>
            <span>💳 Online</span>
            <span>🛵 bike</span>

        </div>

        <div class="track">

            <div class="line"></div>

            <div class="step">

                <div class="circle done">
                    ✓
                </div>

                Placed

            </div>

            <div class="step">

                <div class="circle done">
                    ✓
                </div>

                Confirmed

            </div>

            <div class="step">

                <div class="circle done">
                    ✓
                </div>

                Dispatched

            </div>

            <div class="step">

                <div class="circle done">
                    ✓
                </div>

                Delivered

            </div>

        </div>

    </div>

    <!-- FAILED ORDER -->

    <div class="order-card">

        <div class="order-top">

            <div>

                <div class="order-id">
                    ORD002 · 07/05/26, 11:40 AM
                </div>

                <div class="order-title">
                    3L Diesel
                </div>

            </div>

            <div style="text-align:right;">

                <div class="status failed">
                    PAYMENT FAILED
                </div>

                <div class="amount" style="color:#ff5c5c;">
                    ₹268.86
                </div>

            </div>

        </div>

        <div class="order-info">

            <span>🕘 12:00 PM</span>
            <span>💳 Online</span>
            <span>🚗 car</span>

        </div>

        <div class="track">

            <div class="line failed-line"></div>

            <div class="step">

                <div class="circle fail">
                    ✕
                </div>

                Payment Failed

            </div>

            <div class="step">

                <div class="circle pending">
                    •
                </div>

                Confirmed

            </div>

            <div class="step">

                <div class="circle pending">
                    •
                </div>

                Dispatched

            </div>

            <div class="step">

                <div class="circle pending">
                    •
                </div>

                Delivered

            </div>

        </div>

    </div>

</div>

</body>
</html>