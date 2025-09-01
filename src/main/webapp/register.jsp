<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - Samruddhi Bank</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #e0f2f1, #b2dfdb); }
        .card { border-radius: 15px; }
    </style>
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow-lg">
                <div class="card-header text-center bg-success text-white rounded-top-3">
                    <h4>📝 Create Your Account</h4>
                </div>
                <div class="card-body">
                    <% if(request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger text-center">
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>
                    <form action="RegisterServlet" method="post">
                        <input type="text" name="username" class="form-control mb-3" placeholder="Username" required>
                        <input type="password" name="password" class="form-control mb-3" placeholder="Password" required>
                        <input type="text" name="name" class="form-control mb-3" placeholder="Full Name">
                        <input type="email" name="email" class="form-control mb-3" placeholder="Email">
                        <input type="tel" name="mobile" class="form-control mb-3" placeholder="Mobile (10 digits)" pattern="[0-9]{10}" title="10 digit mobile number" required>
                        <input type="text" name="address" class="form-control mb-3" placeholder="Address">
                        <div class="d-grid">
                            <button class="btn btn-success">Register</button>
                        </div>
                    </form>
                    <p class="mt-3 text-center">
                        Already have an account? <a href="login.jsp">Login here</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>