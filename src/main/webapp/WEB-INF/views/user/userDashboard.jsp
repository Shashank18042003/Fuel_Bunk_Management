<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FuelCore - User Dashboard</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
/* REPLACE YOUR CURRENT CSS WITH THIS */

/* ================= GLOBAL ================= */

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

    /* LITTLE ZOOM OUT */
    zoom:85%;
}

/* ================= NAVBAR ================= */

.navbar{
    width:100%;
    height:50px;
    border-bottom:1px solid rgba(255,255,255,0.05);
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:0 22px;
    background:#070b1c;
}

.logo{
    display:flex;
    align-items:center;
    gap:8px;
}

.logo h2{
    font-size:20px;
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
    padding:6px 13px;
    border-radius:8px;
    cursor:pointer;
    font-size:10px;
}

/* ================= MAIN ================= */

.container{
    width:68%;
    margin:auto;
    padding:20px 0;
}

/* ================= TABS ================= */

.tabs{
    display:flex;
    gap:22px;
    border-bottom:1px solid rgba(255,255,255,0.05);
    padding-bottom:11px;
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

/* ================= TITLE ================= */

.page-title{
    margin-top:24px;
}

.page-title h2{
    font-size:18px;
    margin-bottom:6px;
}

.page-title p{
    color:#5c63ff;
    font-size:12px;
}

/* ================= GRID ================= */

.fuel-grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:14px;
    margin-top:20px;
}

/* ================= CARD ================= */

.fuel-card{
    background:#070b1c;
    border:1px solid rgba(255,255,255,0.05);
    border-radius:15px;
    padding:16px;
}

.card-top{
    display:flex;
    justify-content:space-between;
}

.fuel-title{
    font-size:9px;
    font-weight:600;
    letter-spacing:1px;
    margin-bottom:8px;
}

.petrol{
    color:#ff6b00;
}

.diesel{
    color:#3b82f6;
}

.status{
    padding:4px 9px;
    border-radius:6px;
    font-size:9px;
    font-weight:600;
    margin-bottom:9px;
}

.available{
    background:#052e2b;
    color:#00ffbf;
}

.critical{
    background:#341212;
    color:#ff5c5c;
}

.volume{
    font-size:34px;
    font-weight:700;
    margin-bottom:4px;
}

.capacity{
    color:#5c63ff;
    font-size:11px;
}

.price{
    font-size:15px;
    font-weight:700;
}

.progress{
    width:100%;
    height:5px;
    background:#151933;
    border-radius:20px;
    margin:16px 0 9px;
    overflow:hidden;
}

.fill{
    height:100%;
    border-radius:20px;
}

.petrol-fill{
    width:48%;
    background:#00d6b4;
}

.diesel-fill{
    width:8%;
    background:#ff4d4d;
}

.bottom{
    display:flex;
    justify-content:space-between;
    color:#5c63ff;
    font-size:10px;
}

/* ================= ALERT ================= */

.alert-box{
    margin-top:14px;
    background:#1b0b12;
    border:1px solid rgba(255,77,77,0.18);
    color:#ff6b4a;
    padding:11px;
    border-radius:10px;
    font-size:11px;
}

/* ================= PRICE BOX ================= */

.price-box{
    margin-top:16px;
    background:#070b1c;
    border:1px solid rgba(255,255,255,0.05);
    border-radius:15px;
    padding:16px;
}

.price-box p{
    color:#5c63ff;
    font-size:11px;
    margin-bottom:14px;
}

.price-row{
    display:flex;
    gap:42px;
}

.price-item h5{
    font-size:9px;
    margin-bottom:7px;
    letter-spacing:1px;
}

.price-item h2{
    font-size:25px;
}

.price-item span{
    font-size:14px;
}

/* ================= RESPONSIVE ================= */

@media(max-width:900px){

    .fuel-grid{
        grid-template-columns:1fr;
    }

    .container{
        width:92%;
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

            Signed in as <b>${sessionScope.loggedUser.fullName}</b>

            <span class="role">
                 ${sessionScope.loggedUser.role}
            </span>

        </div>

        <button class="logout"
        onclick="window.location.href='/logout'">

            Logout

        </button>

    </div>

</div>

<!-- MAIN -->

<div class="container">

    <!-- NAVIGATION -->

    <div class="tabs">

        <a href="user/dashboard" class="active">
            Fuel Status
        </a>

        <a href="user/fuelorder">
            Emergency Order
        </a>

        <a href="user/myorders">
            My Orders
        </a>

    </div>

    <!-- TITLE -->

    <div class="page-title">

        <h2>
            Live Fuel Status
        </h2>

        <p>
            FuelCore Hitech City · Updated now
        </p>

    </div>

    <!-- GRID -->

    <div class="fuel-grid">

        <!-- PETROL -->

        <div class="fuel-card">

            <div class="card-top">

                <div>

                    <div class="fuel-title petrol">
                        PETROL
                    </div>

                    <div class="volume">
                        4,799 L
                    </div>

                    <div class="capacity">
                        of 10,000 L capacity
                    </div>

                </div>

                <div>

                    <div class="status available">
                        AVAILABLE
                    </div>

                    <div class="price">
                        ₹102.89/L
                    </div>

                </div>

            </div>

            <div class="progress">
                <div class="fill petrol-fill"></div>
            </div>

            <div class="bottom">

                <span>48% full</span>

                <span>Density: 0.737 kg/L</span>

            </div>

        </div>

        <!-- DIESEL -->

        <div class="fuel-card">

            <div class="card-top">

                <div>

                    <div class="fuel-title diesel">
                        DIESEL
                    </div>

                    <div class="volume">
                        1,200 L
                    </div>

                    <div class="capacity">
                        of 15,000 L capacity
                    </div>

                </div>

                <div>

                    <div class="status critical">
                        CRITICAL
                    </div>

                    <div class="price">
                        ₹89.62/L
                    </div>

                </div>

            </div>

            <div class="progress">
                <div class="fill diesel-fill"></div>
            </div>

            <div class="bottom">

                <span>8% full</span>

                <span>Density: 0.832 kg/L</span>

            </div>

            <div class="alert-box">
                ⚠ Critical — refill urgently.
            </div>

        </div>

    </div>

    <!-- PRICE BOX -->

    <div class="price-box">

        <p>
            Today's prices at FuelCore Hitech City
        </p>

        <div class="price-row">

            <div class="price-item">

                <h5 class="petrol">
                    PETROL
                </h5>

                <h2>
                    ₹102.89<span>/L</span>
                </h2>

            </div>

            <div class="price-item">

                <h5 class="diesel">
                    DIESEL
                </h5>

                <h2>
                    ₹89.62<span>/L</span>
                </h2>

            </div>

        </div>

    </div>

</div>

</body>
</html>