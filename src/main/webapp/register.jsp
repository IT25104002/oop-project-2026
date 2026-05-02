<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FITNASE | Elite System Registration</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --brand-orange: #ff5722;
            --black-bg: #050505;
            --card-gray: rgba(20, 20, 20, 0.98);
            --text-gray: #a0a0a0;
            --input-bg: #000;
            --border-color: #222;
            --h-color: #ffffff;
        }

        body {
            font-family: 'Oswald', sans-serif;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(rgba(0,0,0,0.85), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1593079831268-3381b0db4a77?q=80&w=2069&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
            overflow: hidden;
        }

        .login-card {
            background: var(--card-gray);
            padding: 50px 40px;
            border-radius: 4px;
            box-shadow: 0 10px 60px rgba(0, 0, 0, 0.7);
            width: 360px;
            text-align: center;
            border-top: 4px solid var(--brand-orange);
            animation: cardEntrance 0.8s ease-out;
            z-index: 10;
        }

        @keyframes cardEntrance { from { opacity: 0; transform: scale(0.9) translateY(30px); } to { opacity: 1; transform: scale(1) translateY(0); } }

        h2 { color: var(--h-color); margin-bottom: 5px; font-weight: bold; letter-spacing: 5px; text-transform: uppercase; }
        h2 span { color: var(--brand-orange); }
        p { color: var(--text-gray); font-size: 11px; letter-spacing: 2px; margin-bottom: 35px; }

        .form-group { margin-bottom: 20px; text-align: left; }
        label { color: var(--brand-orange); font-size: 10px; font-weight: 700; letter-spacing: 1px; display: block; margin-bottom: 8px; }
        
        input {
            width: 100%; padding: 14px; background: var(--input-bg); border: 1px solid var(--border-color);
            border-radius: 2px; color: var(--h-color); box-sizing: border-box; transition: 0.3s;
            font-family: 'Oswald', sans-serif;
        }

        input:focus { outline: none; border-color: var(--brand-orange); background: #111; }

        button {
            width: 100%; padding: 15px; background: var(--brand-orange); color: white;
            border: none; border-radius: 2px; font-weight: 700; text-transform: uppercase;
            letter-spacing: 2px; cursor: pointer; transition: 0.4s; margin-top: 10px;
            font-family: 'Oswald', sans-serif;
        }

        button:hover { background: #e64a19; box-shadow: 0 0 20px rgba(255, 87, 34, 0.4); transform: translateY(-2px); }

        .link-text { margin-top: 25px; font-size: 11px; color: var(--text-gray); }
        .link-text a { color: var(--brand-orange); text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>

    <div class="login-card">
        <h2>REGIS<span>TER</span></h2>
        <p>CREATE ELITE ACCESS</p>
        
        <form action="login.jsp" method="GET">
            <div class="form-group">
                <label>ADMINISTRATOR ID</label>
                <input type="text" placeholder="e.g. ID-001" required>
            </div>
            
            <div class="form-group">
                <label>FULL NAME</label>
                <input type="text" placeholder="e.g. John Doe" required>
            </div>

            <div class="form-group">
                <label>SECURITY PASS</label>
                <input type="password" placeholder="••••••••" required>
            </div>
            
            <button type="submit">Create Account</button>
        </form>

        <div class="link-text">
            Already have access? <a href="login.jsp">Login Here</a>
        </div>
    </div>

</body>
</html>
