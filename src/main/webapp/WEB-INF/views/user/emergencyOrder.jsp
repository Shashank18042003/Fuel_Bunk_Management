<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FuelCore - Emergency Order</title>

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
	zoom: 85%;
}

/* NAVBAR */
.navbar {
	width: 100%;
	height: 52px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.05);
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 24px;
	background: #070b1c;
}

.logo {
	display: flex;
	align-items: center;
	gap: 8px;
}

.logo h2 {
	font-size: 21px;
	font-weight: 700;
}

.branch {
	color: #5c63ff;
	font-size: 10px;
}

.right-nav {
	display: flex;
	align-items: center;
	gap: 10px;
}

.user-box {
	background: #0c1026;
	padding: 6px 12px;
	border-radius: 8px;
	border: 1px solid rgba(255, 255, 255, 0.05);
	color: #cbd5e1;
	font-size: 10px;
}

.role {
	background: rgba(255, 255, 255, 0.08);
	padding: 3px 7px;
	border-radius: 5px;
	margin-left: 7px;
	font-size: 9px;
	font-weight: 600;
}

.logout {
	background: transparent;
	border: 1px solid rgba(255, 255, 255, 0.08);
	color: #9ca3af;
	padding: 6px 14px;
	border-radius: 8px;
	cursor: pointer;
	font-size: 10px;
}

/* MAIN */
.container {
	width: 68%;
	margin: auto;
	padding: 20px 0;
}
/* NAVIGATION */
.tabs {
	display: flex;
	gap: 22px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.05);
	padding-bottom: 11px;
}

.tabs a {
	text-decoration: none;
	color: #5c63ff;
	font-size: 12px;
}

.tabs a.active {
	color: #ff6b00;
	font-weight: 600;
	border-bottom: 2px solid #ff6b00;
	padding-bottom: 9px;
}

/* TITLE */
.page-title {
	margin-bottom: 22px;
}

.page-title h2 {
	font-size: 22px;
	margin-bottom: 6px;
}

.page-title p {
	color: #5c63ff;
	font-size: 12px;
}

/* CARD */
.order-card {
	background: #070b1c;
	border: 1px solid rgba(255, 255, 255, 0.05);
	border-radius: 18px;
	padding: 20px;
}

/* LABEL */
.label {
	display: block;
	margin-bottom: 10px;
	color: #5c63ff;
	font-size: 10px;
	font-weight: 600;
	text-transform: uppercase;
}

/* OPTION ROW */
.option-row {
	display: flex;
	gap: 12px;
	margin-bottom: 18px;
}

/* OPTION */
.option {
	flex: 1;
	height: 58px;
	border-radius: 10px;
	border: 1px solid rgba(255, 255, 255, 0.06);
	background: #050816;
	color: #5c63ff;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	transition: 0.3s;
	font-size: 12px;
}

.option small {
	margin-top: 4px;
	font-size: 9px;
}

/* ACTIVE */
.petrol-active {
	border: 1px solid #ff6b00;
	color: #ff6b00;
	background: rgba(255, 107, 0, 0.08);
}

.diesel-active {
	border: 1px solid #3b82f6;
	color: #3b82f6;
	background: rgba(59, 130, 246, 0.08);
}

/* WARNING */
.warning {
	color: #ff4d4d;
	font-size: 10px;
	margin-top: -8px;
	margin-bottom: 16px;
	display: none;
}

/* RANGE */
.slider-box {
	margin-bottom: 18px;
}

.range-top {
	display: flex;
	justify-content: space-between;
	margin-bottom: 12px;
	color: #5c63ff;
	font-size: 10px;
	font-weight: 600;
}

.range-value {
	color: white;
	font-size: 16px;
	font-weight: 700;
}

input[type="range"] {
	width: 100%;
	accent-color: #ff6b00;
}

.blue-range {
	accent-color: #3b82f6;
}

