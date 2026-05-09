<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>FitNase | Transaction History</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&family=Oswald:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --brand-orange: #ff5722;
            --dark-bg: #0f0f0f;
            --card-bg: rgba(26, 26, 26, 0.95);
            --text-gray: #bbbbbb;
        }

        body { 
            background: linear-gradient(rgba(15, 15, 15, 0.9), rgba(15, 15, 15, 0.9)), 
                        url('https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=2070&auto=format&fit=crop'); 
            background-size: cover;
            background-attachment: fixed;
            color: white; 
            font-family: 'Poppins', sans-serif; 
            margin: 0;
            padding: 50px 20px; 
            min-height: 100vh;
        }

        h2 { 
            font-family: 'Oswald', sans-serif;
            color: white; 
            letter-spacing: 4px; 
            text-align: center; 
            text-transform: uppercase; 
            font-size: 2.5rem;
            margin-bottom: 40px;
        }

        h2 span { color: var(--brand-orange); }

        .history-container {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            padding: 40px;
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 25px 60px rgba(0,0,0,0.7);
            max-width: 1100px;
            margin: 0 auto;
        }

        table { 
            width: 100%; 
            border-collapse: collapse; 
        }

        th { 
            text-align: left; 
            color: var(--brand-orange); 
            padding: 20px 15px; 
            font-family: 'Oswald', sans-serif;
            font-size: 0.95rem; 
            letter-spacing: 2px;
            text-transform: uppercase;
            border-bottom: 2px solid #333;
        }

        td { 
            padding: 20px 15px; 
            border-bottom: 1px solid #222; 
            font-size: 0.95rem; 
            color: #ddd;
        }

        tr:hover td { 
            background: rgba(255, 255, 255, 0.02); 
            color: white;
            transition: 0.3s;
        }

        .status-badge {
            padding: 6px 14px;
            border-radius: 50px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .status-verified { background: rgba(76, 175, 80, 0.15); color: #81c784; border: 1px solid rgba(129, 199, 132, 0.3); }
        .status-pending { background: rgba(255, 193, 7, 0.15); color: #ffd54f; border: 1px solid rgba(255, 213, 79, 0.3); }
        .status-cancelled { background: rgba(244, 67, 54, 0.15); color: #e57373; border: 1px solid rgba(229, 115, 115, 0.3); }

        .plan-name {
            font-weight: 600;
            color: white;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .btn-cancel { 
            background: transparent;
            border: 1px solid #444;
            color: #888; 
            padding: 8px 18px;
            border-radius: 8px;
            text-decoration: none; 
            font-size: 11px; 
            font-weight: 600; 
            text-transform: uppercase;
            transition: 0.3s; 
        }

        .btn-cancel:hover { 
            border-color: var(--brand-orange);
            color: white;
            background: rgba(255, 87, 34, 0.1);
        }

        .back-link { 
            display: inline-block;
            margin-top: 40px; 
            color: var(--text-gray); 
            text-decoration: none; 
            font-size: 0.85rem; 
            text-transform: uppercase;
            transition: 0.3s; 
        }

        .back-link:hover { color: var(--brand-orange); }

        .empty-msg {
            text-align: center;
            padding: 60px;
            color: #666;
            font-style: italic;
        }
    </style>
</head>
<body>

    <h2>TRANSACTION <span>LOGS</span></h2>
    
    <div class="history-container">
        <table>
            <thead>
                <tr>
                    <th>Plan Details</th>
                    <th>Amount</th>
                    <th>Payment Method</th>
                    <th>Verification Status</th>
                    <th style="text-align: right;">Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="pay" items="${history}">
                    <tr>
                        <td class="plan-name">
                            <c:choose>
                                <c:when test="${pay.plan == 'Gold'}">
                                    <i class="fas fa-crown" style="color: #ffd700;"></i>
                                </c:when>
                                <c:when test="${pay.plan == 'Silver'}">
                                    <i class="fas fa-crown" style="color: #c0c0c0;"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-crown" style="color: #cd7f32;"></i>
                                </c:otherwise>
                            </c:choose>
                            ${pay.plan} Membership
                        </td>
                        <td style="font-family: 'Oswald', sans-serif; font-size: 1.1rem; color: white;">
                            Rs. ${pay.amount}
                        </td>
                        <td>
                            <i class="fas ${pay.paymentMethod == 'Card' ? 'fa-credit-card' : 'fa-building-columns'}" style="margin-right: 8px; opacity: 0.5;"></i>
                            ${pay.paymentMethod}
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${pay.status == 'Verified'}">
                                    <span class="status-badge status-verified"><i class="fas fa-check-circle"></i> ${pay.status}</span>
                                </c:when>
                                <c:when test="${pay.status == 'Cancelled'}">
                                    <span class="status-badge status-cancelled"><i class="fas fa-times-circle"></i> ${pay.status}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-pending"><i class="fas fa-clock"></i> ${pay.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td style="text-align: right;">
                            <a href="/delete-payment?plan=${pay.plan}&amount=${pay.amount}" 
                               class="btn-cancel"
                               onclick="return confirm('Security Alert: Are you sure you want to cancel this transaction record?')">
                                <i class="fas fa-ban"></i> Cancel
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                
                <c:if test="${empty history}">
                    <tr>
                        <td colspan="5" class="empty-msg">
                            <i class="fas fa-receipt" style="font-size: 3rem; display: block; margin-bottom: 15px; opacity: 0.2;"></i>
                            No transaction records found.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
        
        <div style="text-align: center;">
            <a href="/select-plan" class="back-link">
                <i class="fas fa-chevron-left"></i> Back to Memberships
            </a>
        </div>
    </div>

</body>
</html>