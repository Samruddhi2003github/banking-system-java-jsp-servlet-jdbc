<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow-lg">
                <div class="card-header text-center bg-success text-white">
                    <h4>Register</h4>
                </div>
                <div class="card-body">
                    <form action="RegisterServlet" method="post">
                        <input type="text" name="username" class="form-control mb-3" placeholder="Username" required>
                        <input type="password" name="password" class="form-control mb-3" placeholder="Password" required>
                        <input type="text" name="name" class="form-control mb-3" placeholder="Full Name">
                        <input type="email" name="email" class="form-control mb-3" placeholder="Email">
                        <input type="text" name="mobile" class="form-control mb-3" placeholder="Mobile">
                        <input type="text" name="address" class="form-control mb-3" placeholder="Address">
                        <button class="btn btn-success w-100">Register</button>
                    </form>
                    <p class="mt-3 text-center">
                        Already have an account? <a href="login.jsp">Login</a>
                    </p>
                    <p class="text-danger text-center">${error}</p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
