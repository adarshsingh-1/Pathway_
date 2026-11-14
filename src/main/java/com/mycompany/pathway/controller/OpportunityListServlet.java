package com.mycompany.pathway.controller;

import com.mycompany.pathway.dao.OpportunityDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/opportunities")
public class OpportunityListServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null
                || session.getAttribute("studentId") == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/2_Client_Side/StudentLogin.jsp"
            );

            return;
        }

        OpportunityDAO opportunityDAO =
                new OpportunityDAO();

        request.setAttribute(
                "opportunities",
                opportunityDAO.getAllOpportunities()
        );

        request.getRequestDispatcher(
                "/2_Client_Side/student_Opportunities.jsp"
        ).forward(request, response);
    }
}