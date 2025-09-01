package com.aurionpro.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.aurionpro.dao.BeneficiaryDao;
import com.aurionpro.model.Beneficiary;
import com.aurionpro.model.User;

@WebServlet("/AddBeneficiaryServlet")
public class AddBeneficiaryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BeneficiaryDao dao = new BeneficiaryDao();

    
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        req.getRequestDispatcher("addBeneficiary.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        
      
        String name = req.getParameter("name");
        String ifscCode = req.getParameter("ifscCode");
        String accountNumberStr = req.getParameter("accountNumber");
        String relation = req.getParameter("relation");

        if (name == null || name.trim().isEmpty() || ifscCode == null || ifscCode.trim().isEmpty() || accountNumberStr == null || accountNumberStr.trim().isEmpty()) {
            resp.sendRedirect("addBeneficiary.jsp?error=All+fields+are+required");
            return;
        }

        try {
            long accountNumber = Long.parseLong(accountNumberStr);
            Beneficiary b = new Beneficiary();
            b.setUserId(user.getUserId());
            b.setName(name);
            b.setAccountNumber(accountNumber);
            b.setIfscCode(ifscCode);
            b.setRelation(relation);

            boolean added = dao.addBeneficiary(b);
            if (added) {
                resp.sendRedirect("addBeneficiary.jsp?msg=Beneficiary+Added+Successfully");
            } else {
                resp.sendRedirect("addBeneficiary.jsp?error=Failed+to+add+beneficiary");
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect("addBeneficiary.jsp?error=Invalid+account+number+format");
        }
    }
}