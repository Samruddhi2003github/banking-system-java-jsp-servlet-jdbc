package com.aurionpro.controller;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.util.List;
import com.aurionpro.dao.TxnDao;
import com.aurionpro.model.Txn;

@WebServlet("/admin/transactions")
public class AdminTransactionListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TxnDao txnDao = new TxnDao();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Txn> txns = txnDao.getAllTransactions();
        req.setAttribute("txns", txns);
        req.getRequestDispatcher("/viewTransactions.jsp").forward(req, resp);
    }
}
