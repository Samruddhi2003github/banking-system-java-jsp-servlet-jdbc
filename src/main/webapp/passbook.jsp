<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.aurionpro.model.User, com.aurionpro.model.Txn, com.aurionpro.model.Beneficiary, java.util.List" %>
<%@ page import="com.aurionpro.dao.TxnDao, com.aurionpro.dao.BeneficiaryDao, com.aurionpro.dao.AccountDao" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int accountId = Integer.parseInt(request.getParameter("accountId"));
    TxnDao txnDao = new TxnDao();
    List<Txn> transactions = txnDao.getTransactionsByAccountId(accountId);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Transaction History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <div class="card shadow p-4">
        <h4 class="text-primary mb-4">📒 Transaction History</h4>

        <% String message = request.getParameter("message"); %>
        <% if (message != null) { %>
            <div class="alert alert-success text-center">
                <%= message %>
            </div>
        <% } %>

        <div class="table-responsive">
            <table class="table table-striped table-hover" id="txnTable">
                <thead>
                    <tr>
                        <th>Txn ID</th>
                        <th>Date</th>
                        <th>Type</th>
                        <th>Beneficiary</th>
                        <th>Amount</th>
                        <th>Remarks</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (transactions != null && !transactions.isEmpty()) {
                            BeneficiaryDao beneficiaryDao = new BeneficiaryDao();
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
                        <td><%= txn.getTxnDate() %></td>
                        <td><%= txn.getTxnType() %></td>
                        <td><%= beneficiaryName %></td>
                        <td>&#8377;<%= txn.getAmount() %></td>
                        <td><%= txn.getRemarks() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="6" class="text-center text-muted">No transactions found.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        
        <nav aria-label="Page navigation" class="d-flex justify-content-center mt-3">
            <ul class="pagination" id="pagination"></ul>
        </nav>

        <div class="d-grid mt-3">
            <a href="customerDashboard.jsp" class="btn btn-secondary">⬅ Back to Dashboard</a>
        </div>
    </div>
    
    <script>
        const rowsPerPage = 10;
        const table = document.getElementById('txnTable');
        const rows = Array.from(table.tBodies[0].rows);
        const paginationContainer = document.getElementById('pagination');

        function displayRows(page) {
            const start = (page - 1) * rowsPerPage;
            const end = start + rowsPerPage;
            rows.forEach((row, index) => {
                row.style.display = (index >= start && index < end) ? '' : 'none';
            });
        }

        function setupPagination() {
            paginationContainer.innerHTML = '';
            const pageCount = Math.ceil(rows.length / rowsPerPage);
            for (let i = 1; i <= pageCount; i++) {
                const li = document.createElement('li');
                li.className = 'page-item';
                const link = document.createElement('a');
                link.className = 'page-link';
                link.href = '#';
                link.innerText = i;
                link.addEventListener('click', (e) => {
                    e.preventDefault();
                    displayRows(i);
                    document.querySelectorAll('.page-item').forEach(item => item.classList.remove('active'));
                    li.classList.add('active');
                });
                li.appendChild(link);
                paginationContainer.appendChild(li);
            }
            if (pageCount > 0) {
                paginationContainer.querySelector('.page-item').classList.add('active');
                displayRows(1);
            }
        }

        document.addEventListener('DOMContentLoaded', setupPagination);
    </script>
</body>
</html>