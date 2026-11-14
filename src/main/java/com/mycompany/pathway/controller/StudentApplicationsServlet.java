package com.mycompany.pathway.controller;

import com.mycompany.pathway.dao.ApplicationDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/student-applications")
public class StudentApplicationsServlet extends HttpServlet {

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

        int studentId =
                (int) session.getAttribute("studentId");

        ApplicationDAO applicationDAO =
                new ApplicationDAO();

        request.setAttribute(
                "applications",
                applicationDAO.getApplicationsByStudent(studentId)
        );

        request.getRequestDispatcher(
                "/2_Client_Side/student_Application.jsp"
        ).forward(request, response);
    }
}