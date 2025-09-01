<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Samruddhi Bank - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #e9ecef;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .login-card {
            width: 100%;
            max-width: 400px;
            border-radius: 15px;
            background: #fff;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        .form-control, .form-select {
            border-radius: 8px;
        }
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
            border-radius: 8px;
            padding: 10px;
            font-size: 1.1rem;
        }
    </style>
</head>
<body>

<div class="login-card">
    <h3 class="text-center mb-4 text-success">
        <i class="fas fa-university me-2"></i>🏦 Samruddhi Bank
    </h3>
    <p class="text-center text-muted mb-4">Your Trust, Our Responsibility</p>

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
        <div class="alert alert-danger text-center mb-3">
            <%= error %>
        </div>
    <% } %>

    <form action="LoginServlet" method="post">
        <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" name="username" class="form-control" placeholder="Enter username" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" placeholder="Enter password" required>
        </div>
        <div class="mb-4">
            <label class="form-label">Login As</label>
            <select name="role" class="form-select">
                <option value="Customer">Customer</option>
                <option value="Admin">Admin</option>
            </select>
        </div>
        <button type="submit" class="btn btn-success w-100">Login</button>
    </form>

    <p class="mt-4 text-center">
        Don’t have an account? <a href="register.jsp">Register</a>
    </p>
</div>

</body>
</html>