<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // URL மூலம் வரும் பிளான் பெயரைப் பெறுதல்
    String selectedPlan = request.getParameter("plan");
    if (selectedPlan == null || selectedPlan.isEmpty()) {
        selectedPlan = "Bronze"; 
    }
    
    // பயனர் தகவல்கள்
    String userName = "Mathu"; 
    String userId = "FN-2026-089";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FITNAZE | Elite Secure Payment</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&family=Oswald:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --brand-orange: #ff5722;
            --dark-bg: #0f0f0f;
            --card-bg: rgba(26, 26, 26, 0.98);
            --text-gray: #bbbbbb;
            --glow-orange: rgba(255, 87, 34, 0.4);
        }

        body { 
            margin: 0; 
            background: linear-gradient(rgba(0, 0, 0, 0.85), rgba(0, 0, 0, 0.95)), 
                        url('https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=2070'); 
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: white; 
            font-family: 'Poppins', sans-serif; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            min-height: 100vh; 
        }

        .card { 
            background: var(--card-bg);
            backdrop-filter: blur(15px);
            padding: 40px; 
            border-radius: 15px; 
            width: 450px; 
            border: 1px solid rgba(255, 255, 255, 0.1); 
            box-shadow: 0 20px 50px rgba(0,0,0,0.8);
            position: relative;
        }

        .card::before {
            content: "";
            position: absolute;
            top: 0; left: 0; width: 100%; height: 4px;
            background: var(--brand-orange);
            box-shadow: 0 0 15px var(--brand-orange);
        }

        h2 { 
            color: white; 
            text-align: center; 
            font-family: 'Oswald', sans-serif;
            font-size: 2.2rem;
            letter-spacing: 3px; 
            margin-bottom: 20px; 
            text-transform: uppercase;
        }
        
        h2 span { color: var(--brand-orange); }

        .user-info { 
            text-align: center; 
            font-size: 13px; 
            color: var(--text-gray); 
            margin-bottom: 25px; 
            background: rgba(255,255,255,0.05);
            padding: 15px;
            border-radius: 8px;
            border: 1px solid rgba(255, 87, 34, 0.2);
        }

        .plan-badge { 
            background: var(--brand-orange); 
            color: white; 
            padding: 4px 15px; 
            border-radius: 20px; 
            font-weight: bold; 
            text-transform: uppercase;
            font-size: 11px;
            margin-left: 5px;
            display: inline-block;
            box-shadow: 0 0 10px var(--glow-orange);
        }

        label { 
            font-size: 11px; 
            color: var(--brand-orange); 
            font-weight: bold; 
            display: block; 
            margin-top: 20px; 
            text-transform: uppercase; 
            letter-spacing: 1px;
        }

        select, input { 
            width: 100%; 
            padding: 12px; 
            background: rgba(0,0,0,0.7); 
            border: 1px solid #333; 
            color: white; 
            border-radius: 5px; 
            margin-top: 8px; 
            box-sizing: border-box; 
            outline: none; 
            transition: 0.3s;
        }

        select:focus, input:focus { 
            border-color: var(--brand-orange); 
            background: #000;
        }

        .method-box { 
            background: rgba(0, 0, 0, 0.5); 
            padding: 15px; 
            border-radius: 8px; 
            margin-top: 15px; 
            border-left: 4px solid var(--brand-orange); 
        }

        .total-box { 
            background: rgba(255, 87, 34, 0.15); 
            padding: 20px; 
            text-align: center; 
            margin-top: 25px; 
            border-radius: 10px; 
            border: 2px dashed var(--brand-orange); 
        }

        .btn { 
            width: 100%; 
            padding: 15px; 
            background: var(--brand-orange); 
            border: none; 
            color: white; 
            font-family: 'Oswald', sans-serif;
            font-size: 1.2rem;
            font-weight: bold; 
            margin-top: 25px; 
            cursor: pointer; 
            border-radius: 5px; 
            transition: 0.4s; 
            text-transform: uppercase;
        }

        .btn:hover { 
            background: #e64a19; 
            box-shadow: 0 0 25px var(--glow-orange);
            transform: translateY(-2px); 
        }
    </style>