/* AMOUNT */
.amount-box {
	margin-top: 16px;
	background: #090d20;
	border: 1px solid rgba(255, 255, 255, 0.05);
	border-radius: 12px;
	padding: 16px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.amount-box p {
	color: #5c63ff;
	font-size: 11px;
}

.amount-box h2 {
	color: #ff6b00;
	font-size: 28px;
}

/* INPUTS */
.input-group {
	margin-top: 18px;
}

.input-group input, .input-group select {
	width: 100%;
	height: 46px;
	background: #050816;
	border: 1px solid rgba(255, 255, 255, 0.06);
	border-radius: 10px;
	padding: 0 14px;
	color: white;
	outline: none;
	font-size: 12px;
}

.input-group input:focus, .input-group select:focus {
	border: 1px solid #ff6b00;
}

/* PAYMENT */
.payment-row {
	display: flex;
	gap: 12px;
	margin-top: 10px;
}

.payment {
	flex: 1;
	height: 46px;
	border-radius: 10px;
	border: 1px solid rgba(255, 255, 255, 0.06);
	background: #050816;
	color: #5c63ff;
	display: flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	font-size: 11px;
}

.payment.active {
	border: 1px solid #ff6b00;
	color: #ff6b00;
	background: rgba(255, 107, 0, 0.08);
}

/* BUTTON */
.order-btn {
	width: 100%;
	height: 50px;
	border: none;
	border-radius: 10px;
	margin-top: 20px;
	background: #ff6b00;
	color: white;
	font-size: 15px;
	font-weight: 600;
	cursor: pointer;
}

.order-btn.diesel-btn {
	background: #3b82f6;
}

@media ( max-width :900px) {
	.container {
		width: 92%;
	}
	.option-row, .payment-row {
		flex-direction: column;
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

			<div class="user-box">

				
            Signed in as <b>${sessionScope.loggedUser.fullName}</b>

            <span class="role">
                 ${sessionScope.loggedUser.role}
            </span>

			</div>

			<button class="logout" onclick="window.location.href='/logout'">

				Logout</button>

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

			<h2>Emergency Fuel Delivery</h2>

			<p>Fuel delivered to your stranded vehicle</p>

		</div>

		<!-- CARD -->

		<div class="order-card">

			<form>

				<!-- FUEL -->

				<label class="label"> Fuel Type </label>

				<div class="option-row">

					<div class="option petrol-active" id="petrolOption"
						onclick="selectFuel('petrol')">

						⛽ Petrol <small> Max 5L · ₹102.89/L </small>

					</div>

					<div class="option" id="dieselOption"
						onclick="selectFuel('diesel')">

						🚛 Diesel <small> Max 10L · ₹89.62/L </small>

					</div>

				</div>

				<!-- VEHICLE -->

				<label class="label"> Vehicle Type </label>

				<div class="option-row">

					<div class="option petrol-active"
						onclick="selectVehicle('bike',this)">🛵 Bike</div>

					<div class="option" onclick="selectVehicle('car',this)">🚗
						Car</div>

					<div class="option" onclick="selectVehicle('truck',this)">🚚
						Truck</div>

				</div>

				<div class="warning" id="bikeWarning">⚠ Bikes cannot order
					diesel</div>

				<!-- RANGE -->

				<div class="slider-box">

					<div class="range-top">

						<span id="volumeText"> Volume — Max 5L </span> <span
							class="range-value"> <span id="liters"> 1 </span>L

						</span>

					</div>

					<input type="range" min="1" max="5" value="1" id="fuelRange"
						oninput="updateAmount()">

				</div>

				<!-- AMOUNT -->

				<div class="amount-box">

					<p>Total Amount</p>

					<h2 id="amount">₹102.89</h2>

				</div>

				<!-- LOCATION -->

				<div class="input-group">

					<label class="label"> Your Location 📍 </label> <input type="text"
						placeholder="Enter your address or share GPS location...">

				</div>

				<!-- SLOT -->

				<div class="input-group">

					<label class="label"> Delivery Time Slot </label> <select>

						<option>09:00 AM</option>
						<option>10:00 AM</option>
						<option>11:00 AM</option>
						<option>12:00 PM</option>
						<option>01:00 PM</option>
						<option>02:00 PM</option>
						<option>03:00 PM</option>
						<option>04:00 PM</option>
						<option>05:00 PM</option>

					</select>

				</div>

				<!-- PAYMENT -->

				<div class="input-group">

					<label class="label"> Payment Method </label>

					<div class="payment-row">

						<div class="payment active" onclick="selectPayment(this)">

							💳 Online</div>

						<div class="payment" onclick="selectPayment(this)">💵 Cash
							on Delivery</div>

					</div>

				</div>

				<!-- BUTTON -->

				<button type="button" class="order-btn" id="orderBtn">

					Place Order — ₹102.89</button>

			</form>

		</div>

	</div>

	<script>

let fuelType = "petrol";
let vehicleType = "bike";

function selectFuel(type){

    // PREVENT BIKE + DIESEL

    if(type === "diesel" && vehicleType === "bike"){

        document.getElementById("bikeWarning")
        .style.display = "block";

        return;
    }

    fuelType = type;

    const petrol =
    document.getElementById("petrolOption");

    const diesel =
    document.getElementById("dieselOption");

    const range =
    document.getElementById("fuelRange");

    const amount =
    document.getElementById("amount");

    const btn =
    document.getElementById("orderBtn");

    petrol.classList.remove("petrol-active");
    diesel.classList.remove("diesel-active");

    if(type === "petrol"){

        petrol.classList.add("petrol-active");

        range.max = 5;
        range.value = 1;

        range.classList.remove("blue-range");

        amount.style.color = "#ff6b00";

        btn.classList.remove("diesel-btn");

        document.getElementById("volumeText")
        .innerHTML = "Volume — Max 5L";

    }
    else{

        diesel.classList.add("diesel-active");

        range.max = 10;
        range.value = 1;

        range.classList.add("blue-range");

        amount.style.color = "#3b82f6";

        btn.classList.add("diesel-btn");

        document.getElementById("volumeText")
        .innerHTML = "Volume — Max 10L";

    }

    document.getElementById("bikeWarning")
    .style.display = "none";

    updateAmount();

}

function updateAmount(){

    const liters =
    document.getElementById("fuelRange").value;

    document.getElementById("liters")
    .innerHTML = liters;

    let price =
    fuelType === "petrol"
    ? 102.89
    : 89.62;

    let total =
    (liters * price).toFixed(2);

    document.getElementById("amount")
    .innerHTML = "₹" + total;

    document.getElementById("orderBtn")
    .innerHTML = "Place Order — ₹" + total;

}

function selectVehicle(type,element){

    vehicleType = type;

    document
    .querySelectorAll(".option-row")[1]
    .querySelectorAll(".option")
    .forEach(btn => {

        btn.classList.remove("petrol-active");

    });

    element.classList.add("petrol-active");

    // IF BIKE + DIESEL RESET

    if(vehicleType === "bike"
    && fuelType === "diesel"){

        document.getElementById("bikeWarning")
        .style.display = "block";

        selectFuel("petrol");

    }
    else{

        document.getElementById("bikeWarning")
        .style.display = "none";

    }

}

function selectPayment(element){

    document
    .querySelectorAll(".payment")
    .forEach(btn => {

        btn.classList.remove("active");

    });

    element.classList.add("active");

}

</script>

</body>
</html>