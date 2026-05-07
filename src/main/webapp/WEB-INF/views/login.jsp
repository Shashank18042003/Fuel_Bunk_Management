<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>FuelCore Login</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:#050816;
    overflow:hidden;
}

/* Background Glow */
body::before{
    content:'';
    position:absolute;
    width:400px;
    height:400px;
    background:#ff6b00;
    filter:blur(180px);
    opacity:0.08;
    top:-120px;
    right:-100px;
}

body::after{
    content:'';
    position:absolute;
    width:350px;
    height:350px;
    background:#3b82f6;
    filter:blur(180px);
    opacity:0.07;
    bottom:-120px;
    left:-100px;
}

.login-container{
    width:380px;
    background:rgba(10,12,30,0.95);
    border:1px solid rgba(255,255,255,0.08);
    border-radius:18px;
    padding:35px;
    box-shadow:0 0 30px rgba(0,0,0,0.5);
    position:relative;
    z-index:2;
}

.small-title{
    color:#ff6b00;
    font-size:11px;
    font-weight:600;
    letter-spacing:2px;
    text-transform:uppercase;
    text-align:center;
    margin-bottom:10px;
}

.main-title{
    color:white;
    text-align:center;
    font-size:42px;
    font-weight:700;
}

.subtitle{
    text-align:center;
    color:#7c83ff;
    font-size:14px;
    margin-top:8px;
    margin-bottom:35px;
}

label{
    display:block;
    color:#5c63ff;
    font-size:12px;
    font-weight:600;
    margin-bottom:10px;
    text-transform:uppercase;
}

select,
input{
    width:100%;
    height:48px;
    background:#070b1c;
    border:1px solid rgba(255,255,255,0.08);
    border-radius:10px;
    color:white;
    padding:0 15px;
    outline:none;
    margin-bottom:22px;
    transition:0.3s;
}

select:focus,
input:focus{
    border:1px solid #ff6b00;
    box-shadow:0 0 10px rgba(255,107,0,0.3);
}

.role-container{
    display:flex;
    gap:10px;
    margin-bottom:22px;
}

.role-btn{
    flex:1;
    height:40px;
    border-radius:10px;
    border:1px solid rgba(255,255,255,0.08);
    background:#070b1c;
    color:#7c83ff;
    cursor:pointer;
    transition:0.3s;
    font-weight:500;
}

.role-btn.active{
    border:1px solid #ff6b00;
    color:#ff6b00;
    box-shadow:0 0 15px rgba(255,107,0,0.2);
}

.login-btn{
    width:100%;
    height:50px;
    border:none;
    border-radius:10px;
    background:#ff6b00;
    color:white;
    font-size:16px;
    font-weight:600;
    cursor:pointer;
    transition:0.3s;
    margin-top:5px;
}

.login-btn:hover{
    background:#ff7f1f;
    transform:translateY(-2px);
}

.hint{
    text-align:center;
    color:#5c63ff;
    font-size:12px;
    margin-top:15px;
}

.register{
    text-align:center;
    margin-top:20px;
    color:#9ca3af;
    font-size:14px;
}

.register a{
    color:#ff6b00;
    text-decoration:none;
    font-weight:600;
}

.register a:hover{
    text-decoration:underline;
}

</style>

</head>
<body>

<div>

    <div class="small-title">Fuel Management System</div>

    <div class="main-title">FuelCore</div>

    <div class="subtitle">
        Intelligent fuel bunk operations platform
    </div>

    <div class="login-container">

        <form action="login" method="post">

            
            <!-- EMAIL FIELD -->
            <label>Email</label>

            <input type="email" name="email"
                placeholder="Enter your email">

            <!-- PASSWORD FIELD -->
            <label>Password</label>

            <input type="password" name="password"
                placeholder="Enter password">

            <button class="login-btn">
                Access Platform →
            </button>

            <!-- REGISTER HERE -->
            <div class="register">
                Don’t have an account?
                <a href="register.jsp">Register Here</a>
            </div>

        </form>

    </div>

</div>
</body>
</html>