<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    com.aurionpro.model.User user = (com.aurionpro.model.User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body { background: #f0f2f5; }
        .navbar { background-color: #dc3545; }
        .nav-link { color: white !important; }
        .dashboard-container { max-width: 800px; }
        .card-feature { transition: transform 0.2s, box-shadow 0.2s; }
        .card-feature:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.15) !important; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">⚙️ Admin Panel</a>
            <div class="d-flex ms-auto">
                <span class="navbar-text me-3 text-white-50">Welcome, <%= user.getName() %></span>
                <a href="logout.jsp" class="btn btn-sm btn-outline-light">Logout</a>
            </div>
        </div>
    </nav>
    <div class="container dashboard-container mt-5">
        <div class="alert alert-danger text-center mb-4">
            You are logged in with <strong>Admin privileges</strong>.
        </div>
        
        <div class="row g-4">
            <div class="col-md-6 col-lg-4">
                <a href="UserServlet" class="card card-feature shadow-sm text-decoration-none">
                    <div class="card-body text-center py-4">
                        <i class="fas fa-users-cog fa-2x text-warning mb-2"></i>
                        <h6 class="card-title mt-2">Manage Users</h6>
                    </div>
                </a>
            </div>
            <div class="col-md-6 col-lg-4">
                <a href="admin/accounts" class="card card-feature shadow-sm text-decoration-none">
                    <div class="card-body text-center py-4">
                        <i class="fas fa-check-circle fa-2x text-success mb-2"></i>
                        <h6 class="card-title mt-2">Approve Accounts</h6>
                    </div>
                </a>
            </div>
            <div class="col-md-6 col-lg-4">
               <a href="admin/transactions" class="card card-feature shadow-sm text-decoration-none">
                    <div class="card-body text-center py-4">
                        <i class="fas fa-chart-bar fa-2x text-info mb-2"></i>
                        <h6 class="card-title mt-2">View All Transactions</h6>
                    </div>
                </a>
            </div>
        </div>
    </div>
</body>
</html>