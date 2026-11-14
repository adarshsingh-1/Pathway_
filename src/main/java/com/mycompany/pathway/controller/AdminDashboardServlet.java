package com.mycompany.pathway.controller;

import com.mycompany.pathway.dao.AdminDashboardDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import java.util.List;
import java.util.Map;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final AdminDashboardDAO dashboardDAO
            = new AdminDashboardDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        // STEP 1: Check administrator session.
        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("adminId") == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/3_Admin_Side/admin_Login.jsp"
            );

            return;
        }

        try {

            // STEP 2: Fetch total dashboard statistics.
            request.setAttribute(
                    "totalStudents",
                    dashboardDAO.getTotalStudents()
            );

            request.setAttribute(
                    "totalCompanies",
                    dashboardDAO.getTotalCompanies()
            );

            request.setAttribute(
                    "totalOpportunities",
                    dashboardDAO.getTotalOpportunities()
            );

            request.setAttribute(
                    "totalApplications",
                    dashboardDAO.getTotalApplications()
            );
            request.setAttribute(
                    "monthlyStats",
                    dashboardDAO.getMonthlyApplicationStats()
            );

            // STEP 3: Fetch new students this week.
            request.setAttribute(
                    "newStudentsThisWeek",
                    dashboardDAO.getNewStudentsThisWeek()
            );

            // STEP 4: Fetch new companies this month.
            request.setAttribute(
                    "newCompaniesThisMonth",
                    dashboardDAO.getNewCompaniesThisMonth()
            );

            // STEP 5: Fetch opportunities closing soon.
            request.setAttribute(
                    "closingSoon",
                    dashboardDAO.getOpportunitiesClosingSoon()
            );

            // STEP 6: Fetch selected students.
            request.setAttribute(
                    "selectedStudents",
                    dashboardDAO.getSelectedStudentsCount()
            );

            // STEP 7: Calculate placement rate.
            request.setAttribute(
                    "placementRate",
                    String.format(
                            Locale.ENGLISH,
                            "%.1f%%",
                            dashboardDAO.getPlacementRate()
                    )
            );

            // STEP 8: Get current Indian date.
            LocalDate currentDate
                    = LocalDate.now(
                            ZoneId.of("Asia/Kolkata")
                    );

            DateTimeFormatter formatter
                    = DateTimeFormatter.ofPattern(
                            "dd MMM yyyy",
                            Locale.ENGLISH
                    );

            String formattedDate
                    = currentDate.format(formatter)
                            .toUpperCase(Locale.ENGLISH);

            request.setAttribute(
                    "currentDate",
                    formattedDate
            );

            // STEP 9: Fetch monthly application graph data.
            Map<String, List<Integer>> monthlyStats
                    = dashboardDAO.getMonthlyApplicationStats();

            // STEP 10: Convert graph data into JSON.
            request.setAttribute(
                    "monthlyApplicationStatsJson",
                    convertStatsToJson(monthlyStats)
            );

            // Fetch recent dashboard activities.
            request.setAttribute(
                    "recentActivities",
                    dashboardDAO.getRecentActivities()
            );

            // STEP 11: Forward to Dashboard JSP.
            request.getRequestDispatcher(
                    "/3_Admin_Side/Dashboard.jsp"
            ).forward(request, response);

        } catch (SQLException e) {

            throw new ServletException(
                    "Unable to load administrator dashboard statistics.",
                    e
            );
        }
    }

    // STEP 12: Convert Java Map into JSON.
    private String convertStatsToJson(
            Map<String, List<Integer>> stats) {

        return "{"
                + "\"applications\":" + stats.get("applications") + ","
                + "\"interviewed\":" + stats.get("interviewed") + ","
                + "\"selected\":" + stats.get("selected") + ","
                + "\"rejected\":" + stats.get("rejected")
                + "}";
    }
}
