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
<title>FitNase | Diet Plan Management</title>
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
body { font-family: 'Oswald', Arial, sans-serif; background: var(--dark-bg); color: white; }

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
nav ul { display: flex; list-style: none; gap: 30px; }
nav ul li { text-transform: uppercase; font-size: 0.9rem; cursor: pointer; transition: 0.3s; }
nav ul li:hover, nav ul li.active { color: var(--brand-orange); }

/* HERO */
.hero {
    padding: 80px 50px;
    background: linear-gradient(to right, rgba(0,0,0,0.9), rgba(0,0,0,0.3)),
                url('https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&w=1350&q=80');
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
.container { padding: 50px; }

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
    margin-bottom: 20px;
}
.form-group label {
    display: block;
    font-size: 0.75rem;
    letter-spacing: 1px;
    color: var(--text-gray);
    margin-bottom: 6px;
    text-transform: uppercase;
}
.form-group input,
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
.form-group input:focus,
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
    padding: 12px 30px;
    border: none;
    text-transform: uppercase;
    font-weight: bold;
    cursor: pointer;
    border-radius: 4px;
    font-size: 0.9rem;
    transition: 0.3s;
    text-decoration: none;
    display: inline-block;
}
.btn-orange:hover { box-shadow: 0 0 20px var(--glow-orange); transform: scale(1.05); }
.btn-secondary {
    background: transparent;
    color: white;
    padding: 12px 30px;
    border: 1px solid #555;
    text-transform: uppercase;
    font-weight: bold;
    cursor: pointer;
    border-radius: 4px;
    font-size: 0.9rem;
    transition: 0.3s;
    text-decoration: none;
    display: inline-block;
    margin-left: 10px;
}
.btn-secondary:hover { border-color: white; }

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
    margin: 2px;
}
.action-btn:hover { background: var(--brand-orange); box-shadow: 0 0 12px var(--brand-orange); }
.action-btn.danger { border-color: #dc3545; }
.action-btn.danger:hover { background: #dc3545; box-shadow: 0 0 12px #dc3545; }
.action-btn.edit { border-color: #ffc107; color: #ffc107; }
.action-btn.edit:hover { background: #ffc107; color: #000; box-shadow: 0 0 12px #ffc107; }

/* TABLE */
table { width: 100%; border-collapse: collapse; margin-top: 15px; }
th {
    text-align: left;
    color: var(--brand-orange);
    padding: 10px;
    font-size: 0.8rem;
    letter-spacing: 1px;
    text-transform: uppercase;
}
td { padding: 12px 10px; border-top: 1px solid #222; font-size: 0.9rem; }
@keyframes rowReveal {
    from { opacity: 0; transform: translateY(10px); }
    to   { opacity: 1; transform: translateY(0); }
}
.table-row { animation: rowReveal 0.4s ease forwards; }
.table-row:hover td { background: rgba(255,87,34,0.05); }

/* BADGES */
.badge {
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 0.72rem;
    text-transform: uppercase;
    letter-spacing: 1px;
}
.badge-veg    { background: rgba(40,167,69,0.2); color: #28a745; border: 1px solid #28a745; }
.badge-nonveg { background: rgba(255,87,34,0.2); color: var(--brand-orange); border: 1px solid var(--brand-orange); }
.badge-yes    { background: rgba(220,53,69,0.2); color: #dc3545; border: 1px solid #dc3545; }
.badge-no     { background: rgba(40,167,69,0.2); color: #28a745; border: 1px solid #28a745; }

/* PLAN VIEW BOX */
.plan-box {
    background: rgba(255,87,34,0.05);
    border-left: 4px solid var(--brand-orange);
    border-radius: 6px;
    padding: 20px;
    white-space: pre-line;
    font-size: 0.9rem;
    color: var(--text-gray);
    line-height: 1.8;
    margin-top: 15px;
}
.detail-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 20px;
    margin-bottom: 20px;
}
.detail-item label {
    display: block;
    font-size: 0.72rem;
    color: var(--brand-orange);
    letter-spacing: 1px;
    text-transform: uppercase;
    margin-bottom: 4px;
}
.detail-item p { font-size: 0.95rem; }

/* SEARCH */
#search {
    float: right;
    padding: 10px 15px;
    background: rgba(0,0,0,0.5);
    border: 1px solid #444;
    color: white;
    border-radius: 4px;
    width: 220px;
    transition: 0.3s;
    font-size: 0.85rem;
}
#search:focus { outline: none; border-color: var(--brand-orange); }

/* EMPTY STATE */
.empty-state { text-align: center; padding: 50px; color: var(--text-gray); }
.empty-state i { font-size: 3rem; color: #333; display: block; margin-bottom: 15px; }

/* WATER BADGE */
.water-info {
    display: inline-block;
    background: rgba(30,144,255,0.15);
    border: 1px solid #1e90ff;
    color: #1e90ff;
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 0.78rem;
}

/* EDIT FORM NOTE */
.edit-note {
    background: rgba(255,193,7,0.1);
    border-left: 4px solid #ffc107;
    padding: 12px 15px;
    border-radius: 4px;
    color: #ffc107;
    font-size: 0.85rem;
    margin-bottom: 20px;
}
</style>
</head>
<body>

<!-- HEADER -->
<header>
    <div class="logo">FIT<span>NASE</span></div>
    <nav>
        <ul>
            <li>Home</li>
            <li>Members</li>
            <li>Training</li>
            <li class="active">Diet Plans</li>
            <li>Contact</li>
        </ul>
    </nav>
</header>

<!-- HERO -->
<section class="hero">
    <div>
        <h4><i class="fas fa-shield-alt"></i> &nbsp; ADMIN PANEL — 2026</h4>
        <h1>Diet Plan<br>Management</h1>
        <p>View, assign and manage nutrition plans for all registered members</p>
    </div>
</section>

<div class="container">

<!-- ===== EDIT PLAN FORM ===== -->
<% if ("edit".equals(action) && plan != null) { %>
<div class="panel">
    <h3 class="panel-title"><i class="fas fa-edit"></i> &nbsp; Edit Diet Plan — #<%= plan.getPlanId() %></h3>
    <div class="edit-note">
        <i class="fas fa-info-circle"></i> &nbsp;
        Editing plan for <strong><%= plan.getMemberName() %></strong> (Member ID: <%= plan.getMemberId() %>).
        The meal plan will be auto-regenerated based on updated details.
    </div>
    <form action="dietplan" method="post">
        <input type="hidden" name="action" value="update"/>
        <input type="hidden" name="planId" value="<%= plan.getPlanId() %>"/>
        <input type="hidden" name="memberId" value="<%= plan.getMemberId() %>"/>
        <input type="hidden" name="memberName" value="<%= plan.getMemberName() %>"/>
        <input type="hidden" name="createdDate" value="<%= plan.getCreatedDate() %>"/>
        <input type="hidden" name="test" value="admin"/>

        <div class="form-grid">
            <div class="form-group">
                <label><i class="fas fa-leaf"></i> Diet Type</label>
                <select name="dietType" required>
                    <option value="vegetarian" <%= "vegetarian".equalsIgnoreCase(plan.getDietType()) ? "selected" : "" %>>🥦 Vegetarian</option>
                    <option value="non-vegetarian" <%= "non-vegetarian".equalsIgnoreCase(plan.getDietType()) ? "selected" : "" %>>🍗 Non-Vegetarian</option>
                </select>
            </div>
            <div class="form-group">
                <label><i class="fas fa-bullseye"></i> Fitness Goal</label>
                <select name="fitnessGoal" required>
                    <option value="weight loss" <%= "weight loss".equalsIgnoreCase(plan.getFitnessGoal()) ? "selected" : "" %>>⬇ Weight Loss</option>
                    <option value="weight gain" <%= "weight gain".equalsIgnoreCase(plan.getFitnessGoal()) ? "selected" : "" %>>⬆ Weight Gain</option>
                    <option value="maintain" <%= "maintain".equalsIgnoreCase(plan.getFitnessGoal()) ? "selected" : "" %>>↔ Maintain Weight</option>
                </select>
            </div>
            <div class="form-group">
                <label><i class="fas fa-running"></i> Activity Level</label>
                <select name="activityLevel" required>
                    <option value="low">🚶 Low</option>
                    <option value="medium" selected>🏃 Medium</option>
                    <option value="high">⚡ High</option>
                </select>
            </div>
            <div class="form-group">
                <label><i class="fas fa-heartbeat"></i> Medical Condition</label>
                <select name="medicalCondition" required>
                    <option value="YES" <%= "YES".equalsIgnoreCase(plan.getMedicalCondition()) ? "selected" : "" %>>Yes, I have a medical condition</option>
                    <option value="NO" <%= "NO".equalsIgnoreCase(plan.getMedicalCondition()) ? "selected" : "" %>>No medical conditions</option>
                </select>
            </div>
        </div>
        <button type="submit" class="btn-orange">
            <i class="fas fa-save"></i> &nbsp; Update Diet Plan
        </button>
        <a href="dietplan?action=list&test=admin" class="btn-secondary">
            <i class="fas fa-times"></i> &nbsp; Cancel
        </a>
    </form>
</div>
<% } %>

<!-- ===== VIEW SINGLE PLAN ===== -->
<% if ("view".equals(action) && plan != null) { %>
<div class="panel">
    <h3 class="panel-title"><i class="fas fa-clipboard-list"></i> &nbsp; Diet Plan Details</h3>
    <div class="detail-grid">
        <div class="detail-item">
            <label>Plan ID</label>
            <p>#<%= plan.getPlanId() %></p>
        </div>
        <div class="detail-item">
            <label>Member ID</label>
            <p><%= plan.getMemberId() %></p>
        </div>
        <div class="detail-item">
            <label>Member Name</label>
            <p><%= plan.getMemberName() %></p>
        </div>
        <div class="detail-item">
            <label>Diet Type</label>
            <p>
                <span class="badge <%= "vegetarian".equalsIgnoreCase(plan.getDietType()) ? "badge-veg" : "badge-nonveg" %>">
                    <%= plan.getDietType() %>
                </span>
            </p>
        </div>
        <div class="detail-item">
            <label>Fitness Goal</label>
            <p><%= plan.getFitnessGoal() %></p>
        </div>
        <div class="detail-item">
            <label>Medical Condition</label>
            <p>
                <span class="badge <%= "YES".equalsIgnoreCase(plan.getMedicalCondition()) ? "badge-yes" : "badge-no" %>">
                    <%= plan.getMedicalCondition() %>
                </span>
            </p>
        </div>
        <div class="detail-item">
            <label>Daily Water Intake</label>
            <p><span class="water-info"><i class="fas fa-tint"></i> <%= plan.getWaterIntake() %> litres/day</span></p>
        </div>
        <div class="detail-item">
            <label>Created Date</label>
            <p><%= plan.getCreatedDate() %></p>
        </div>
    </div>
    <label style="font-size:0.75rem; color:var(--brand-orange); letter-spacing:1px; text-transform:uppercase;">
        <i class="fas fa-utensils"></i> Meal Plan
    </label>
    <div class="plan-box"><%= plan.getPlanDetails() %></div>
    <br>
    <a href="dietplan?action=edit&id=<%= plan.getPlanId() %>&test=admin" class="btn-orange">
        <i class="fas fa-edit"></i> &nbsp; Edit This Plan
    </a>
    <a href="dietplan?action=list&test=admin" class="btn-secondary">
        <i class="fas fa-arrow-left"></i> &nbsp; Back to List
    </a>
</div>
<% } %>

<!-- ===== ALL PLANS TABLE ===== -->
<div class="panel">
    <h3 class="panel-title">
        <i class="fas fa-list"></i> &nbsp; All Member Diet Plans
        <input type="text" id="search" placeholder="🔍 Search by name..." onkeyup="searchPlan()"/>
    </h3>

    <% if (plans == null || plans.isEmpty()) { %>
    <div class="empty-state">
        <i class="fas fa-inbox"></i>
        <p>No diet plans found yet.</p>
    </div>
    <% } else { %>
    <table id="planTable">
        <thead>
            <tr>
                <th>Plan ID</th>
                <th>Member ID</th>
                <th>Name</th>
                <th>Diet Type</th>
                <th>Goal</th>
                <th>Medical</th>
                <th>Water</th>
                <th>Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (DietPlan dp : plans) { %>
            <tr class="table-row">
                <td><strong>#<%= dp.getPlanId() %></strong></td>
                <td><%= dp.getMemberId() %></td>
                <td style="font-weight:bold; color:white"><%= dp.getMemberName() %></td>
                <td>
                    <span class="badge <%= "vegetarian".equalsIgnoreCase(dp.getDietType()) ? "badge-veg" : "badge-nonveg" %>">
                        <%= dp.getDietType() %>
                    </span>
                </td>
                <td style="color:var(--text-gray)"><%= dp.getFitnessGoal() %></td>
                <td>
                    <span class="badge <%= "YES".equalsIgnoreCase(dp.getMedicalCondition()) ? "badge-yes" : "badge-no" %>">
                        <%= dp.getMedicalCondition() %>
                    </span>
                </td>
                <td><span class="water-info"><i class="fas fa-tint"></i> <%= dp.getWaterIntake() %>L</span></td>
                <td style="color:var(--text-gray)"><%= dp.getCreatedDate() %></td>
                <td>
                    <a href="dietplan?action=view&id=<%= dp.getPlanId() %>&test=admin" class="action-btn">
                        <i class="fas fa-eye"></i> View
                    </a>
                    <a href="dietplan?action=edit&id=<%= dp.getPlanId() %>&test=admin" class="action-btn edit">
                        <i class="fas fa-edit"></i> Edit
                    </a>
                    <a href="dietplan?action=delete&id=<%= dp.getPlanId() %>&test=admin"
                       class="action-btn danger"
                       onclick="return confirm('Delete this diet plan?')">
                        <i class="fas fa-trash"></i> Delete
                    </a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <% } %>
</div>

</div><!-- /container -->

<script>
function searchPlan() {
    let input = document.getElementById('search').value.toUpperCase();
    let table = document.getElementById('planTable');
    if (!table) return;
    let rows = table.getElementsByTagName('tr');
    for (let i = 1; i < rows.length; i++) {
        let nameCell = rows[i].getElementsByTagName('td')[2];
        if (nameCell) {
            rows[i].style.display =
                nameCell.textContent.toUpperCase().indexOf(input) > -1 ? "" : "none";
        }
    }
}
</script>

</body>
</html>