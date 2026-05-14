<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // தரவுகளைப் பெறுதல்
    String name = request.getParameter("p-name");
    String plan = request.getParameter("p-plan");
    String amount = request.getParameter("p-amount");
    String method = request.getParameter("p-method");

    if(name == null) name = "User";
    if(plan == null) plan = "N/A";
    if(amount == null) amount = "0.00";
    if(method == null) method = "Standard";

    // இதுதான் முக்கியம்: அட்மின் அங்கீகார நிலை
    String status = "Pending"; 
%>
<!DOCTYPE html>
<html>
<head>
    <title>FITNAZE | Payment Status</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&family=Oswald:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { --brand-orange: #ff5722; --pending-yellow: #ffc107; --success-green: #4CAF50; }
        body { 
            margin: 0; background: linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.9)), url('https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80'); 
            background-size: cover; color: white; font-family: 'Poppins', sans-serif; 
            display: flex; justify-content: center; align-items: center; height: 100vh; 
        }
        .status-card { 
            background: rgba(20, 20, 20, 0.9); padding: 40px; border-radius: 20px; text-align: center; width: 400px;
            border: 1px solid rgba(255, 87, 34, 0.2); box-shadow: 0 20px 50px rgba(0,0,0,0.5);
        }
        .icon-box {
            width: 80px; height: 80px; margin: 0 auto 20px; border-radius: 50%; line-height: 80px; font-size: 35px;
            background: <%= status.equals("Approved") ? "var(--success-green)" : "var(--pending-yellow)" %>; color: black;
        }
        .details-box { background: rgba(255,255,255,0.05); padding: 15px; border-radius: 10px; margin: 20px 0; text-align: left; }
        .details-box b { float: right; color: var(--brand-orange); }
        .btn-history { 
            display: block; padding: 15px; background: var(--brand-orange); color: white; text-decoration: none; 
            font-weight: bold; border-radius: 8px; text-transform: uppercase; margin-bottom: 10px;
        }
        .disabled { opacity: 0.5; cursor: not-allowed; background: #444; }
    </style>
</head>
<body>

    <div class="status-card">
        <div class="icon-box">
            <i class="fas <%= status.equals("Approved") ? "fa-check" : "fa-clock" %>"></i>
        </div>
        
        <h2 style="font-family: 'Oswald';">PAYMENT <span style="color:var(--brand-orange)"><%= status.toUpperCase() %></span></h2>
        
        <div class="details-box">
            <p>Member: <b><%= name %></b></p>
            <p>Amount: <b>Rs. <%= amount %></b></p>
            <p>Status: <b><%= status %></b></p>
        </div>

        <% if(status.equals("Approved")) { %>
            <a href="payment-history.jsp" class="btn-history">VIEW PAYMENT HISTORY</a>
        <% } else { %>
            <div class="btn-history disabled">AWAITING APPROVAL</div>
            <p style="font-size: 12px; color: #888;">Please refresh the page once admin approves.</p>
        <% } %>
        <a href="index.jsp" style="color: #888; text-decoration: none; font-size: 14px;">Back to Dashboard</a>
    </div>

</body>
</html>