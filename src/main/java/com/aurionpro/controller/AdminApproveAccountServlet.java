package com.aurionpro.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.util.List;
import com.aurionpro.dao.AccountDao;
import com.aurionpro.model.Account;

@WebServlet("/admin/accounts")
public class AdminApproveAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AccountDao accountDao = new AccountDao();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Account> accounts = accountDao.getAllPendingAccounts();
        req.setAttribute("accounts", accounts);
        req.getRequestDispatcher("/approveAccounts.jsp").forward(req, resp);
    }
    
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int accountId = Integer.parseInt(req.getParameter("accountId"));
        
        boolean success = accountDao.approveAccount(accountId);
        
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/admin/accounts?message=Account+approved+successfully!");
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/accounts?error=Failed+to+approve+account.");
        }
    }
}