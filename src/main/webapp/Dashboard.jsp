<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*" %>
<%@ page import="main.Member, main.Filehandler, main.GymLogic" %>
<%-- Importing all classes from the main package --%>
<%@ page import="main.*" %>

<%
    // --- 1. SET UP FILE PATH ---
    String path = application.getRealPath("/") + "../../members.txt";
    Filehandler fh = new Filehandler(path);

    // --- 2. HANDLE "ADD MEMBER" ACTION (POST) ---
    String action = request.getParameter("action");
    if ("add".equals(action)) {
        try {
            String id = request.getParameter("m-id");
            String name = request.getParameter("m-name");
            String ageStr = request.getParameter("m-age");
            String contact = request.getParameter("m-contact");
            String type = request.getParameter("m-type");
            String renewal = request.getParameter("m-renewal");

            if (id != null && name != null && ageStr != null) {
                int age = Integer.parseInt(ageStr);
                Member newMember = new Member(id, name, age, contact, type, renewal);
                fh.addMember(newMember);
                
                response.sendRedirect("Dashboard.jsp"); // Refresh to clear form
                return;
            }
        } catch (Exception e) {
            out.println("<script>alert('Error: " + e.getMessage() + "');</script> ");
        }
    }

    // --- 3. LOAD & SORT MEMBERS ---
    List<Member> memberList = fh.readMembersToList();
    if (memberList == null) {
        memberList = new ArrayList<>(); // Prevent NullPointerException
    } else {
        try {
            GymLogic.insertionSort(memberList);
        } catch (Exception e) {
            // Sort failing won't crash the whole page
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Elite Gym | Professional Dashboard</title>
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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            background-color: var(--dark-bg);
            color: white;
            overflow-x: hidden;
        }

        header {
            background: #000;
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid var(--brand-orange);
        }

        .logo { font-size: 1.5rem; font-weight: bold; color: white; }
        .logo span { color: var(--brand-orange); }

        nav ul { display: flex; list-style: none; gap: 20px; margin: 0; align-items: center; }
        nav ul li { text-transform: uppercase; font-size: 0.9rem; cursor: pointer; transition: 0.3s; }
        nav ul li:hover { color: var(--brand-orange); }
        
        /* Nav button style */
        .nav-action-btn {
            background: var(--brand-orange);
            color: white;
            padding: 8px 15px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            font-size: 0.85rem;
            transition: 0.3s;
            display: inline-block;
        }
        .nav-action-btn:hover {
            background: #e64a19;
            box-shadow: 0 0 10px var(--glow-orange);
        }

        .hero {
            position: relative;
            padding: 60px 50px;
            background: linear-gradient(to right, rgba(0,0,0,0.8), rgba(0,0,0,0.4)), url('https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            min-height: 30vh;
            display: flex;
            align-items: center;
        }

        .hero-content h1 { font-size: 3rem; text-transform: uppercase; margin: 10px 0; }
        
        .management-panel {
            background: #1a1a1a;
            padding: 30px;
            margin: 20px 50px;
            border-radius: 10px;
            border-left: 5px solid var(--brand-orange);
        }

        .member-inputs input, .member-inputs select {
            padding: 10px;
            margin: 5px;
            background: #222;
            border: 1px solid #444;
            color: white;
            border-radius: 4px;
        }

        .action-btn {
            background: var(--brand-orange);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { text-align: left; color: var(--brand-orange); border-bottom: 2px solid #333; padding: 10px; }
        td { padding: 12px; border-bottom: 1px solid #222; }
    </style>
</head>
<body>

    <header>
        <div class="logo">ELITE<span>GYM</span></div>
        <nav>
            <ul>
                <li onclick="window.location.href='Dashboard.jsp'">Home</li>
                <li onclick="window.location.href='Dashboard.jsp'">Dashboard</li>
                
                <li><a href="user.jsp" class="nav-action-btn"><i class="fas fa-calendar-alt"></i> SCHEDULE</a></li>
                <li><a href="memberdiet.jsp" class="nav-action-btn"><i class="fas fa-utensils"></i> MEMBER DIET</a></li>
                <li><a href="plan-selection.jsp" class="nav-action-btn"><i class="fas fa-credit-card"></i> PAYMENT</a></li>
                
                <!-- Feedback Button Added Here -->
                <li><a href="Feedback.jsp" class="nav-action-btn"><i class="fas fa-comment-dots"></i> FEEDBACK</a></li>
                
                <li>Contact</li>
            </ul>
        </nav>
    </header>

    <section class="hero">
        <div class="hero-content">
            <h1>Member Command Center</h1>
            <p>Managing high-performance athletes in real-time.</p>
        </div>
    </section>

    <main>
        <div class="management-panel">
            <h3><i class="fas fa-user-plus"></i> Register New Member</h3>
            <form action="Dashboard.jsp" method="POST">
                <input type="hidden" name="action" value="add">
                <div class="member-inputs">
                    <input type="text" name="m-id" placeholder="ID (e.g. M001)" required>
                    <input type="text" name="m-name" placeholder="Full Name" required>
                    <input type="number" name="m-age" placeholder="Age" required>
                    <input type="text" name="m-contact" placeholder="Contact">
                    <select name="m-type">
                        <option value="Basic">Basic Plan</option>
                        <option value="Premium">Premium Plan</option>
                    </select>
                    <input type="date" name="m-renewal" required>
                    <button type="submit" class="action-btn">SAVE MEMBER</button>
                </div>
            </form>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>NAME</th>
                        <th>PLAN</th>
                        <th>RENEWAL</th>
                        <th>ACTION</th>
                    </tr>
                </thead>
                <tbody>
                    <% for(Member m : memberList) { %>
                    <tr>
                        <td>#<%= m.getMemberId() %></td>
                        <td><%= m.getName() %></td>
                        <td><%= m.getMembershipType() %></td>
                        <td><%= m.getRenewalDate() %></td>
                        <td><button class="action-btn" style="padding:5px 10px; font-size:12px;">Queue</button></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </main>

</body>
</html>