<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FITNASE | Elite System Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        /* THEME VARIABLES - UPDATED TO ORANGE */
        :root {
            --brand-orange: #ff5722; /* Your Gym Orange */
            --black-bg: #050505;
            --card-gray: rgba(20, 20, 20, 0.98);
            --text-gray: #a0a0a0;
            --input-bg: #000;
            --border-color: #222;
            --h-color: #ffffff;
        }

        /* LIGHT MODE VARIABLES */
        [data-theme="light"] {
            --black-bg: #f0f2f5;
            --card-gray: rgba(255, 255, 255, 0.95);
            --text-gray: #555;
            --input-bg: #ffffff;
            --border-color: #ddd;
            --h-color: #111;
        }

        body {
            font-family: 'Oswald', sans-serif; /* Matching your Dashboard Font */
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            /* UPDATED: Added Orange/Black Aesthetic Gym Background */
            background: linear-gradient(rgba(0,0,0,0.85), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1593079831268-3381b0db4a77?q=80&w=2069&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
            transition: background-color 0.5s ease;
        }

        /* 1. THEME TOGGLE BUTTON */
        .theme-switch {
            position: absolute;
            top: 25px;
            right: 25px;
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: var(--card-gray);
            border: 1px solid var(--border-color);
            color: var(--brand-orange);
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            z-index: 100;
            box-shadow: 0 4px 15px rgba(0,0,0,0.5);
            transition: 0.3s;
        }

        .theme-switch:hover {
            transform: scale(1.1) rotate(15deg);
            background: var(--brand-orange);
            color: white;
        }

        .bg-icons {
            position: absolute;
            width: 100%; height: 100%;
            z-index: -1;
            overflow: hidden;
        }

        /* Updated Floating Icons to Orange */
        .bg-icons i, .bg-icons span {
            position: absolute;
            color: var(--brand-orange);
            filter: drop-shadow(0 0 5px var(--brand-orange));
            opacity: 0.15;
            animation: floatGym 15s linear infinite;
            bottom: -100px;
            user-select: none;
            display: inline-block;
        }

        @keyframes floatGym {
            0% { transform: translateY(0) rotate(0deg); opacity: 0; }
            10% { opacity: 0.15; }
            100% { transform: translateY(-115vh) rotate(360deg); opacity: 0; }
        }

        /* 2. THE LOGIN CARD */
        .login-card {
            background: var(--card-gray);
            padding: 50px 40px;
            border-radius: 4px; /* Squared off to match your dashboard style */
            box-shadow: 0 10px 60px rgba(0, 0, 0, 0.7);
            width: 360px;
            text-align: center;
            position: relative;
            overflow: hidden;
            border-top: 4px solid var(--brand-orange); /* Bold Orange Top Border */
            animation: cardEntrance 0.8s ease-out;
            z-index: 10;
            transition: background 0.5s;
        }

        .scan-bar {
            position: absolute;
            top: 0; left: 0; width: 100%; height: 2px;
            background: linear-gradient(90deg, transparent, var(--brand-orange), transparent);
            background-size: 200% 100%;
            animation: scanLine 3s linear infinite;
            z-index: 2;
        }

        @keyframes scanLine { 0% { background-position: 200% 0%; } 100% { background-position: -200% 0%; } }
        @keyframes cardEntrance { from { opacity: 0; transform: scale(0.9) translateY(30px); } to { opacity: 1; transform: scale(1) translateY(0); } }

        h2 { color: var(--h-color); margin-bottom: 5px; font-weight: bold; letter-spacing: 5px; text-transform: uppercase; }
        h2 span { color: var(--brand-orange); }
        p { color: var(--text-gray); font-size: 11px; letter-spacing: 2px; margin-bottom: 35px; }

        .form-group { margin-bottom: 25px; text-align: left; }
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
    </style>
</head>
<body>

    <div class="theme-switch" onclick="toggleTheme()">
        <i id="theme-icon" class="fas fa-moon"></i>
    </div>

    <div class="bg-icons"></div>

    <div class="login-card">
        <div class="scan-bar"></div>
        
        <h2>FIT<span>NASE</span></h2>
        <p>ELITE GYM MANAGEMENT SYSTEM</p>
        
        <form id="loginForm">
            <div class="form-group">
                <label>ADMINISTRATOR ID</label>
                <input type="text" placeholder="ID-001" required>
            </div>
            
            <div class="form-group">
                <label>SECURITY PASS</label>
                <input type="password" placeholder="••••••••" required>
            </div>
            
            <button type="button" onclick="handleLogin()">Authorize Access</button>
        </form>
    </div>

    <script>
        function toggleTheme() {
            const body = document.body;
            const icon = document.getElementById('theme-icon');
            if (body.getAttribute('data-theme') === 'light') {
                body.removeAttribute('data-theme');
                icon.className = 'fas fa-moon';
            } else {
                body.setAttribute('data-theme', 'light');
                icon.className = 'fas fa-sun';
            }
        }

        function createFitnessElements() {
            const container = document.querySelector('.bg-icons');
            const icons = ['fa-dumbbell', 'fa-weight-hanging', 'fa-heart-pulse', 'fa-bolt', 'fa-stopwatch'];
            const emojis = ['💪', '🔥', '🏆'];
            const totalElements = 25;

            for (let i = 0; i < totalElements; i++) {
                const isEmoji = Math.random() > 0.7;
                const element = document.createElement(isEmoji ? 'span' : 'i');
                if (isEmoji) {
                    element.innerText = emojis[Math.floor(Math.random() * emojis.length)];
                    element.style.fontSize = "25px";
                } else {
                    element.className = `fas ${icons[Math.floor(Math.random() * icons.length)]}`;
                    element.style.fontSize = "20px";
                }
                element.style.animationDuration = (Math.random() * 8 + 10) + "s";
                element.style.animationDelay = (Math.random() * 5) + "s";
                container.appendChild(element);
            }
        }
        createFitnessElements();

        function handleLogin() {
            const card = document.querySelector('.login-card');
            card.style.transition = "0.5s";
            card.style.transform = "scale(0.8)";
            card.style.opacity = "0";
            
            setTimeout(() => {
                window.location.href = "dashboard.html"; 
            }, 600);
        }
    </script>
</body>
</html>