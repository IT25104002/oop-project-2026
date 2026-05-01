<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="main.Member, main.Filehandler, main.GymLogic, java.util.*, java.io.*" %>

<%
    // --- 1. SET UP FILE PATH ---
    String path = application.getRealPath("/") + "data/members.txt";
    File dataDir = new File(application.getRealPath("/") + "data");
    if (!dataDir.exists()) dataDir.mkdirs(); // Create data folder if missing
    
    Filehandler fh = new Filehandler(path);

    // --- 2. HANDLE "ADD MEMBER" ACTION (POST) ---
    String action = request.getParameter("action");
    if ("add".equals(action)) {
        try {
            String id = request.getParameter("m-id");
            String name = request.getParameter("m-name");
            int age = Integer.parseInt(request.getParameter("m-age"));
            String contact = request.getParameter("m-contact");
            String type = request.getParameter("m-type");
            String renewal = request.getParameter("m-renewal");

            Member newMember = new Member(id, name, age, contact, type, renewal);
            fh.addMember(newMember);
            
            response.sendRedirect("Dashboard.jsp"); // Refresh to clear form
            return;
        } catch (Exception e) {
            out.println("<script>alert('Error adding member: Check if Age is a number');</script>");
        }
    }

    // --- 3. LOAD & SORT MEMBERS USING GYMLOGIC ---
    List<Member> memberList = fh.readMembersToList();
    GymLogic.insertionSort(memberList);
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
            font-family: 'Oswald', sans-serif;
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

        nav ul { display: flex; list-style: none; gap: 30px; margin: 0; }
        nav ul li { text-transform: uppercase; font-size: 0.9rem; cursor: pointer; transition: 0.3s; }
        nav ul li:hover { color: var(--brand-orange); }

        .hero {
            position: relative;
            padding: 100px 50px;
            background: linear-gradient(to right, rgba(0,0,0,0.9), rgba(0,0,0,0.2)), url('https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            min-height: 60vh;
            display: flex;
            align-items: center;
        }

        .hero-content { position: relative; z-index: 2; max-width: 600px; }
        .hero-content h1 { font-size: 4rem; text-transform: uppercase; margin: 10px 0; line-height: 1; }
        
        .btn-orange {
            background: var(--brand-orange);
            color: white;
            padding: 15px 40px;
            border: none;
            text-transform: uppercase;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        .btn-orange:hover { box-shadow: 0 0 20px var(--glow-orange); transform: scale(1.05); }

        @keyframes borderFlow {
            0% { border-color: #333; }
            50% { border-color: var(--brand-orange); }
            100% { border-color: #333; }
        }

        @keyframes rowReveal {
            from { opacity: 0; transform: translateY(15px) rotateX(-10deg); }
            to { opacity: 1; transform: translateY(0) rotateX(0); }
        }

        .management-panel {
            background: linear-gradient(145deg, #1a1a1a, #111111);
            padding: 40px;
            margin: 40px 0;
            border-radius: 15px;
            border: 1px solid #333;
            animation: borderFlow 4s infinite ease-in-out;
            box-shadow: 0 20px 50px rgba(0,0,0,0.5);
        }

        .member-inputs input, .member-inputs select {
            padding: 12px;
            margin: 5px;
            background: rgba(0,0,0,0.5);
            border: 1px solid #444;
            color: white;
            border-radius: 4px;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .member-inputs input:focus {
            outline: none;
            border-color: var(--brand-orange);
            background: #000;
            box-shadow: 0 0 15px var(--glow-orange);
            transform: translateY(-2px);
        }

        .new-row {
            animation: rowReveal 0.5s ease forwards;
            background: rgba(255, 255, 255, 0.02);
        }

        .new-row:hover td {
            background: rgba(255, 87, 34, 0.1) !important;
            color: white;
            transition: 0.2s;
        }

        .action-btn {
            background: transparent;
            border: 1px solid var(--brand-orange);
            color: white;
            padding: 6px 15px;
            border-radius: 20px;
            cursor: pointer;
            transition: 0.3s;
        }

        .action-btn:hover {
            background: var(--brand-orange);
            box-shadow: 0 0 15px var(--brand-orange);
            transform: scale(1.1);
        }

        .main-container { padding: 80px 50px; }
        .grid-layout {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
        }

        .program-card {
            background: var(--card-bg);
            border-radius: 8px;
            overflow: hidden;
            transition: 0.4s ease;
        }

        .program-card:hover { transform: translateY(-10px); }
        .card-image { height: 200px; background-size: cover; background-position: center; }
        .card-content { padding: 30px; }

        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th { text-align: left; color: var(--brand-orange); padding-bottom: 10px; font-size: 0.8rem; letter-spacing: 1px; }
        td { padding: 12px 0; border-top: 1px solid #222; font-size: 0.9rem; }
    </style>
</head>
<body>

    <header>
        <div class="logo">FIT<span>NASE</span></div>
        <nav>
            <ul>
                <li>Home</li>
                <li>Registration</li>
                <li>Training Dashboard</li>
                <li>Services</li>
                <li style="color:var(--brand-orange)">Contact</li>
            </ul>
        </nav>
    </header>

    <section class="hero">
        <div class="hero-content">
            <h4>SINCE - 2026</h4>
            <h1>Elite Member<br>Management</h1>
            <p>High-performance dashboard for tracking the elite athletes of FitNase.</p>
            <button class="btn-orange">Read More</button>
        </div>
    </section>

    <main class="main-container">
        <div class="management-panel">
            <h3 style="color:var(--brand-orange); letter-spacing: 3px; margin-bottom: 25px;">
                <i class="fas fa-users-cog"></i> COMMAND CENTER
            </h3>
            
            <form action="Dashboard.jsp" method="POST">
                <input type="hidden" name="action" value="add">
                <div class="member-inputs">
                    <input type="text" name="m-id" id="m-id" placeholder="Member ID" required>
                    <input type="text" name="m-name" id="m-name" placeholder="Full Name" required>
                    <input type="number" name="m-age" id="m-age" placeholder="Age" required>
                    <input type="text" name="m-contact" id="m-contact" placeholder="Contact Number">
                    <select name="m-type" id="m-type">
                        <option value="Basic">Basic Plan</option>
                        <option value="Premium">Premium Plan</option>
                    </select>
                    <input type="date" name="m-renewal" id="m-renewal" required>
                    <br>
                    <div style="margin-top: 20px;">
                        <button type="submit" class="action-btn">+ SAVE TO DATABASE</button>
                        <button type="button" class="action-btn" style="border-color:#555" onclick="location.reload();">REFRESH & SORT</button>
                        <input type="text" id="search" placeholder="🔍 Search database..." onkeyup="searchMember()" style="float:right; width: 250px;">
                    </div>
                </div>
            </form>
            
            <table id="memberTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>NAME</th>
                        <th>PLAN TYPE</th>
                        <th>RENEWAL DATE</th>
                        <th>OPERATIONS</th>
                    </tr>
                </thead>
                <tbody id="memberBody">
                    <%
                        // LOOP THROUGH MEMBERS LOADED FROM FILEHANDER
                        for(Member m : memberList) {
                    %>
                    <tr class="new-row">
                        <td>#<%= m.getMemberId() %></td>
                        <td style="font-weight:bold"><%= m.getName() %></td>
                        <td><span style="color:var(--brand-orange)"><%= m.getMembershipType() %></span></td>
                        <td><%= m.getRenewalDate() %></td>
                        <td>
                            <button class="action-btn" style="font-size:10px" onclick="addToQueueFromData('<%= m.getMemberId() %>', '<%= m.getName() %>')">Queue</button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="grid-layout">
            <div class="program-card">
                <div class="card-image" style="background-image: url('https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&w=500&q=60');"></div>
                <div class="card-content">
                    <h3>RENEWAL QUEUE (FIFO)</h3>
                    <table id="queueTable">
                        <thead>
                            <tr><th>POS</th><th>NAME</th><th>STATUS</th></tr>
                        </thead>
                        <tbody id="queueBody"></tbody>
                    </table>
                    <button class="btn-orange" style="width:100%; font-size: 0.8rem; padding: 10px; margin-top: 15px;" onclick="processNext()">PROCESS NEXT (FIFO)</button>
                </div>
            </div>

            <div class="program-card">
                <div class="card-image" style="background-image: url('https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&w=500&q=60');"></div>
                <div class="card-content">
                    <h3>TRAINER SCHEDULING</h3>
                    <p style="color: var(--text-gray); font-size: 0.8rem;">Organize trainer sessions using your custom Insertion Sort logic.</p>
                    <button class="btn-orange" style="width:100%; padding: 10px;" onclick="location.reload();">RUN INSERTION SORT</button>
                </div>
            </div>

            <div class="program-card">
                <div class="card-image" style="background-image: url('https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?auto=format&fit=crop&w=500&q=60');"></div>
                <div class="card-content">
                    <h3>NUTRITION PLANS</h3>
                    <p style="color: var(--text-gray); font-size: 0.8rem;">Access the dietary database for registered elite members.</p>
                    <button class="btn-orange" style="width:100%; padding: 10px; background: transparent; border: 1px solid var(--brand-orange);">VIEW DATABASE</button>
                </div>
            </div>
        </div>
    </main>

    <script>
        let renewalQueue = []; 

        function addToQueueFromData(id, name) {
            renewalQueue.push({id: id, name: name});
            renderQueue();
        }

        function renderQueue() {
            const body = document.getElementById('queueBody');
            body.innerHTML = '';
            renewalQueue.forEach((m, i) => {
                body.innerHTML += `<tr class="new-row"><td>0${i+1}</td><td>${m.name}</td><td><small>PENDING</small></td></tr>`;
            });
        }

        function processNext() {
            if(renewalQueue.length > 0) {
                const processed = renewalQueue.shift(); 
                alert("Processing Payment for: " + processed.name);
                renderQueue();
            } else {
                alert("Queue is empty!");
            }
        }

        function searchMember() {
            let input = document.getElementById('search').value.toUpperCase();
            let table = document.getElementById('memberTable');
            let tr = table.getElementsByTagName('tr');

            for (let i = 1; i < tr.length; i++) {
                let td = tr[i].getElementsByTagName('td')[1]; // Search by Name column
                if (td) {
                    let txtValue = td.textContent || td.innerText;
                    tr[i].style.display = txtValue.toUpperCase().indexOf(input) > -1 ? "" : "none";
                }
            }
        }
    </script>
</body>
</html>