</head>
<body>
    <div class="card">
        <h2>SECURE <span>PAYMENT</span></h2>
        
        <!-- User Info Header -->
        <div class="user-info">
            <i class="fas fa-user-circle"></i> User: <b><%= userName %></b> | ID: <b><%= userId %></b><br>
            <div style="margin-top: 10px;">
                Selected Plan: <span class="plan-badge" id="planLabel"><%= selectedPlan %></span>
            </div>
        </div>

        <!-- Payment Form -->
        <form action="payment-success.jsp" method="POST">
            <!-- Hidden inputs to pass data to payment-success.jsp -->
            <input type="hidden" name="p-name" value="<%= userName %>">
            <input type="hidden" name="p-plan" value="<%= selectedPlan %>">
            <input type="hidden" name="p-amount" id="finalAmountInput">

            <label><i class="fas fa-clock"></i> Membership Duration</label>
            <select name="p-duration" id="durationSelect" onchange="calculateTotal()">
                <option value="1">1 Month (Regular)</option>
                <option value="3">3 Months (5% OFF)</option>
                <option value="6">6 Months (10% OFF)</option>
                <option value="12">12 Months (20% OFF)</option>
            </select>

            <label><i class="fas fa-credit-card"></i> Payment Method</label>
            <select name="p-method" id="methodSelect" onchange="togglePaymentFields()">
                <option value="Card">Credit / Debit Card</option>
                <option value="Online">Online Transfer</option>
            </select>

            <!-- Card Payment Fields -->
            <div id="cardSection" class="method-box">
                <input type="text" placeholder="Card Number (16 Digits)" maxlength="16">
                <div style="display: flex; gap: 10px; margin-top: 10px;">
                    <input type="text" placeholder="MM/YY" maxlength="5">
                    <input type="password" placeholder="CVV" maxlength="3">
                </div>
            </div>

            <!-- Online Transfer Fields -->
            <div id="onlineSection" class="method-box" style="display:none;">
                <p style="font-size: 11px; color: var(--text-gray); margin: 0 0 10px 0;">
                    Official Bank: <b style="color: white;">BOC - 123456789</b>
                </p>
                <label style="color: #888; font-size: 9px;">Proof of Payment (Image)</label>
                <input type="file" style="font-size: 10px; border: none; background: none; padding: 5px 0;">
            </div>

            <!-- Total Amount Display -->
            <div class="total-box">
                <span style="font-size: 10px; color: var(--text-gray); letter-spacing: 2px;">TOTAL AMOUNT DUE</span><br>
                <span style="font-size: 34px; font-weight: bold; color: white;">Rs. <span id="amountDisplay">0</span></span>
            </div>

            <button type="submit" class="btn">Confirm & Pay Now</button>
        </form>
    </div>

    <script>
        function calculateTotal() {
            const prices = { "Bronze": 5000, "Silver": 8000, "Gold": 12000 };
            const discounts = { "1": 0.00, "3": 0.05, "6": 0.10, "12": 0.20 };

            let selectedPlan = document.getElementById("planLabel").innerText.trim();
            let duration = document.getElementById("durationSelect").value;

            let monthlyPrice = prices[selectedPlan] || 0;
            let subtotal = monthlyPrice * parseInt(duration);
            let discountRate = discounts[duration];
            let finalPrice = subtotal - (subtotal * discountRate);

            document.getElementById("amountDisplay").innerText = finalPrice.toLocaleString();
            document.getElementById("finalAmountInput").value = finalPrice;
        }

        function togglePaymentFields() {
            let method = document.getElementById("methodSelect").value;
            document.getElementById("cardSection").style.display = (method === 'Card') ? 'block' : 'none';
            document.getElementById("onlineSection").style.display = (method === 'Online') ? 'block' : 'none';
        }

        window.onload = function() {
            calculateTotal();
            togglePaymentFields();
        };
    </script>
</body>
</html>