<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aurionpro.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Profile - Samruddhi Bank</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #e9ecef; }
        .card { border-radius: 15px; }
    </style>
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-lg border-0 rounded-3">
                    <div class="card-header bg-primary text-white text-center rounded-top-3">
                        <h3>👤 My Profile</h3>
                    </div>
                    <div class="card-body">
                        <% if(request.getAttribute("message") != null) { %>
                            <div class="alert alert-success text-center">
                                <%= request.getAttribute("message") %>
                            </div>
                        <% } %>
                        <% if(request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger text-center">
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                        
                        <form action="profile" method="post">
                            <div class="mb-3">
                                <label class="form-label">Username</label>
                                <input type="text" class="form-control" value="<%= user.getUsername() %>" readonly>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" class="form-control" name="name" value="<%= user.getName() %>" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" value="<%= user.getEmail() %>" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Mobile</label>
                                <input type="tel" class="form-control" name="mobile" value="<%= user.getMobile() %>" pattern="[0-9]{10}" title="10 digit mobile number" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Address</label>
                                <textarea class="form-control" name="address" rows="2" required><%= user.getAddress() %></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">New Password</label>
                                <input type="password" class="form-control" name="password" placeholder="Enter new password to update">
                            </div>
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-success">✅ Update Profile</button>
                                <a href="customerDashboard.jsp" class="btn btn-secondary">⬅ Back to Dashboard</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>