<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>FITNAZE | Payment Status</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&family=Oswald:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --brand-orange: #ff5722;
            --pending-yellow: #ffc107;
            --dark-bg: #0f0f0f;
        }

        body { 
            margin: 0; 
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.9)), 
                        url('/images/success-bg.jpg'); 
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: white; 
            font-family: 'Poppins', sans-serif; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
        }

        .status-card { 
            background: rgba(20, 20, 20, 0.85);
            backdrop-filter: blur(15px);
            padding: 50px; 
            border-radius: 20px; 
            text-align: center; 
            width: 450px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 25px 60px rgba(0,0,0,0.6);
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .icon-box {
            width: 90px;
            height: 90px;
            background: var(--pending-yellow);
            color: #000;
            font-size: 40px;
            line-height: 90px;
            border-radius: 50%;
            margin: 0 auto 25px;
            box-shadow: 0 0 30px rgba(255, 193, 7, 0.3);
        }

        h2 { 
            font-family: 'Oswald', sans-serif; 
            font-size: 2.2rem; 
            margin: 0; 
            letter-spacing: 3px; 
            text-transform: uppercase;
        }
        
        h2 span { color: var(--brand-orange); }

        .pending-text {
            display: inline-block;
            background: rgba(255, 193, 7, 0.1);
            color: var(--pending-yellow);
            padding: 5px 15px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: bold;
            margin-top: 15px;
            text-transform: uppercase;
            border: 1px solid var(--pending-yellow);
        }

        p { 
            color: #ccc; 
            margin: 20px 0 30px 0; 
            line-height: 1.6;
        }

        .btn-group {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .btn-history { 
            display: block; 
            padding: 15px; 
            background: var(--brand-orange); 
            color: white; 
            text-decoration: none; 
            font-family: 'Oswald', sans-serif;
            font-size: 1.1rem;
            font-weight: bold; 
            border-radius: 8px; 
            transition: 0.4s;
            text-transform: uppercase;
        }

        .btn-home { 
            display: block; 
            padding: 12px; 
            background: transparent; 
            color: #888; 
            text-decoration: none; 
            font-size: 0.9rem;
            transition: 0.3s;
        }

        .btn-history:hover { background: #e64a19; transform: translateY(-3px); }
        .btn-home:hover { color: white; }
    </style>
</head>
<body>

    <div class="status-card">
        <div class="icon-box">
            <i class="fas fa-clock"></i>
        </div>
        
        <h2>PAYMENT <span>PENDING</span></h2>
        <div class="pending-text">Awaiting Admin Approval</div>
        
        <p>Your payment request has been submitted. Once the admin verifies your transaction, your membership will be activated.</p>
        
        <div class="btn-group">
            <!-- මෙතනින් History එකට යන්න පුළුවන් -->
            <a href="/payment-history" class="btn-history">VIEW PAYMENT HISTORY</a>
            <a href="/select-plan" class="btn-home">Back to Dashboard</a>
        </div>
    </div>

</body>
</html>