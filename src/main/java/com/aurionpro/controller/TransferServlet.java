package com.aurionpro.controller;

import com.aurionpro.dao.AccountDao;
import com.aurionpro.model.Account;
import com.aurionpro.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/TransferServlet")
public class TransferServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AccountDao accountDao = new AccountDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }


        Account account = accountDao.getAccountByUserId(user.getUserId());
        request.setAttribute("account", account);

        request.getRequestDispatcher("transferMoney.jsp").forward(request, response);
    }
}