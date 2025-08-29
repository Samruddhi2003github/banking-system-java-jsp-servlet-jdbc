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
    <title>Add Beneficiary</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <div class="card p-4 shadow">
        <h3 class="text-primary">➕ Add Beneficiary</h3>
        <form action="AddBeneficiaryServlet" method="post">
            <div class="mb-3">
                <label>Name</label>
                <input type="text" name="name" class="form-control" required>
            </div>
            <div class="mb-3">
                <label>Account Number</label>
                <input type="number" name="accountNumber" class="form-control" required>
            </div>
            <div class="mb-3">
                <label>IFSC Code</label>
                <input type="text" name="ifscCode" class="form-control" required>
            </div>
            <div class="mb-3">
                <label>Relation</label>
                <input type="text" name="relation" class="form-control">
            </div>
            <button type="submit" class="btn btn-success w-100">Add</button>
        </form>
    </div>
</body>
</html>
