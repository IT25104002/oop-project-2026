<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ta">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FITNASE | Elite Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --brand-orange: #ff5722;
            --black-bg: #080808;
            --sidebar-bg: #0a0a0a;
            --card-hover: rgba(255, 87, 34, 0.15);
        }

        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            margin: 0;
            background-color: var(--black-bg);
            color: white;
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        /* Sidebar Design based on your screenshot */
        .sidebar {
            width: 300px;
            background: var(--sidebar-bg);
            padding: 40px 20px;
            display: flex;
            flex-direction: column;
            border-right: 1px solid #1a1a1a;
        }

        .brand-logo {
            font-size: 2.2em;
            font-weight: 800;
            letter-spacing: 5px;
            margin-bottom: 50px;
            text-align: center;
            text-transform: uppercase;
        }
        .brand-logo span { color: var(--brand-orange); }

        .menu-item {
            padding: 18px 25px;
            color: #ffffff;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 20px;
            border-radius: 12px;
            margin-bottom: 15px;
            transition: all 0.3s ease;
            text-transform: uppercase;
            font-size: 0.85em;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .menu-item i { 
            color: var(--brand-orange); 
            font-size: 1.3em; 
            width: 25px;
            text-align: center;
        }

        /* Active/Hover State */
        .menu-item:hover, .menu-item.active {
            background: linear-gradient(to right, rgba(255, 87, 34, 0.25), transparent);
            border-left: 5px solid var(--brand-orange);
            transform: translateX(8px);
        }

        .main-content {
            flex-grow: 1;
            padding: 50px;
            overflow-y: auto;
            background: radial-gradient(circle at top right, #1a100d, #080808);
        }

        .header h1 { 
            font-size: 2em; 
            letter-spacing: 2px; 
            margin-bottom: 40px; 
            border-left: 5px solid var(--brand-orange);
            padding-left: 20px;
        }

        .welcome-box {
            background: rgba(255, 255, 255, 0.03);
            padding: 30px;
            border-radius: 20px;
            border: 1px solid rgba(255, 87, 34, 0.1);
        }

        .welcome-box p { color: #aaa; line-height: 1.8; font-size: 1.1em; }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="brand-logo">FIT<span>NASE</span></div>
        
        <a href="Admindashboard.jsp" class="menu-item active">
            <i class="fas fa-th-large"></i> Dashboard Overview
        </a>
        
        <a href="Dashboard.jsp" class="menu-item">
            <i class="fas fa-users-gear"></i> Manage Members
        </a>
        
        <a href="payment-management.jsp" class="menu-item">
            <i class="fas fa-credit-card"></i> Payment Management
        </a>
        
        <a href="schedule-management.jsp" class="menu-item">
            <i class="fas fa-calendar-check"></i> Schedule Management
        </a>

        <a href="feedback-management.jsp" class="menu-item">
            <i class="fas fa-comment-dots"></i> Feedback Management
        </a>

        <a href="diet-plan-management.jsp" class="menu-item">
            <i class="fas fa-utensils"></i> Diet Plan Management
        </a>

        <a href="AdminLogin.jsp" class="menu-item" style="margin-top: auto; color: #ff4444;">
            <i class="fas fa-power-off" style="color: #ff4444;"></i> Log Out
        </a>
    </div>

    <div class="main-content">
        <div class="header">
            <h1>Admin Dashboard</h1>
        </div>

        <div class="welcome-box">
            <h2 style="color: var(--brand-orange)">welcome!!</h2>
            <p>
                Hey sunflower , miss you badly!!!!.
            </p>
        </div>
    </div>

</body>
</html>