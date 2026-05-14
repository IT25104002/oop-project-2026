<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>FITNASE | Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Oswald', sans-serif; background: #000; color: #fff; padding: 20px; }
        .header { border-bottom: 3px solid #ff5722; display: flex; justify-content: space-between; padding-bottom: 10px; margin-bottom: 20px; }
        .orange { color: #ff5722; }
        .panel { background: #111; padding: 20px; border-radius: 10px; border: 1px solid #222; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #222; }
        th { color: #ff5722; text-transform: uppercase; }
        .status-booked { color: #4CAF50; font-weight: bold; }
        .status-deleted { color: #ff4444; font-weight: bold; }
        .btn-print { background: #ff5722; color: #000; padding: 10px 20px; border: none; font-weight: bold; cursor: pointer; border-radius: 5px; }
        @media print { .btn-print { display: none; } body { background: white; color: black; } .panel { border: none; background: white; } th { color: black; border-bottom: 2px solid black; } }
    </style>
</head>
<body>
<div class="header">
    <div style="font-size: 24px; font-weight: bold;">FIT<span class="orange">NASE</span> | ADMIN</div>
    <button class="btn-print" onclick="window.print()"><i class="fas fa-print"></i> PRINT REPORT</button>
</div>
<div class="panel">
    <table>
        <thead><tr><th>Member ID</th><th>Date</th><th>Coach / Class</th><th>Session</th><th>Status</th></tr></thead>
        <tbody>
            <c:forEach items="${allSchedules}" var="s">
                <tr>
                    <td><b>${s.memberId}</b></td><td>${s.date}</td><td>${s.trainer}</td><td>${s.timeSlot}</td>
                    <td>
                        <c:choose>
                            <c:when test="${s.status == 'BOOKED'}"><span class="status-booked">BOOKED</span></c:when>
                            <c:otherwise><span class="status-deleted">DELETED</span></c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>