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
            --success-green: #4CAF50;
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

        /* Sidebar Design */
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

        .menu-item:hover, .menu-item.active {
            background: linear-gradient(to right, rgba(255, 87, 34, 0.25), transparent);
            border-left: 5px solid var(--brand-orange);
            transform: translateX(8px);
        }

        /* Main Content Area */
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

        /* Payment Approval Table */
        .management-card {
            background: rgba(255, 255, 255, 0.03);
            padding: 30px;
            border-radius: 20px;
            border: 1px solid rgba(255, 87, 34, 0.1);
            margin-top: 30px;
        }

        .management-card h2 {
            font-size: 1.5em;
            margin-bottom: 20px;
            color: var(--brand-orange);
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th {
            text-align: left;
            background: rgba(255, 87, 34, 0.1);
            padding: 15px;
            color: var(--brand-orange);
            text-transform: uppercase;
            font-size: 0.8em;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #1a1a1a;
            font-size: 0.9em;
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.75em;
            background: #ffa000;
            color: black;
            font-weight: bold;
        }

        .btn-approve {
            background: var(--success-green);
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: 0.3s;
        }

        .btn-approve:hover {
            background: #388e3c;
            box-shadow: 0 0 10px rgba(76, 175, 80, 0.4);
        }

        .welcome-box {
            background: rgba(255, 255, 255, 0.03);
            padding: 30px;
            border-radius: 20px;
            border: 1px solid rgba(255, 87, 34, 0.1);
            margin-bottom: 30px;
        }
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
        
        <a href="#payment-section" class="menu-item">
            <i class="fas fa-credit-card"></i> Payment Management
        </a>
        
        <a href="admin.jsp" class="menu-item">
            <i class="fas fa-calendar-check"></i> Schedule Management
        </a>

        <%-- Updated link to Feedback.jsp --%>
        <a href="Feedback.jsp" class="menu-item">
            <i class="fas fa-comment-dots"></i> Feedback Management
        </a>

        <a href="dietplan.jsp" class="menu-item">
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
            <h2 style="color: var(--brand-orange)">Welcome Back!</h2>
            <p>You have new payment requests awaiting your approval.</p>
        </div>

        <!-- Payment Management Section -->
        <div class="management-card" id="payment-section">
            <h2><i class="fas fa-file-invoice-dollar"></i> Pending Payment Approvals</h2>
            <table>
                <thead>
                    <tr>
                        <th>Member Name</th>
                        <th>Plan</th>
                        <th>Amount</th>
                        <th>Method</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Mathu</td>
                        <td>Gold Membership</td>
                        <td>Rs. 15,000</td>
                        <td>Bank Transfer</td>
                        <td><span class="status-badge">PENDING</span></td>
                        <td>
                            <form action="ApprovePaymentServlet" method="POST" style="display:inline;">
                                <input type="hidden" name="paymentId" value="101">
                                <button type="submit" class="btn-approve">APPROVE</button>
                            </form>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>