<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.aurionpro.model.Account"%>
<%
List<Account> accounts = (List<Account>) request.getAttribute("accounts");
%>
<!DOCTYPE html>
<html>
<head>
<title>Approve Accounts</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
	<div class="card shadow p-4">
		<h4>Pending Accounts Approval</h4>
		<table class="table table-striped">
			<tr>
				<th>Account ID</th>
				<th>User ID</th>
				<th>Type</th>
				<th>Balance</th>
				<th>Approve</th>
			</tr>
			<%
			for(Account acc: accounts) {
			%>
			<tr>
				<td><%=acc.getAccountId()%></td>
				<td><%=acc.getUserId()%></td>
				<td><%=acc.getAccountType()%></td>
				<td>&#8377;<%=acc.getBalance()%></td>
				<td>
					<form action="accounts" method="post">
						<input type="hidden" name="accountId"
							value="<%=acc.getAccountId()%>">
						<button class="btn btn-success btn-sm" type="submit">Approve</button>
					</form>
				</td>
			</tr>
			<%
			}
			%>
		</table>
		<a class="btn btn-secondary" href="../adminDashboard.jsp">Back</a>
	</div>
</body>
</html>