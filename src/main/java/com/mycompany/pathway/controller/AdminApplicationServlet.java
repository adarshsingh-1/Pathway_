package com.mycompany.pathway.controller;

import com.mycompany.pathway.dao.ApplicationDAO;
import com.mycompany.pathway.model.Application;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(
        name = "AdminApplicationServlet",
        urlPatterns = {"/admin-applications"}
)
public class AdminApplicationServlet extends HttpServlet {

    private final ApplicationDAO applicationDAO = new ApplicationDAO();

    private static final String JSP_PAGE
            = "/3_Admin_Side/Applications.jsp";

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        if (!isAdminLoggedIn(request, response)) {
            return;
        }

        loadApplications(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        if (!isAdminLoggedIn(request, response)) {
            return;
        }

        String action = request.getParameter("action");

        if (!"updateStatus".equals(action)) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid action."
            );
            return;
        }

        int applicationId;

        try {
            applicationId = Integer.parseInt(
                    request.getParameter("applicationId")
            );

            if (applicationId <= 0) {
                throw new NumberFormatException();
            }

        } catch (NumberFormatException e) {
            request.setAttribute(
                    "applicationError",
                    "Invalid application ID."
            );

            loadApplications(request, response);
            return;
        }

        String status = request.getParameter("status");

        if (status == null
                || !(status.equals("Pending")
                || status.equals("Applied")
                || status.equals("Shortlisted")
                || status.equals("Interview")
                || status.equals("Selected")
                || status.equals("Rejected"))) {

            request.setAttribute(
                    "applicationError",
                    "Please select a valid application status."
            );

            loadApplications(request, response);
            return;
        }

        boolean updated = applicationDAO.updateApplicationStatus(
                applicationId,
                status
        );

        if (updated) {

            response.sendRedirect(
                    request.getContextPath() + "/admin-applications"
            );

        } else {

            request.setAttribute(
                    "applicationError",
                    "Unable to update the application status. Please check the database."
            );

            loadApplications(request, response);
        }
    }

    private boolean isAdminLoggedIn(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || session.getAttribute("adminId") == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/3_Admin_Side/admin_Login.jsp"
            );

            return false;
        }

        return true;
    }

    private void loadApplications(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        List<Application> applications
                = applicationDAO.getAllApplications();

        request.setAttribute("applications", applications);

        request.getRequestDispatcher(JSP_PAGE)
                .forward(request, response);
    }
}
