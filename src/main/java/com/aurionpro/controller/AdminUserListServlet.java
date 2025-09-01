package com.aurionpro.controller;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import com.aurionpro.dao.UserDao;
import com.aurionpro.model.User;

@WebServlet("/admin/users")
public class AdminUserListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDao = new UserDao();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<User> users = userDao.getAllUsers();
        req.setAttribute("users", users);
        req.getRequestDispatcher("adminUserList.jsp").forward(req, resp);
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int userId = Integer.parseInt(req.getParameter("userId"));
        userDao.deleteUser(userId);
        resp.sendRedirect("users");
    }
}
