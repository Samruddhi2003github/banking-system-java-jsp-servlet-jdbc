package com.aurionpro.controller;

import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aurionpro.dao.AccountDao;
import com.aurionpro.dao.BeneficiaryDao;
import com.aurionpro.dao.TxnDao;
import com.aurionpro.model.Account;
import com.aurionpro.model.Beneficiary;
import com.aurionpro.model.Txn;
import com.aurionpro.model.User;

@WebServlet("/TransactionServlet")
public class TransactionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TxnDao txnDao = new TxnDao();
    private AccountDao accountDao = new AccountDao();
    private BeneficiaryDao beneficiaryDao = new BeneficiaryDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        Account fromAccount = accountDao.getAccountByUserId(currentUser.getUserId());

        if (fromAccount == null || !"Active".equals(fromAccount.getStatus())) {
            response.sendRedirect("transferMoney.jsp?error=Account+is+not+active+or+not+found.");
            return;
        }
        
        // Input validation and error handling
        String toAccNumStr = request.getParameter("toAccount");
        String amountStr = request.getParameter("amount");
        String remarks = request.getParameter("remarks");
        
        if (toAccNumStr == null || toAccNumStr.trim().isEmpty() ||
            amountStr == null || amountStr.trim().isEmpty() ||
            remarks == null || remarks.trim().isEmpty()) {
            
            response.sendRedirect("transferMoney.jsp?error=All+fields+are+required.");
            return;
        }
        
        long toAccNum;
        BigDecimal amount;
        
        try {
            toAccNum = Long.parseLong(toAccNumStr);
            amount = new BigDecimal(amountStr);
            if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                response.sendRedirect("transferMoney.jsp?error=Amount+must+be+greater+than+zero.");
                return;
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("transferMoney.jsp?error=Invalid+amount+or+account+number+format.");
            return;
        }
        
        if (fromAccount.getBalance().compareTo(amount) < 0) {
            response.sendRedirect("transferMoney.jsp?error=Insufficient+balance.");
            return;
        }

        Beneficiary beneficiary = beneficiaryDao.getBeneficiaryByAccountNumber(currentUser.getUserId(), toAccNum);
        
        if (beneficiary == null) {
            response.sendRedirect("transferMoney.jsp?error=Beneficiary+not+found.");
            return;
        }
        
    
        fromAccount.setBalance(fromAccount.getBalance().subtract(amount));
        accountDao.updateBalance(fromAccount.getAccountId(), fromAccount.getBalance().doubleValue());
        
 
        Txn debitTxn = new Txn();
        debitTxn.setAccountId(fromAccount.getAccountId());
        debitTxn.setBeneficiaryId(beneficiary.getBeneficiaryId());
        debitTxn.setAmount(amount);
        debitTxn.setTxnType("Debit");
        debitTxn.setRemarks("Transfer to " + beneficiary.getName() + " (" + toAccNum + "): " + remarks);
        txnDao.addTransaction(debitTxn);

   
        Account toAccount = accountDao.getAccountByAccountNumber(toAccNum);
        if (toAccount != null) {
            toAccount.setBalance(toAccount.getBalance().add(amount));
            accountDao.updateBalance(toAccount.getAccountId(), toAccount.getBalance().doubleValue());
            
   
            Txn creditTxn = new Txn();
            creditTxn.setAccountId(toAccount.getAccountId());
            creditTxn.setBeneficiaryId(null);
            creditTxn.setAmount(amount);
            creditTxn.setTxnType("Credit");
            creditTxn.setRemarks("Received from " + currentUser.getName() + " (" + fromAccount.getAccountNumber() + ")");
            txnDao.addTransaction(creditTxn);
        } else {

        }

        response.sendRedirect("passbook.jsp?accountId=" + fromAccount.getAccountId() + "&message=Transaction+successful!");
    }
}