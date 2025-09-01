package com.aurionpro.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.aurionpro.model.User;
import com.aurionpro.service.UserService;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        User user = userService.login(username, password, role);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            
            if ("Customer".equalsIgnoreCase(user.getRole())) {
                resp.sendRedirect("customerDashboard.jsp");
            } else if ("Admin".equalsIgnoreCase(user.getRole())) {
                resp.sendRedirect("adminDashboard.jsp");
            }
        } else {
            req.setAttribute("error", "Invalid user credentials!");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }
}