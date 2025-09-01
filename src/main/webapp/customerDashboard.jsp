<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.aurionpro.model.User, com.aurionpro.model.Account, com.aurionpro.dao.AccountDao"%>
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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
body {
	background: #f0f2f5;
}

.navbar {
	background-color: #007bff;
}

.nav-link {
	color: white !important;
}

.dashboard-container {
	max-width: 900px;
}

.card-feature {
	transition: transform 0.2s;
}

.card-feature:hover {
	transform: translateY(-5px);
}
</style>
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">🏦 Samruddhi Bank</a>
			<div class="d-flex ms-auto">
				<span class="navbar-text me-3 text-white-50">Hello, <%=user.getName()%></span>
				<a href="logout.jsp" class="btn btn-sm btn-outline-light">Logout</a>
			</div>
		</div>
	</nav>

	<div class="container dashboard-container mt-5">
		<div class="alert alert-info text-center mb-4">
			You are logged in as a <strong>Customer</strong>
		</div>

		<%
		if (account == null) {
		%>
		<div class="card p-4 text-center">
			<div class="alert alert-info">You don’t have a bank account
				yet.</div>
			<a href="createAccount.jsp" class="btn btn-primary w-100 mt-2">🏦
				Create New Account</a>
		</div>
		<%
		} else if ("Pending".equals(account.getStatus())) {
		%>
		<div class="card p-4 text-center">
			<div class="alert alert-warning">Your account application is
				**Pending**. Please wait for Admin approval.</div>
		</div>
		<%
		} else if ("Active".equals(account.getStatus())) {
		%>
		<div class="card p-4 mb-4">
			<h5 class="card-title text-success">
				Account Balance: <span class="fw-bold fs-4">&#8377;<%=account.getBalance()%></span>
			</h5>
		</div>

		<div class="row g-4">
			<div class="col-md-6 col-lg-4">
				<a href="profile.jsp"
					class="card card-feature shadow-sm text-decoration-none">
					<div class="card-body text-center py-4">
						<i class="fas fa-user-circle fa-2x text-primary mb-2"></i>
						<h6 class="card-title mt-2">View Profile</h6>
					</div>
				</a>
			</div>
			<div class="col-md-6 col-lg-4">
				<a href="addBeneficiary.jsp"
					class="card card-feature shadow-sm text-decoration-none">
					<div class="card-body text-center py-4">
						<i class="fas fa-user-plus fa-2x text-info mb-2"></i>
						<h6 class="card-title mt-2">Add Beneficiary</h6>
					</div>
				</a>
			</div>
			<div class="col-md-6 col-lg-4">
				<a href="TransferServlet"
					class="card card-feature shadow-sm text-decoration-none">
					<div class="card-body text-center py-4">
						<i class="fas fa-exchange-alt fa-2x text-success mb-2"></i>
						<h6 class="card-title mt-2">Transfer Money</h6>
					</div>
				</a>
			</div>
			<div class="col-md-6 col-lg-4">
				<a href="passbook.jsp?accountId=<%=account.getAccountId()%>"
					class="card card-feature shadow-sm text-decoration-none">
					<div class="card-body text-center py-4">
						<i class="fas fa-book fa-2x text-warning mb-2"></i>
						<h6 class="card-title mt-2">View Passbook</h6>
					</div>
				</a>
			</div>
		</div>
		<%
		}
		%>
	</div>
</body>
</html>