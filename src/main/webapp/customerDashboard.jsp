<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aurionpro.model.User, com.aurionpro.model.Account, com.aurionpro.dao.AccountDao" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    AccountDao accountDao = new AccountDao();
    Account account = accountDao.getAccountByUserId(user.getUserId());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f0f4f8, #d9e4ec);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .dashboard-card {
            width: 100%;
            max-width: 600px;
            border-radius: 15px;
            background: #fff;
            box-shadow: 0px 6px 20px rgba(0,0,0,0.1);
            padding: 25px;
        }
        .btn {
            border-radius: 10px;
            padding: 12px;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="dashboard-card">
        <h2 class="text-success mb-3">Welcome, <%= user.getName() %> 👋</h2>
        <p class="text-muted">You are logged in as a <strong>Customer</strong>.</p>

        <hr>

        <% if (account == null) { %>
            <!-- No account yet -->
            <div class="alert alert-info">You don’t have a bank account yet.</div>
            <a href="createAccount.jsp" class="btn btn-primary w-100">🏦 Create New Account</a>

        <% } else if ("Pending".equals(account.getStatus())) { %>
            <!-- Account waiting for approval -->
            <div class="alert alert-warning">Your account application is <strong>Pending</strong>.  
                Please wait for Admin approval.</div>

        <% } else if ("Active".equals(account.getStatus())) { %>
            <!-- Active Account - show banking features -->
            <div class="alert alert-success">Your account is <strong>Active</strong>.  
                Balance: ₹<%= account.getBalance() %></div>

            <div class="mt-3 d-grid gap-2">
                <a href="profile.jsp" class="btn btn-outline-primary">👤 View Profile</a>
                <a href="addBeneficiary.jsp" class="btn btn-outline-info">➕ Add Beneficiary</a>
                <a href="transferMoney.jsp" class="btn btn-outline-success">💸 Transfer Money</a>
                <a href="passbook.jsp" class="btn btn-outline-warning">📒 View Passbook</a>
                <a href="logout.jsp" class="btn btn-outline-danger">🚪 Logout</a>
            </div>
        <% } %>
    </div>
</body>
</html>
