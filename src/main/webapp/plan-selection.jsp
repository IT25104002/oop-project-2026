<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>FitNase | Select Your Plan</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&family=Oswald:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --brand-orange: #ff5722;
            --dark-bg: #0f0f0f;
            --card-bg: #1a1a1a;
            --text-gray: #bbbbbb;
            --glow-orange: rgba(255, 87, 34, 0.4);
        }

        body { 
            background-color: var(--dark-bg); 
            color: white; 
            font-family: 'Poppins', sans-serif; 
            margin: 0; 
            display: flex; 
            flex-direction: column; 
            align-items: center; 
            justify-content: center; 
            min-height: 100vh; 
            overflow-x: hidden;
        }

        .header { 
            margin-bottom: 50px; 
            text-align: center; 
        }

        .header h1 { 
            font-family: 'Oswald', sans-serif;
            color: white; 
            font-size: 3rem;
            letter-spacing: 5px; 
            margin: 0;
            text-transform: uppercase;
        }
        
        .header h1 span { color: var(--brand-orange); }

        .header p { 
            color: var(--text-gray); 
            letter-spacing: 2px; 
            font-size: 0.9rem;
            margin-top: 10px;
            text-transform: uppercase;
        }

        .container { 
            display: flex; 
            gap: 30px; 
            flex-wrap: wrap; 
            justify-content: center; 
            max-width: 1100px;
        }

        .plan-card {
            background: linear-gradient(145deg, #1a1a1a, #111111);
            border: 1px solid #333; 
            padding: 40px 30px; 
            border-radius: 15px;
            width: 280px; 
            text-align: center; 
            transition: 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275); 
            position: relative;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }

        /* Hover Effect */
        .plan-card:hover { 
            border-color: var(--brand-orange); 
            transform: translateY(-15px); 
            box-shadow: 0 15px 40px var(--glow-orange);
        }

        .plan-card i { 
            font-size: 45px; 
            color: var(--brand-orange); 
            margin-bottom: 20px; 
        }

        .plan-card h3 {
            font-family: 'Oswald', sans-serif;
            font-size: 1.8rem;
            margin: 10px 0;
            letter-spacing: 2px;
        }

        .price { 
            font-family: 'Oswald', sans-serif;
            font-size: 28px; 
            font-weight: bold; 
            color: white;
            margin: 15px 0; 
        }

        .features { 
            font-size: 13px; 
            color: var(--text-gray); 
            margin-bottom: 35px; 
            list-style: none; 
            padding: 0; 
            line-height: 2;
        }

        .features li::before {
            content: "✓ ";
            color: var(--brand-orange);
            font-weight: bold;
        }

        .btn { 
            display: block;
            background: transparent; 
            color: white; 
            padding: 12px 20px; 
            border-radius: 5px; 
            border: 1px solid var(--brand-orange);
            text-decoration: none; 
            font-weight: bold; 
            font-family: 'Oswald', sans-serif;
            font-size: 14px; 
            letter-spacing: 1px;
            transition: 0.3s;
            text-transform: uppercase;
        }

        .btn:hover { 
            background: var(--brand-orange); 
            box-shadow: 0 0 15px var(--brand-orange);
            color: white;
        }

        /* Popular Badge for Silver */
        .popular-badge {
            position: absolute;
            top: -15px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--brand-orange);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 10px;
            font-weight: bold;
            letter-spacing: 1px;
            box-shadow: 0 5px 10px rgba(0,0,0,0.3);
        }
    </style>
</head>
<body>

    <div class="header">
        <h1>CHOOSE YOUR <span>GOAL</span></h1>
        <p>Elite Memberships for High Performance</p>
    </div>

    <div class="container">
        <div class="plan-card">
            <i class="fas fa-dumbbell"></i>
            <h3>BRONZE</h3>
            <div class="price">Rs. 5,000</div>
            <ul class="features">
                <li>Gym Access Only</li>
                <li>Locker Facilities</li>
                <li>Standard Support</li>
            </ul>
            <!-- Href changed to payment-form.jsp -->
            <a href="payment-form.jsp?plan=Bronze" class="btn">Select Bronze</a>
        </div>

        <div class="plan-card" style="border-color: rgba(255, 87, 34, 0.5);">
            <div class="popular-badge">MOST POPULAR</div>
            <i class="fas fa-utensils"></i>
            <h3>SILVER</h3>
            <div class="price">Rs. 8,000</div>
            <ul class="features">
                <li>Gym Access + Cardio</li>
                <li>Personal Meal Plan</li>
                <li>Weekly Progress Check</li>
            </ul>
            <!-- Href changed to payment-form.jsp -->
            <a href="payment-form.jsp?plan=Silver" class="btn">Select Silver</a>
        </div>

        <div class="plan-card">
            <i class="fas fa-crown"></i>
            <h3>GOLD</h3>
            <div class="price">Rs. 12,000</div>
            <ul class="features">
                <li>Personal Elite Coach</li>
                <li>All Facilities Included</li>
                <li>Customized Nutrition</li>
            </ul>
            <!-- Href changed to payment-form.jsp -->
            <a href="payment-form.jsp?plan=Gold" class="btn">Select Gold</a>
        </div>
    </div>

    <p style="margin-top: 50px; color: #444; font-size: 11px; letter-spacing: 2px;">FITNASE COMMAND CENTER © 2026</p>

</body>
</html>