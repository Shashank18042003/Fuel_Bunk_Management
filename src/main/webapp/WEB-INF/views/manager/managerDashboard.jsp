<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FuelCore - Manager Dashboard</title>

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
    zoom:90%;
}

/* ================= NAVBAR ================= */

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
    font-size:22px;
    font-weight:700;
}

.branch{
    color:#5c63ff;
    font-size:11px;
}

.right-nav{
    display:flex;
    align-items:center;
    gap:12px;
}

.manager{
    background:#0c1026;
    padding:7px 12px;
    border-radius:8px;
    border:1px solid rgba(255,255,255,0.05);
    color:#cbd5e1;
    font-size:11px;
}

.logout{
    background:transparent;
    border:1px solid rgba(255,255,255,0.08);
    color:#9ca3af;
    padding:7px 14px;
    border-radius:8px;
    cursor:pointer;
    font-size:11px;
}

/* ================= MAIN ================= */

.container{
    width:72%;
    margin:auto;
    padding:22px 0;
}

/* ================= TABS ================= */

.tabs{
    display:flex;
    gap:24px;
    border-bottom:1px solid rgba(255,255,255,0.05);
    padding-bottom:12px;
}

.tabs a{
    text-decoration:none;
    color:#5c63ff;
    font-size:13px;
}

.tabs a.active{
    color:#ff6b00;
    font-weight:600;
    border-bottom:2px solid #ff6b00;
    padding-bottom:10px;
}

/* ================= FUEL GRID ================= */

.fuel-grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:16px;
    margin-top:22px;
}

/* ================= CARD ================= */

.fuel-card{
    background:#070b1c;
    border:1px solid rgba(255,255,255,0.05);
    border-radius:16px;
    padding:18px;
}

.card-top{
    display:flex;
    justify-content:space-between;
}

.fuel-title{
    font-size:10px;
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
    padding:4px 10px;
    border-radius:6px;
    font-size:10px;
    font-weight:600;
    margin-bottom:10px;
    text-align:center;
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
    font-size:38px;
    font-weight:700;
    margin-bottom:4px;
}

.capacity{
    color:#5c63ff;
    font-size:12px;
}

.price{
    font-size:16px;
    font-weight:700;
}

.progress{
    width:100%;
    height:5px;
    background:#151933;
    border-radius:20px;
    margin:18px 0 8px;
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
    font-size:11px;
}

/* ================= ALERT ================= */

.alert-box{
    margin-top:16px;
    background:#1b0b12;
    border:1px solid rgba(255,77,77,0.18);
    color:#ff6b4a;
    padding:12px;
    border-radius:10px;
    font-size:12px;
}

/* ================= INVENTORY ================= */

.inventory-box{
    margin-top:18px;
    background:#070b1c;
    border:1px solid rgba(255,255,255,0.05);
    border-radius:16px;
    padding:20px;
}

.inventory-box h3{
    margin-bottom:16px;
    font-size:16px;
}

.form-grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:14px;
}

.input-group label{
    display:block;
    margin-bottom:8px;
    font-size:11px;
    font-weight:600;
}

.input-group input{
    width:100%;
    height:44px;
    background:#050816;
    border:1px solid rgba(255,255,255,0.05);
    border-radius:8px;
    padding:0 12px;
    color:white;
    outline:none;
    font-size:13px;
}

.input-group input:focus{
    border:1px solid #ff6b00;
}

.update-btn{
    margin-top:18px;
    width:160px;
    height:44px;
    border:none;
    border-radius:8px;
    background:#ff6b00;
    color:white;
    font-size:13px;
    font-weight:600;
    cursor:pointer;
}

.update-btn:hover{
    background:#ff7a1a;
}

/* ================= RESPONSIVE ================= */

@media(max-width:900px){

    .fuel-grid{
        grid-template-columns:1fr;
    }

    .form-grid{
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

        <div class="manager">
            Signed in as <b>Ravi Kumar</b>
        </div>

        <button class="logout"
        onclick="window.location.href='/'">

            Logout

        </button>

    </div>

</div>

<!-- MAIN -->

<div class="container">

    <!-- NAVIGATION -->

    <div class="tabs">

        <a href="managerDashboard.jsp" class="active">
            Fuel Levels
        </a>

        <a href="managerOrders.jsp">
            Orders
        </a>

        <a href="managerPrices.jsp">
            Prices
        </a>

    </div>

    <!-- FUEL LEVELS -->

    <div class="fuel-grid">

        <!-- PETROL -->

        <div class="fuel-card">

            <div class="card-top">

                <div>

                    <div class="fuel-title petrol">
                        PETROL
                    </div>

                    <div class="volume">
                        4,800 L
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

    <!-- UPDATE INVENTORY -->

    <div class="inventory-box">

        <h3>
            Update Inventory
        </h3>

        <form action="updateInventory" method="post">

            <div class="form-grid">

                <!-- PETROL -->

                <div class="input-group">

                    <label class="petrol">
                        PETROL VOLUME (L)
                    </label>

                    <input type="text"
                    value="4800"
                    name="petrolVolume">

                </div>

                <!-- DIESEL -->

                <div class="input-group">

                    <label class="diesel">
                        DIESEL VOLUME (L)
                    </label>

                    <input type="text"
                    value="1200"
                    name="dieselVolume">

                </div>

            </div>

            <button class="update-btn">

                Update Inventory

            </button>

        </form>

    </div>

</div>

</body>
</html>