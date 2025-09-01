<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aurionpro.model.User" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; }
        .card { border-radius: 15px; }
    </style>
</head>
<body class="container mt-5">
    <div class="card p-4 shadow-lg">
        <h4 class="card-header bg-primary text-white text-center rounded-top-3">👥 Manage Users (Admin)</h4>
        
        <div class="card-body">
            <% String message = request.getParameter("message"); %>
            <% if (message != null) { %>
                <div class="alert alert-success text-center">
                    <%= message %>
                </div>
            <% } %>
            <% String error = request.getParameter("error"); %>
            <% if (error != null) { %>
                <div class="alert alert-danger text-center">
                    <%= error %>
                </div>
            <% } %>

            <h5 class="mt-4">➕ Add New User</h5>
            <form action="UserServlet" method="post" class="row g-3">
                <input type="hidden" name="action" value="add">
                <div class="col-md-3">
                    <input type="text" name="username" class="form-control" placeholder="Username" required>
                </div>
                <div class="col-md-3">
                    <input type="text" name="name" class="form-control" placeholder="Full Name" required>
                </div>
                <div class="col-md-3">
                    <input type="email" name="email" class="form-control" placeholder="Email" required>
                </div>
                <div class="col-md-3">
                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                </div>
                <div class="col-md-4">
                    <select name="role" class="form-select">
                        <option value="Customer">Customer</option>
                        <option value="Admin">Admin</option>
                    </select>
                </div>
                <div class="col-md-8 d-grid">
                    <button type="submit" class="btn btn-success">Add User</button>
                </div>
            </form>

            <h5 class="mt-5">📋 Existing Users</h5>
            <table class="table table-bordered table-striped text-center mt-3">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<User> users = (List<User>) request.getAttribute("users"); %>
                    <% if (users != null && !users.isEmpty()) { %>
                        <% for (User user : users) { %>
                            <tr>
                                <td><%= user.getUserId() %></td>
                                <td><%= user.getUsername() %></td>
                                <td><%= user.getName() %></td>
                                <td><%= user.getEmail() %></td>
                                <td><%= user.getRole() %></td>
                                <td>
                                    <form action="UserServlet" method="post" class="d-inline">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="<%= user.getUserId() %>">
                                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this user?');">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    <% } else { %>
                        <tr>
                            <td colspan="6" class="text-center text-muted">No users found.</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
            
            <div class="mt-3">
                <a href="adminDashboard.jsp" class="btn btn-secondary">⬅ Back to Dashboard</a>
            </div>
        </div>
    </div>
</body>
</html>