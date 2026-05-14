<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="main.DietPlan, java.util.*" %>

<%
    List<DietPlan> plans = (List<DietPlan>) request.getAttribute("plans");
    DietPlan plan = (DietPlan) request.getAttribute("plan");
    String action = (String) request.getAttribute("action");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>FitNase | My Diet Plan</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
    --brand-orange: #ff5722;
    --dark-bg: #0f0f0f;
    --card-bg: #1a1a1a;
    --text-gray: #bbbbbb;
    --glow-orange: rgba(255, 87, 34, 0.4);
}

* { box-sizing: border-box; margin: 0; padding: 0; }

body {
    font-family: 'Oswald', Arial, sans-serif;
    background: var(--dark-bg);
    color: white;
}

/* HEADER */
header {
    background: #000;
    padding: 20px 50px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 2px solid var(--brand-orange);
}
.logo { font-size: 1.5rem; font-weight: bold; }
.logo span { color: var(--brand-orange); }

/* HERO */
.hero {
    padding: 80px 50px;
    background: linear-gradient(to right, rgba(0,0,0,0.9), rgba(0,0,0,0.3)),
                url('https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=1350&q=80');
    background-size: cover;
    background-position: center;
    min-height: 35vh;
    display: flex;
    align-items: center;
}
.hero h4 { color: var(--brand-orange); letter-spacing: 3px; font-size: 0.9rem; }
.hero h1 { font-size: 3rem; text-transform: uppercase; margin: 8px 0; line-height: 1.1; }
.hero p  { color: var(--text-gray); margin-top: 8px; }

/* MAIN */
.container { padding: 50px; max-width: 900px; margin: 0 auto; }

