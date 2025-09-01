<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aurionpro.model.User, com.aurionpro.model.Account" %>
<%
    User user = (User) session.getAttribute("user");
    Account account = (Account) request.getAttribute("account");

    if (user == null || account == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Transfer Money</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; }
        .card { border-radius: 15px; }
    </style>
</head>
<body class="container mt-5">
    <div class="card p-4 shadow-lg">
        <h4 class="card-header bg-success text-white text-center rounded-top-3">💸 Transfer Funds</h4>
        
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

            <div class="alert alert-info mt-3">
                Your Account Balance: &#8377;<%= account.getBalance() %>
            </div>

            <form action="TransactionServlet" method="post">
                <input type="hidden" name="accountId" value="<%= account.getAccountId() %>">
                
                <div class="mb-3">
                    <label class="form-label">Beneficiary Account Number</label>
                    <input type="text" name="toAccount" class="form-control" placeholder="Enter beneficiary account number" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Amount</label>
                    <input type="number" name="amount" class="form-control" placeholder="Enter amount to transfer" min="1" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Remarks</label>
                    <input type="text" name="remarks" class="form-control" placeholder="e.g., Family, Rent" required>
                </div>
                
                <div class="d-grid">
                    <button type="submit" class="btn btn-success">Send Money</button>
                </div>
            </form>

            <div class="mt-3">
                <a href="customerDashboard.jsp" class="btn btn-secondary">⬅ Back to Dashboard</a>
            </div>
        </div>
    </div>
</body>
</html>