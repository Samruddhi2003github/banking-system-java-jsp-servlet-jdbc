package com.aurionpro.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.model.Txn;
import com.aurionpro.service.TxnService;

@WebServlet("/passbook")
public class PassbookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TxnService txnService = new TxnService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int accountId = Integer.parseInt(request.getParameter("accountId"));
        List<Txn> txnList = txnService.getPassbook(accountId);

        request.setAttribute("transactions", txnList);
        request.getRequestDispatcher("passbook.jsp").forward(request, response);
    }
}
