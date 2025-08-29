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

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        Beneficiary b = new Beneficiary();
        b.setUserId(user.getUserId());
        b.setName(req.getParameter("name"));
        b.setAccountNumber(Long.parseLong(req.getParameter("accountNumber")));
        b.setIfscCode(req.getParameter("ifscCode"));
        b.setRelation(req.getParameter("relation"));

        boolean added = dao.addBeneficiary(b);
        if (added) {
            resp.sendRedirect("addBeneficiary.jsp?msg=Beneficiary+Added+Successfully");
        } else {
            resp.sendRedirect("addBeneficiary.jsp?error=Failed+to+add+beneficiary");
        }
    }
}
