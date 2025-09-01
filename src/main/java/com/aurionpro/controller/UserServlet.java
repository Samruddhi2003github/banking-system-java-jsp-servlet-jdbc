package com.aurionpro.controller;

import com.aurionpro.model.User;
import com.aurionpro.util.DBUtil;
import com.aurionpro.util.PasswordHasher;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<User> users = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT user_id, username, name, email, role FROM users WHERE role = 'Customer' OR role = 'Admin'"; // Include Admin for display
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                users.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        request.setAttribute("users", users);
        request.getRequestDispatcher("manageUsers.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try (Connection conn = DBUtil.getConnection()) {
            if ("add".equalsIgnoreCase(action)) {
                String username = request.getParameter("username");
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String role = request.getParameter("role");

                // Hash the password before saving it to the database
                String hashedPassword = PasswordHasher.hashPassword(password);

                String sql = "INSERT INTO users (username, name, email, password, role) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, name);
                ps.setString(3, email);
                ps.setString(4, hashedPassword); // Store the hashed password
                ps.setString(5, role);
                ps.executeUpdate();

                response.sendRedirect("UserServlet?message=User+Added+Successfully");

            } else if ("update".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String username = request.getParameter("username");
                String name = request.getParameter("name"); // Added this line
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String role = request.getParameter("role");

                // Hash the new password if it's provided
                String hashedPassword = PasswordHasher.hashPassword(password);

                String sql = "UPDATE users SET username=?, name=?, email=?, password=?, role=? WHERE user_id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, name);
                ps.setString(3, email);
                ps.setString(4, hashedPassword); // Store the hashed password
                ps.setString(5, role);
                ps.setInt(6, id);
                ps.executeUpdate();

                response.sendRedirect("UserServlet?message=User+Updated+Successfully");

            } else if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));

                String sql = "DELETE FROM users WHERE user_id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, id);
                ps.executeUpdate();

                response.sendRedirect("UserServlet?message=User+Deleted+Successfully");
            } else {
                 response.sendRedirect("UserServlet?error=Invalid+action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("UserServlet?error=" + e.getMessage());
        }
    }
}