<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FuelCore - Manager Prices</title>

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
    zoom:90%;
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

/* MAIN */

.container{
    width:72%;
    margin:auto;
    padding:22px 0;
}

/* NAVIGATION */

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

/* TITLE */

.page-title{
    margin-top:30px;
    margin-bottom:22px;
    font-size:18px;
    font-weight:600;
}

/* PRICE CARD */

.price-card{
    width:430px;
    background:#070b1c;
    border:1px solid rgba(255,255,255,0.05);
    border-radius:18px;
    padding:20px;
}

/* INPUTS */

.input-group{
    margin-bottom:20px;
}

.input-group label{
    display:block;
    margin-bottom:10px;
    font-size:11px;
    font-weight:600;
    text-transform:uppercase;
}

.petrol{
    color:#ff6b00;
}

.diesel{
    color:#3b82f6;
}

/* NUMBER INPUT */

.number-input{
    width:100%;
    height:44px;
    background:#050816;
    border:1px solid rgba(255,255,255,0.06);
    border-radius:10px;
    padding:0 14px;
    color:white;
    outline:none;
    font-size:14px;
    transition:0.3s;
}

/* SHOW INCREMENT ONLY ON HOVER */

.number-input::-webkit-inner-spin-button,
.number-input::-webkit-outer-spin-button{
    opacity:0;
    transition:0.2s;
}

.number-input:hover::-webkit-inner-spin-button,
.number-input:hover::-webkit-outer-spin-button{
    opacity:1;
}

.number-input:focus{
    border:1px solid #ff6b00;
}

/* BUTTON */

.update-btn{
    margin-top:6px;
    width:180px;
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

/* RESPONSIVE */

@media(max-width:900px){

    .container{
        width:92%;
    }

    .price-card{
        width:100%;
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
        onclick="window.location.href='login.jsp'">

            Logout

        </button>

    </div>

</div>

<!-- MAIN -->

<div class="container">

    <!-- NAVIGATION -->

    <div class="tabs">

        <a href="managerDashboard.jsp">
            Fuel Levels
        </a>

        <a href="managerOrders.jsp">
            Orders
        </a>

        <a href="managerPrices.jsp" class="active">
            Prices
        </a>

    </div>

    <!-- TITLE -->

    <div class="page-title">
        Price Management
    </div>

    <!-- PRICE CARD -->

    <div class="price-card">

        <form action="updateBranchPrices" method="post">

            <!-- PETROL -->

            <div class="input-group">

                <label class="petrol">
                    Petrol Price (₹/L)
                </label>

                <input type="number"
                       step="0.01"
                       class="number-input"
                       value="102.89"
                       name="petrolPrice">

            </div>

            <!-- DIESEL -->

            <div class="input-group">

                <label class="diesel">
                    Diesel Price (₹/L)
                </label>

                <input type="number"
                       step="0.01"
                       class="number-input"
                       value="89.62"
                       name="dieselPrice">

            </div>

            <!-- BUTTON -->

            <button class="update-btn">

                Update Branch Prices

            </button>

        </form>

    </div>

</div>

</body>
</html>