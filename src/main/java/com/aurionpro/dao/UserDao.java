package com.aurionpro.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.aurionpro.model.User;
import com.aurionpro.util.DBUtil;

public class UserDao {
	public boolean registerUser(User user) {
        String sql = "INSERT INTO users(username,password,role,name,email,mobile,address) VALUES(?,?,?,?,?,?,?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, "Customer"); // always customer while registering
            ps.setString(4, user.getName());
            ps.setString(5, user.getEmail());
            ps.setString(6, user.getMobile());
            ps.setString(7, user.getAddress());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Login user
    public User loginUser(String username, String password, String role) {
        String sql = "SELECT * FROM users WHERE username=? AND password=? AND role=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, role);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setMobile(rs.getString("mobile"));
                user.setAddress(rs.getString("address"));
                return user;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
 // Update user profile
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET name=?, email=?, mobile=?, address=?, password=? WHERE user_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getMobile());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getPassword());
            ps.setInt(6, user.getUserId());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role='Customer'";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setMobile(rs.getString("mobile"));
                // ... more as needed
                users.add(u);
            }
        } catch(SQLException e){e.printStackTrace();}
        return users;
    }
    public void deleteUser(int userId){
        String sql = "DELETE FROM users WHERE user_id=?";
        try(Connection conn = DBUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch(Exception e){e.printStackTrace();}
    }


}

