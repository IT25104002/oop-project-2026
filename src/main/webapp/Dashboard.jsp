<%@ page import="main.Filehandler, main.Member, java.util.List" %>
<%
    String path = application.getRealPath("/") + "webappdata/members.txt";
    Filehandler fh = new Filehandler(path);
    List<Member> memberList = fh.readMembersToList();
%>
<%-- (மேலே உள்ள Java Imports மற்றும் Logic அப்படியே இருக்கட்டும்) --%>

<!DOCTYPE html>
<html>
<head>
    <title>Elite Gym | Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #0f0f0f; color: white; font-family: 'Segoe UI', sans-serif; margin: 50px; }
        .member-table { width: 100%; border-collapse: collapse; background: #1a1a1a; border-radius: 10px; overflow: hidden; }
        .member-table th { background: #000; color: #ff5722; padding: 15px; text-align: left; border-bottom: 2px solid #333; }
        .member-table td { padding: 15px; border-bottom: 1px solid #222; }
        .action-btn { 
            padding: 8px 12px; border-radius: 5px; border: none; cursor: pointer; 
            font-weight: bold; transition: 0.3s; text-decoration: none; display: inline-block; font-size: 12px;
        }
        .btn-queue { background: #333; color: white; }
        .btn-diet { background: transparent; border: 1px solid #4CAF50; color: #4CAF50; margin-left: 5px; }
        .btn-plan { background: #ff5722; color: white; margin-left: 5px; }
        .action-btn:hover { opacity: 0.8; transform: translateY(-2px); }
    </style>
</head>
<body>

    <h2 style="color: #ff5722; text-transform: uppercase;">Member List</h2>

    <table class="member-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>NAME</th>
                <th>PLAN</th>
                <th>RENEWAL</th>
                <th>ACTIONS</th>
            </tr>
        </thead>
        <tbody>
            <% for (Member m : memberList) { 
                String id = (m.getMemberId() != null) ? m.getMemberId() : "NA";
            %>
            <tr>
                <td>#<%= id %></td>
                <td><%= m.getName() %></td>
                <td><%= m.getMembershipType() %></td>
                <td><%= m.getRenewalDate() %></td>
                <td>
                    <button class="action-btn btn-queue">Queue</button>
                    
                    <a href="memberdiet.jsp?memberId=<%= id %>" class="action-btn btn-diet">
                        <i class="fas fa-utensils"></i> Member Diet
                    </a>
                    
                    <a href="dietplan.jsp?memberId=<%= id %>" class="action-btn btn-plan">
                        <i class="fas fa-file-invoice"></i> Diet Plan
                    </a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

</body>
</html>