<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>FITNAZE | Elite Secure Payment</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&family=Oswald:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --brand-orange: #ff5722;
            --dark-bg: #0f0f0f;
            --card-bg: rgba(26, 26, 26, 0.9); /* Slightly transparent */
            --text-gray: #bbbbbb;
            --glow-orange: rgba(255, 87, 34, 0.4);
        }

        body { 
            margin: 0; 
            /* Background Image එක මෙතනින් හරිගැස්සුවා */
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.8)), 
                        url('/images/payment-bg.jpg'); 
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
            backdrop-filter: blur(10px); /* පින්තූරය පිටුපසින් පේන ගතිය */
            padding: 40px; 
            border-radius: 15px; 
            width: 450px; 
            border: 1px solid rgba(255, 255, 255, 0.1); 
            box-shadow: 0 20px 50px rgba(0,0,0,0.6);
            position: relative;
            overflow: hidden;
        }

        .card::before {
            content: "";
            position: absolute;
            top: 0; left: 0; width: 100%; height: 3px;
            background: var(--brand-orange);
            box-shadow: 0 0 15px var(--brand-orange);
        }

        h2 { 
            color: white; 
            text-align: center; 
            font-family: 'Oswald', sans-serif;
            font-size: 2rem;
            letter-spacing: 3px; 
            margin-bottom: 5px; 
            text-transform: uppercase;
        }
        
        h2 span { color: var(--brand-orange); }

        .user-info { 
            text-align: center; 
            font-size: 12px; 
            color: var(--text-gray); 
            margin-bottom: 25px; 
            background: rgba(255,255,255,0.05);
            padding: 12px;
            border-radius: 8px;
        }

        label { 
            font-size: 11px; 
            color: var(--brand-orange); 
            font-weight: bold; 
            display: block; 
            margin-top: 15px; 
            text-transform: uppercase; 
            letter-spacing: 1px;
        }

        select, input { 
            width: 100%; 
            padding: 12px; 
            background: rgba(0,0,0,0.6); 
            border: 1px solid #444; 
            color: white; 
            border-radius: 5px; 
            margin-top: 5px; 
            box-sizing: border-box; 
            outline: none; 
            transition: 0.3s;
        }

        select:focus, input:focus { 
            border-color: var(--brand-orange); 
            box-shadow: 0 0 10px var(--glow-orange);
            background: #000;
        }

        .method-box { 
            background: rgba(0, 0, 0, 0.4); 
            padding: 15px; 
            border-radius: 8px; 
            margin-top: 15px; 
            border-left: 4px solid var(--brand-orange); 
        }

        .total-box { 
            background: rgba(255, 87, 34, 0.1); 
            padding: 20px; 
            text-align: center; 
            margin-top: 25px; 
            border-radius: 10px; 
            border: 1px dashed var(--brand-orange); 
        }

        .btn { 
            width: 100%; 
            padding: 15px; 
            background: var(--brand-orange); 
            border: none; 
            color: white; 
            font-family: 'Oswald', sans-serif;
            font-size: 1.1rem;
            font-weight: bold; 
            margin-top: 25px; 
            cursor: pointer; 
            border-radius: 5px; 
            transition: 0.4s; 
            text-transform: uppercase;
        }

        .btn:hover { 
            background: #e64a19; 
            box-shadow: 0 0 20px var(--glow-orange);
            transform: translateY(-2px); 
        }

        .plan-badge { 
            background: var(--brand-orange); 
            color: white; 
            padding: 2px 12px; 
            border-radius: 20px; 
            font-weight: bold; 
            text-transform: uppercase;
        }
    </style>
</head>
<body>
    <div class="card">
        <h2>SECURE <span>PAYMENT</span></h2>
        <div class="user-info">
            <i class="fas fa-user-circle"></i> User: <b>${userName}</b> | ID: <b>${userId}</b><br>
            <div style="margin-top: 8px;">
                Selected Plan: <span class="plan-badge">${selectedPlan}</span>
            </div>
        </div>

        <form action="/addPayment" method="post">
            <input type="hidden" name="name" value="${userName}">
            <input type="hidden" name="plan" value="${selectedPlan}">
            
            <label><i class="fas fa-clock"></i> Membership Duration</label>
            <select name="duration" id="duration" onchange="calculate()">
                <option value="1">1 Month (Regular)</option>
                <option value="3">3 Months (5% OFF)</option>
                <option value="6">6 Months (10% OFF)</option>
                <option value="12">12 Months (20% OFF)</option>
            </select>

            <label><i class="fas fa-credit-card"></i> Payment Method</label>
            <select name="paymentMethod" id="method" onchange="toggleFields()">
                <option value="Card">Credit / Debit Card</option>
                <option value="Online">Online Transfer</option>
            </select>

            <div id="cardFields" class="method-box">
                <input type="text" placeholder="Card Number (16 Digits)">
                <div style="display: flex; gap: 10px; margin-top: 10px;">
                    <input type="text" placeholder="MM/YY">
                    <input type="password" placeholder="CVV">
                </div>
            </div>

            <div id="onlineFields" class="method-box" style="display:none;">
                <p style="font-size: 11px; margin: 0 0 10px 0; color: var(--text-gray);">
                    Official Account: <b style="color: white;">BOC - 123456789</b>
                </p>
                <label style="color: #777;">Upload Receipt</label>
                <input type="file" style="font-size: 10px; border: none; background: none; padding: 0;">
            </div>

            <div class="total-box">
                <span style="font-size: 10px; color: var(--text-gray); letter-spacing: 2px;">TOTAL AMOUNT DUE</span><br>
                <span style="font-size: 28px; font-weight: bold; color: white;">Rs. <span id="displayAmount">0</span></span>
                <input type="hidden" name="amount" id="finalAmount">
            </div>

            <button type="submit" class="btn">Confirm & Pay Now</button>
        </form>
    </div>

    <script>
        function calculate() {
            const prices = {"Bronze": 5000, "Silver": 8000, "Gold": 12000};
            const discounts = {"1": 0, "3": 0.05, "6": 0.10, "12": 0.20};
            
            let plan = "${selectedPlan}";
            let duration = document.getElementById("duration").value;
            
            let basePrice = prices[plan] * duration;
            let discountAmount = basePrice * discounts[duration];
            let finalPrice = basePrice - discountAmount;

            document.getElementById("displayAmount").innerText = finalPrice.toLocaleString();
            document.getElementById("finalAmount").value = finalPrice;
        }

        function toggleFields() {
            let method = document.getElementById("method").value;
            document.getElementById("cardFields").style.display = (method === 'Card') ? 'block' : 'none';
            document.getElementById("onlineFields").style.display = (method === 'Online') ? 'block' : 'none';
        }

        window.onload = calculate;
    </script>
</body>
</html>