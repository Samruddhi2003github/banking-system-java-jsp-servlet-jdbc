package com.aurionpro.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.dao.AccountDao;
import com.aurionpro.model.Account;

/**
 * Servlet implementation class createAccountServlet
 */
@WebServlet("/createAccountServlet")
public class CreateAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String accountType = request.getParameter("accountType");
        BigDecimal balance = new BigDecimal(request.getParameter("balance"));

        
        long accountNumber = 1000000000L + new Random().nextInt(900000000);

        Account account = new Account();
        account.setUserId(userId);
        account.setAccountNumber(accountNumber);
        account.setAccountType(accountType);
        account.setBalance(balance);
        account.setStatus("Pending"); 

        AccountDao dao = new AccountDao();
        boolean success = dao.createAccount(account);

        if (success) {
            response.sendRedirect("customerDashboard.jsp?msg=Account+created+successfully+Pending+approval");
        } else {
            response.sendRedirect("createAccount.jsp?error=Something+went+wrong");
        }
    }
}