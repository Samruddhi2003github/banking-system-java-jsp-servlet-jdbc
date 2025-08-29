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
<html>
<head>
    <title>Create Account - Samruddhi Bank</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f1f5f9; }
        .card { border-radius: 15px; padding: 25px; max-width: 650px; margin: auto; margin-top: 40px; }
    </style>
</head>
<body>
    <div class="card shadow">
        <h3 class="mb-3 text-center text-primary">🏦 Samruddhi Bank - Open Account</h3>
        <form action="CreateAccountServlet" method="post">
            <input type="hidden" name="userId" value="<%= user.getUserId() %>">

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Account Type</label>
                    <select name="accountType" class="form-select" required>
                        <option value="Savings">Savings</option>
                        <option value="Current">Current</option>
                        <option value="Salary">Salary</option>
                        <option value="Fixed Deposit">Fixed Deposit</option>
                    </select>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Initial Deposit</label>
                    <input type="number" name="balance" class="form-control" min="1000" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Branch Name</label>
                <input type="text" name="branch" class="form-control" required>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">PAN Number</label>
                    <input type="text" name="pan" class="form-control" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Aadhaar Number</label>
                    <input type="text" name="aadhaar" class="form-control" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Occupation</label>
                <input type="text" name="occupation" class="form-control">
            </div>

            <div class="mb-3">
                <label class="form-label">Date of Birth</label>
                <input type="date" name="dob" class="form-control" required>
            </div>

            <h5 class="text-secondary mt-3">Nominee Details</h5>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Nominee Name</label>
                    <input type="text" name="nomineeName" class="form-control">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Relation</label>
                    <input type="text" name="nomineeRelation" class="form-control">
                </div>
            </div>

            <button type="submit" class="btn btn-success w-100">Submit Application</button>
        </form>
    </div>
</body>
</html>