/* PANEL */
@keyframes borderFlow {
    0%   { border-color: #333; }
    50%  { border-color: var(--brand-orange); }
    100% { border-color: #333; }
}
.panel {
    background: linear-gradient(145deg, #1a1a1a, #111);
    padding: 35px;
    border-radius: 12px;
    margin-bottom: 30px;
    border: 1px solid #333;
    animation: borderFlow 4s infinite ease-in-out;
    box-shadow: 0 20px 50px rgba(0,0,0,0.4);
}
.panel-title {
    color: var(--brand-orange);
    letter-spacing: 2px;
    margin-bottom: 25px;
    font-size: 1rem;
    text-transform: uppercase;
}

/* FORM */
.form-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
    margin-bottom: 25px;
}
.form-group label {
    display: block;
    font-size: 0.75rem;
    letter-spacing: 1px;
    color: var(--text-gray);
    margin-bottom: 6px;
    text-transform: uppercase;
}
.form-group select {
    width: 100%;
    padding: 12px;
    background: rgba(0,0,0,0.5);
    border: 1px solid #444;
    color: white;
    border-radius: 4px;
    font-size: 0.9rem;
    transition: all 0.3s;
}
.form-group select:focus {
    outline: none;
    border-color: var(--brand-orange);
    box-shadow: 0 0 12px var(--glow-orange);
}
.form-group select option { background: #1a1a1a; }

/* BUTTONS */
.btn-orange {
    background: var(--brand-orange);
    color: white;
    padding: 14px 40px;
    border: none;
    text-transform: uppercase;
    font-weight: bold;
    cursor: pointer;
    border-radius: 4px;
    font-size: 0.95rem;
    transition: 0.3s;
    text-decoration: none;
    display: inline-block;
    width: 100%;
    text-align: center;
}
.btn-orange:hover { box-shadow: 0 0 20px var(--glow-orange); transform: scale(1.02); }

/* PLAN RESULT */
.plan-result {
    background: rgba(255,87,34,0.05);
    border-left: 4px solid var(--brand-orange);
    border-radius: 8px;
    padding: 25px;
    white-space: pre-line;
    font-size: 0.95rem;
    color: var(--text-gray);
    line-height: 2;
}

.plan-header {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 15px;
    margin-bottom: 20px;
}
.plan-stat {
    background: rgba(0,0,0,0.3);
    border: 1px solid #333;
    border-radius: 8px;
    padding: 15px;
    text-align: center;
}
.plan-stat i { font-size: 1.5rem; color: var(--brand-orange); margin-bottom: 8px; display: block; }
.plan-stat label { font-size: 0.7rem; color: var(--text-gray); letter-spacing: 1px; text-transform: uppercase; display: block; }
.plan-stat p { font-size: 0.95rem; color: white; margin-top: 4px; }

/* WATER INFO */
.water-card {
    background: rgba(30,144,255,0.1);
    border: 1px solid #1e90ff;
    border-radius: 8px;
    padding: 15px 20px;
    display: flex;
    align-items: center;
    gap: 15px;
    margin-bottom: 20px;
}
.water-card i { font-size: 2rem; color: #1e90ff; }
.water-card h4 { color: #1e90ff; font-size: 0.85rem; letter-spacing: 1px; }
.water-card p { color: white; font-size: 1.2rem; font-weight: bold; }

/* MY PLANS TABLE */
.my-plan-card {
    background: rgba(0,0,0,0.2);
    border: 1px solid #333;
    border-radius: 8px;
    padding: 20px;
    margin-bottom: 15px;
    transition: 0.3s;
}
.my-plan-card:hover { border-color: var(--brand-orange); }
.my-plan-card h4 { color: var(--brand-orange); margin-bottom: 8px; font-size: 0.9rem; }
.my-plan-card p { color: var(--text-gray); font-size: 0.85rem; margin: 3px 0; }

.badge {
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 0.72rem;
    text-transform: uppercase;
}
.badge-veg    { background: rgba(40,167,69,0.2); color: #28a745; border: 1px solid #28a745; }
.badge-nonveg { background: rgba(255,87,34,0.2); color: var(--brand-orange); border: 1px solid var(--brand-orange); }

.action-btn {
    background: transparent;
    border: 1px solid var(--brand-orange);
    color: white;
    padding: 6px 14px;
    border-radius: 20px;
    cursor: pointer;
    font-size: 0.75rem;
    transition: 0.3s;
    text-decoration: none;
    display: inline-block;
    margin-top: 10px;
}
.action-btn:hover { background: var(--brand-orange); }

.empty-state { text-align: center; padding: 40px; color: var(--text-gray); }
.empty-state i { font-size: 2.5rem; color: #333; display: block; margin-bottom: 12px; }
</style>
</head>
<body>

<!-- HEADER -->
<header>
    <div class="logo">FIT<span>NASE</span></div>
    <div style="color:var(--text-gray); font-size:0.9rem; text-transform:uppercase; letter-spacing:2px;">
        <i class="fas fa-user-circle" style="color:var(--brand-orange)"></i> &nbsp; Member Portal
    </div>
</header>

<!-- HERO -->
<section class="hero">
    <div>
        <h4><i class="fas fa-leaf"></i> &nbsp; PERSONALISED NUTRITION — 2026</h4>
        <h1>Your Diet<br>Plan</h1>
        <p>Get a customised meal plan based on your health preferences</p>
    </div>
</section>

<div class="container">

<!-- ===== VIEW MY PLAN ===== -->
<% if ("view".equals(action) && plan != null) { %>
<div class="panel">
    <h3 class="panel-title"><i class="fas fa-clipboard-check"></i> &nbsp; Your Personalised Plan</h3>

    <div class="plan-header">
        <div class="plan-stat">
            <i class="fas fa-leaf"></i>
            <label>Diet Type</label>
            <p><%= plan.getDietType() %></p>
        </div>
        <div class="plan-stat">
            <i class="fas fa-bullseye"></i>
            <label>Fitness Goal</label>
            <p><%= plan.getFitnessGoal() %></p>
        </div>
        <div class="plan-stat">
            <i class="fas fa-heartbeat"></i>
            <label>Medical Condition</label>
            <p><%= plan.getMedicalCondition() %></p>
        </div>
        <div class="plan-stat">
            <i class="fas fa-calendar"></i>
            <label>Created</label>
            <p><%= plan.getCreatedDate() %></p>
        </div>
    </div>

    <div class="water-card">
        <i class="fas fa-tint"></i>
        <div>
            <h4>DAILY WATER INTAKE RECOMMENDATION</h4>
            <p><%= plan.getWaterIntake() %> litres per day</p>
        </div>
    </div>

    <h4 style="color:var(--brand-orange); letter-spacing:1px; font-size:0.85rem; text-transform:uppercase; margin-bottom:12px;">
        <i class="fas fa-utensils"></i> &nbsp; Your Meal Plan
    </h4>
    <div class="plan-result"><%= plan.getPlanDetails() %></div>
    <br>
    <a href="dietplan?action=list" class="btn-orange">
        <i class="fas fa-arrow-left"></i> &nbsp; Back
    </a>
</div>

<% } else { %>

<!-- ===== CREATE PLAN FORM ===== -->
<div class="panel">
    <h3 class="panel-title"><i class="fas fa-plus-circle"></i> &nbsp; Get Your Diet Plan</h3>
    <p style="color:var(--text-gray); margin-bottom:25px; font-size:0.9rem;">
        Fill in your preferences below and we'll generate a personalised meal plan for you.
    </p>
    <form action="dietplan" method="post">
        <input type="hidden" name="action" value="create"/>
        <div class="form-grid">
            <div class="form-group">
                <label><i class="fas fa-leaf"></i> Diet Type</label>
                <select name="dietType" required>
                    <option value="" disabled selected>Select your diet</option>
                    <option value="vegetarian">🥦 Vegetarian</option>
                    <option value="non-vegetarian">🍗 Non-Vegetarian</option>
                </select>
            </div>
            <div class="form-group">
                <label><i class="fas fa-bullseye"></i> Fitness Goal</label>
                <select name="fitnessGoal" required>
                    <option value="" disabled selected>Select your goal</option>
                    <option value="weight loss">⬇ Weight Loss</option>
                    <option value="weight gain">⬆ Weight Gain</option>
                    <option value="maintain">↔ Maintain Weight</option>
                </select>
            </div>
            <div class="form-group">
                <label><i class="fas fa-running"></i> Activity Level</label>
                <select name="activityLevel" required>
                    <option value="" disabled selected>Select activity</option>
                    <option value="low">🚶 Low</option>
                    <option value="medium">🏃 Medium</option>
                    <option value="high">⚡ High</option>
                </select>
            </div>
            <div class="form-group">
                <label><i class="fas fa-heartbeat"></i> Medical Condition</label>
                <select name="medicalCondition" required>
                    <option value="" disabled selected>Do you have any?</option>
                    <option value="YES">Yes, I have a medical condition</option>
                    <option value="NO">No medical conditions</option>
                </select>
            </div>
        </div>
        <button type="submit" class="btn-orange">
            <i class="fas fa-magic"></i> &nbsp; Generate My Diet Plan
        </button>
    </form>
</div>

<!-- ===== MY PREVIOUS PLANS ===== -->
<div class="panel">
    <h3 class="panel-title"><i class="fas fa-history"></i> &nbsp; My Previous Plans</h3>

    <% if (plans == null || plans.isEmpty()) { %>
    <div class="empty-state">
        <i class="fas fa-inbox"></i>
        <p>No plans yet. Create your first plan above!</p>
    </div>
    <% } else { %>
        <% for (DietPlan dp : plans) { %>
        <div class="my-plan-card">
            <h4>
                Plan #<%= dp.getPlanId() %> &nbsp;
                <span class="badge <%= "vegetarian".equalsIgnoreCase(dp.getDietType()) ? "badge-veg" : "badge-nonveg" %>">
                    <%= dp.getDietType() %>
                </span>
            </h4>
            <p><i class="fas fa-bullseye" style="color:var(--brand-orange)"></i> Goal: <%= dp.getFitnessGoal() %></p>
            <p><i class="fas fa-calendar" style="color:var(--brand-orange)"></i> Created: <%= dp.getCreatedDate() %></p>
            <p><i class="fas fa-tint" style="color:#1e90ff"></i> Water: <%= dp.getWaterIntake() %> litres/day</p>
            <a href="
            dietplan?action=view&id=<%= dp.getPlanId() %>" class="action-btn">
                <i class="fas fa-eye"></i> View Full Plan
            </a>
        </div>
        <% } %>
    <% } %>
</div>

<% } %>

</div><!-- /container -->
</body>
</html>
