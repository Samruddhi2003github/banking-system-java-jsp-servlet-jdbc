package com.aurionpro.service;

import com.aurionpro.dao.UserDao;
import com.aurionpro.model.User;

public class UserService {
	private UserDao userDao = new UserDao();

    public boolean register(User user) {
        return userDao.registerUser(user);
    }

    public User login(String username, String password, String role) {
        return userDao.loginUser(username, password, role);
    }
    
    public boolean updateProfile(User user) {
        return userDao.updateUser(user);
    }

}

