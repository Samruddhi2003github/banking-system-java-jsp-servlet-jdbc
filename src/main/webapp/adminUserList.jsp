<%@page import="java.util.List"%>
<%@page import="com.aurionpro.model.User"%>
<%
    List<User> users = (List<User>)request.getAttribute("users");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Users (Admin)</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
    <div class="card shadow p-4">
        <h4>User Management</h4>
        <table class="table table-striped">
            <tr>
                <th>User ID</th><th>Username</th><th>Name</th><th>Email</th><th>Mobile</th><th>Action</th>
            </tr>
            <%
                for(User u: users) {
            %>
                <tr>
                    <td><%=u.getUserId()%></td>
                    <td><%=u.getUsername()%></td>
                    <td><%=u.getName()%></td>
                    <td><%=u.getEmail()%></td>
                    <td><%=u.getMobile()%></td>
                    <td>
                        <form action="users" method="post" onsubmit="return confirm('Delete user?')">
                            <input type="hidden" name="userId" value="<%=u.getUserId()%>">
                            <button class="btn btn-danger btn-sm" type="submit">Delete</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>
        <a class="btn btn-secondary" href="adminDashboard.jsp">Back</a>
    </div>
</body>
</html>
