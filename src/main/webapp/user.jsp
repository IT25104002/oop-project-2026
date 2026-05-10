<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>FITNASE | User Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        body { font-family: 'Oswald', sans-serif; background: #000; color: #fff; margin: 0; padding: 20px; }
        header { border-bottom: 3px solid #ff5722; padding-bottom: 15px; margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; }
        .orange { color: #ff5722; }
        .main-container { display: flex; gap: 30px; }
        .panel { background: #111; padding: 25px; border-radius: 12px; border: 1px solid #222; margin-bottom: 20px; }
        .left { width: 35%; } .right { width: 65%; }
        h3 { color: #ff5722; text-transform: uppercase; margin-top: 0; border-left: 4px solid #ff5722; padding-left: 10px; }
        .btn-orange { width: 100%; padding: 12px; background: #ff5722; color: #000; border: none; font-weight: bold; cursor: pointer; border-radius: 5px; text-transform: uppercase; }

        .btn-diet { background: #4CAF50; color: white; text-decoration: none; display: block; padding: 15px; border-radius: 8px; font-weight: bold; text-align: center; margin-top: 15px; transition: 0.3s; }
        .btn-diet:hover { background: #45a049; transform: scale(1.02); }

        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th { text-align: left; color: #ff5722; padding: 10px; border-bottom: 1px solid #333; }
        td { padding: 10px; border-bottom: 1px solid #222; font-size: 14px; }
        select { width:100%; padding:10px; background:#222; color:white; border:1px solid #333; margin-bottom: 15px; }
        label { font-size: 12px; color: #777; margin-bottom: 5px; display: block; }
    </style>
</head>
<body>

<header>
    <div style="font-size: 24px; font-weight: bold;">FIT<span class="orange">NASE</span></div>
    <div>ID: <b class="orange">${currentId}</b> | Welcome, <b>${currentName}</b></div>
</header>

<div class="main-container">
    <div class="left">
        <div class="panel">
            <h3>Book Session</h3>
            <p style="font-size: 12px; margin-bottom: 15px; color: ${bookingCount >= 2 ? '#ff4444' : '#4CAF50'}">
                <i class="fas fa-info-circle"></i> Weekly Limit: ${bookingCount} / 2 used
            </p>
            <form action="/book" method="post">
                <input type="hidden" name="memberId" value="${currentId}">

                <label>Select Class Type</label>
                <select name="trainerAndClass">
                    <c:choose>
                        <c:when test="${packageName == 'GOLD'}">
                            <option value="Mr. Saman | Cardio Blast">Cardio Blast</option>
                            <option value="Mrs. Nimali | Yoga & Flexibility">Yoga & Flexibility</option>
                            <option value="Mr. Kamal |  Power Lifting">Power Lifting</option>
                        </c:when>
                        <c:when test="${packageName == 'SILVER'}">
                            <option value=" Cardio Blast">Cardio Blast</option>
                            <option value=" Yoga & Flexibility">Yoga & Flexibility</option>
                        </c:when>
                        <c:otherwise><option value="General | Gym">General Gym</option></c:otherwise>
                    </c:choose>
                </select>

                <label>Preferred Time</label>
                <select name="timeSlot">
                    <option value="Morning (06-09)">Morning Session</option>
                    <option value="Evening (17-20)">Evening Session</option>
                </select>

                <label>Select Day</label>
                <select name="bookingDay">
                    <option value="MONDAY">Monday</option>
                    <option value="TUESDAY">Tuesday</option>
                    <option value="WEDNESDAY">Wednesday</option>
                    <option value="THURSDAY">Thursday</option>
                    <option value="FRIDAY">Friday</option>
                </select>

                <button type="submit" class="btn-orange" ${bookingCount >= 2 ? 'disabled style="background:#333; cursor:not-allowed;"' : ''}>
                    ${bookingCount >= 2 ? 'LIMIT REACHED' : 'CONFIRM BOOKING'}
                </button>
            </form>
        </div>

        <div class="panel">
            <h3>${packageName} Package Details</h3>
            <ul style="list-style:none; padding:0; font-size:14px; color:#bbb; margin-top: 15px;">
                <li style="margin-bottom: 8px;"><i class="fas fa-check orange"></i> Unlimited Gym Access</li>
                <c:choose>
                    <c:when test="${packageName == 'GOLD'}">
                        <li style="margin-bottom: 8px;"><i class="fas fa-check orange"></i> All Classes (Cardio Blast/Yoga & Flexibility/Power Lifting)</li>
                        <li style="margin-bottom: 8px;"><i class="fas fa-check orange"></i> Personal Trainer Support</li>
                    </c:when>
                    <c:when test="${packageName == 'SILVER'}">
                        <li style="margin-bottom: 8px;"><i class="fas fa-check orange"></i> Yoga & Cardio Access</li>
                    </c:when>
                    <c:otherwise>
                        <li style="margin-bottom: 8px;"><i class="fas fa-check orange"></i> Standard Gym Equipment</li>
                    </c:otherwise>
                </c:choose>
            </ul>

            <c:if test="${packageName != 'BRONZE'}">
                <a href="/diet" class="btn-diet">
                    <i class="fas fa-utensils"></i> VIEW MY DIET PLAN
                </a>
            </c:if>
        </div>
    </div>

    <div class="right">
        <div class="panel">
            <h3>My Active Schedule</h3>
            <table>
                <thead><tr><th>Date</th><th>Coach</th><th>Time</th><th>Action</th></tr></thead>
                <tbody>
                    <c:forEach items="${myBookings}" var="s">
                        <tr>
                            <td>${s.date}</td><td>${s.trainer}</td><td>${s.timeSlot}</td>
                            <td>
                                <form action="/deleteSchedule" method="post" onsubmit="return confirmDelete(event, this);">
                                    <input type="hidden" name="memberId" value="${s.memberId}">
                                    <input type="hidden" name="timeSlot" value="${s.timeSlot}">
                                    <input type="hidden" name="trainer" value="${s.trainer}">
                                    <button type="submit" style="background:none; border:none; color:#ff4444; cursor:pointer;"><i class="fas fa-trash-alt"></i></button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="panel" style="opacity:0.6;">
            <h3>Booking History</h3>
            <c:forEach items="${history}" var="h">
                <div style="padding:8px 0; border-bottom:1px solid #222; font-size:13px;">
                    ${h.date} - ${h.trainer} <span style="float:right" class="orange">${h.status}</span>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<script>
    const urlParams = new URLSearchParams(window.location.search);
    if(urlParams.get('status') === 'success') {
        Swal.fire({ icon: 'success', title: 'Booking Successful!', background: '#111', color: '#fff', confirmButtonColor: '#ff5722' });
    } else if(urlParams.get('status') === 'limit') {
        Swal.fire({ icon: 'error', title: 'Limit Exceeded!', text: 'Maximum 2 bookings per week allowed.', background: '#111', color: '#fff', confirmButtonColor: '#ff5722' });
    }

    function confirmDelete(e, f) {
        e.preventDefault();
        Swal.fire({ title: 'Cancel Session?', text: "Are you sure?", icon: 'warning', showCancelButton: true, confirmButtonColor: '#ff5722', background: '#111', color: '#fff' }).then((result) => { if (result.isConfirmed) f.submit(); });
    }
</script>
</body>
</html>