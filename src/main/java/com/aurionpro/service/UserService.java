package com.aurionpro.service;

import com.aurionpro.dao.UserDao;
import com.aurionpro.model.User;
import com.aurionpro.util.PasswordHasher;

public class UserService {
    private UserDao userDao = new UserDao();

    public boolean register(User user) {
        String hashedPassword = PasswordHasher.hashPassword(user.getPassword());
        if (hashedPassword != null) {
            user.setPassword(hashedPassword);
            return userDao.registerUser(user);
        }
        return false;
    }

    public User login(String username, String password, String role) {
        String hashedPassword = PasswordHasher.hashPassword(password);
        if (hashedPassword != null) {
            return userDao.loginUser(username, hashedPassword, role);
        }
        return null;
    }

    public boolean updateProfile(User user) {
        String hashedPassword = PasswordHasher.hashPassword(user.getPassword());
        if (hashedPassword != null) {
            user.setPassword(hashedPassword);
            return userDao.updateUser(user);
        }
        return false;
    }
}