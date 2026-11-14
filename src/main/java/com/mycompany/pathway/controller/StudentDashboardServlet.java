
package com.mycompany.pathway.controller;

import com.mycompany.pathway.dao.StudentDashboardDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/student-dashboard")
public class StudentDashboardServlet extends HttpServlet {

    private final StudentDashboardDAO dashboardDAO =
            new StudentDashboardDAO();

    private static final String JSP_PAGE =
            "/2_Client_Side/student_overview.jsp";

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        // 1. CHECK STUDENT SESSION
        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("studentId") == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/2_Client_Side/StudentLogin.jsp"
            );

            return;
        }

        // 2. GET LOGGED-IN STUDENT ID
        int studentId;

        try {
            studentId = Integer.parseInt(
                    session.getAttribute("studentId").toString()
            );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/2_Client_Side/StudentLogin.jsp"
            );

            return;
        }

        try {

            // 3. YOUR SNAPSHOT

            request.setAttribute(
                    "totalApplications",
                    dashboardDAO.getTotalApplications(studentId)
            );

            request.setAttribute(
                    "shortlistedApplications",
                    dashboardDAO.getShortlistedApplications(studentId)
            );

            request.setAttribute(
                    "openOpportunities",
                    dashboardDAO.getOpenOpportunities()
            );

            request.setAttribute(
                    "profileCompletion",
                    dashboardDAO.getProfileCompletion(studentId)
            );


            // 4. TOP 3 HIGHEST-PACKAGE OPPORTUNITIES

            request.setAttribute(
                    "topOpportunities",
                    dashboardDAO.getTopOpportunities()
            );


            // 5. LATEST 4 RECENT ACTIVITIES

            request.setAttribute(
                    "recentActivities",
                    dashboardDAO.getRecentActivities(studentId)
            );


            // 6. FORWARD DATA TO JSP

            request.getRequestDispatcher(JSP_PAGE)
                    .forward(request, response);

        } catch (RuntimeException e) {

            log("Unable to load student dashboard.", e);

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load dashboard data. Please try again."
            );
        }
    }
}
