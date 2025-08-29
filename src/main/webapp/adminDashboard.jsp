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
</head>
<body class="container mt-5">
    <div class="card shadow p-4">
        <h2 class="text-primary">Welcome Admin, <%= user.getName() %> ⚡</h2>
        <p>You are logged in with <strong>Admin privileges</strong>.</p>

        <div class="mt-3 d-grid gap-2">
            <a href="manageUsers.jsp" class="btn btn-warning">👥 Manage Users</a>
            <a href="approveAccounts.jsp" class="btn btn-success">✅ Approve Accounts</a>
            <a href="viewTransactions.jsp" class="btn btn-info">📊 View Transactions</a>
            <a href="logout.jsp" class="btn btn-danger">🚪 Logout</a>
        </div>
    </div>
</body>
</html>
