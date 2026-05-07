<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FuelCore - Manager Orders</title>

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

/* TABS */

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
    margin-top:28px;
    margin-bottom:20px;
    font-size:18px;
    font-weight:600;
}

/* TABLE */

.table-wrapper{
    background:#070b1c;
    border:1px solid rgba(255,255,255,0.05);
    border-radius:16px;
    overflow:hidden;
}

table{
    width:100%;
    border-collapse:collapse;
}

thead{
    background:#0c1128;
}

thead th{
    padding:16px 14px;
    text-align:left;
    color:#5c63ff;
    font-size:11px;
    font-weight:600;
    text-transform:uppercase;
}

tbody tr{
    border-top:1px solid rgba(255,255,255,0.04);
    transition:0.3s;
}

tbody tr:hover{
    background:#0d1229;
}

tbody td{
    padding:16px 14px;
    font-size:13px;
    color:#d1d5db;
}

/* BADGES */

.badge{
    padding:5px 10px;
    border-radius:6px;
    font-size:10px;
    font-weight:600;
    display:inline-block;
}

.petrol{
    background:#2d160b;
    color:#ff6b00;
}

.diesel{
    background:#0b1d3b;
    color:#3b82f6;
}

.online{
    background:#052e2b;
    color:#00ffbf;
}

.pending{
    background:#23124a;
    color:#9b6dff;
}

.delivered{
    background:#052e2b;
    color:#00ffbf;
}

/* ACTION BUTTON */

.dispatch-btn{
    border:none;
    background:#ff6b00;
    color:white;
    padding:8px 16px;
    border-radius:8px;
    cursor:pointer;
    font-size:12px;
    font-weight:600;
}

.dispatch-btn:hover{
    background:#ff7a1a;
}

.done{
    color:#00ffbf;
    font-weight:600;
    font-size:12px;
}

/* RESPONSIVE */

@media(max-width:1000px){

    .container{
        width:92%;
    }

    .table-wrapper{
        overflow-x:auto;
    }

    table{
        min-width:1000px;
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

        <a href="managerOrders.jsp" class="active">
            Orders
        </a>

        <a href="managerPrices.jsp">
            Prices
        </a>

    </div>

    <!-- TITLE -->

    <div class="page-title">
        Branch Orders – FuelCore Hitech City
    </div>

    <!-- TABLE -->

    <div class="table-wrapper">

        <table>

            <thead>

                <tr>

                    <th>Order</th>
                    <th>Customer</th>
                    <th>Fuel</th>
                    <th>Volume</th>
                    <th>Amount</th>
                    <th>Payment</th>
                    <th>Slot</th>
                    <th>Status</th>
                    <th>Action</th>

                </tr>

            </thead>

            <tbody>

                <tr>

                    <td>ORD001</td>

                    <td>Kiran Reddy</td>

                    <td>
                        <span class="badge petrol">
                            PETROL
                        </span>
                    </td>

                    <td>5L</td>

                    <td>
                        <b>₹514.45</b>
                    </td>

                    <td>
                        <span class="badge online">
                            ONLINE
                        </span>
                    </td>

                    <td>10:00 AM</td>

                    <td>
                        <span class="badge delivered">
                            DELIVERED
                        </span>
                    </td>

                    <td class="done">
                        ✓ Done
                    </td>

                </tr>

                <tr>

                    <td>ORD003</td>

                    <td>Sanjay V</td>

                    <td>
                        <span class="badge petrol">
                            PETROL
                        </span>
                    </td>

                    <td>3L</td>

                    <td>
                        <b>₹308.67</b>
                    </td>

                    <td>
                        <span class="badge online">
                            ONLINE
                        </span>
                    </td>

                    <td>12:00 PM</td>

                    <td>
                        <span class="badge pending">
                            PENDING
                        </span>
                    </td>

                    <td>

                        <button class="dispatch-btn">

                            Dispatch

                        </button>

                    </td>

                </tr>

            </tbody>

        </table>

    </div>

</div>

</body>
</html>