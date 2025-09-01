<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.aurionpro.model.Txn, com.aurionpro.model.User, com.aurionpro.model.Account, com.aurionpro.model.Beneficiary" %>
<%@ page import="com.aurionpro.dao.AccountDao, com.aurionpro.dao.BeneficiaryDao" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"Admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Txn> transactions = (List<Txn>) request.getAttribute("txns");
    
    AccountDao accountDao = new AccountDao();
    BeneficiaryDao beneficiaryDao = new BeneficiaryDao();
%>
<!DOCTYPE html>
<html>
<head>
    <title>All Bank Transactions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f0f2f5; }
        .card { border-radius: 15px; }
        .table th, .table td { vertical-align: middle; }
    </style>
</head>
<body class="container mt-5">
    <div class="card shadow p-4">
        <h4 class="text-info mb-4">📊 All Bank Transactions (Admin View)</h4>

        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>Txn ID</th>
                        <th>Account ID</th>
                        <th>Beneficiary</th>
                        <th>Type</th>
                        <th>Amount</th>
                        <th>Date</th>
                        <th>Remarks</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (transactions != null && !transactions.isEmpty()) {
                            for (Txn txn : transactions) {
                                String beneficiaryName = "N/A";
                                if (txn.getBeneficiaryId() != null) {
                                    Beneficiary beneficiary = beneficiaryDao.getBeneficiaryById(txn.getBeneficiaryId());
                                    if (beneficiary != null) {
                                        beneficiaryName = beneficiary.getName();
                                    }
                                }
                    %>
                    <tr>
                        <td><%= txn.getTxnId() %></td>
                        <td><%= txn.getAccountId() %></td>
                        <td><%= beneficiaryName %></td>
                        <td><%= txn.getTxnType() %></td>
                        <td>&#8377;<%= txn.getAmount() %></td>
                        <td><%= txn.getTxnDate() %></td>
                        <td><%= txn.getRemarks() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="7" class="text-center text-muted">No transactions found.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <div class="d-grid mt-3">
            <a href="adminDashboard.jsp" class="btn btn-secondary">⬅ Back to Dashboard</a>
        </div>
    </div>
</body>
</html>