package com.mycompany.pathway.controller;

import com.mycompany.pathway.dao.CompanyDAO;
import com.mycompany.pathway.dao.OpportunityDAO;
import com.mycompany.pathway.modal.Company;
import com.mycompany.pathway.modal.Opportunity;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(
        name = "AdminOpportunityServlet",
        urlPatterns = {"/admin-opportunities"}
)
public class AdminOpportunityServlet extends HttpServlet {

    private final OpportunityDAO opportunityDAO = new OpportunityDAO();
    private final CompanyDAO companyDAO = new CompanyDAO();

    private static final String JSP_PAGE =
            "/3_Admin_Side/Opportunities.jsp";

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        if (!isAdminLoggedIn(request, response)) {
            return;
        }

        loadOpportunities(request, response);
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

        try {
            if ("add".equals(action)) {

                Opportunity opportunity = readOpportunity(request);
                opportunityDAO.addOpportunity(opportunity);

            } else if ("update".equals(action)) {

                Opportunity opportunity = readOpportunity(request);

                int opportunityId = parsePositiveInt(
                        request.getParameter("opportunityId"),
                        "Invalid opportunity ID."
                );

                opportunity.setOpportunityId(opportunityId);

                opportunityDAO.updateOpportunity(opportunity);

            } else if ("delete".equals(action)) {

                int opportunityId = parsePositiveInt(
                        request.getParameter("opportunityId"),
                        "Invalid opportunity ID."
                );

                opportunityDAO.deleteOpportunity(opportunityId);

            } else {

                throw new IllegalArgumentException(
                        "Invalid action requested."
                );
            }

            response.sendRedirect(
                    request.getContextPath() + "/admin-opportunities"
            );

        } catch (IllegalArgumentException e) {

            request.setAttribute("opportunityError", e.getMessage());
            loadOpportunities(request, response);

        } catch (SQLException e) {

            getServletContext().log(
                    "Database error while processing opportunity.", e
            );

            request.setAttribute(
                    "opportunityError",
                    "Unable to save the opportunity. Check the database and submitted values."
            );

            loadOpportunities(request, response);

        } catch (Exception e) {

            getServletContext().log(
                    "Unexpected error while processing opportunity.", e
            );

            request.setAttribute(
                    "opportunityError",
                    "An unexpected error occurred while processing the opportunity."
            );

            loadOpportunities(request, response);
        }
    }

    private boolean isAdminLoggedIn(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminId") == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/3_Admin_Side/admin_Login.jsp"
            );

            return false;
        }

        return true;
    }

    private Opportunity readOpportunity(HttpServletRequest request) {

        Opportunity opportunity = new Opportunity();

        int companyId = parsePositiveInt(
                request.getParameter("companyId"),
                "Please select a company."
        );

        String jobTitle = required(
                request.getParameter("jobTitle"),
                "Job title"
        );

        if (jobTitle.length() > 150) {
            throw new IllegalArgumentException(
                    "Job title cannot exceed 150 characters."
            );
        }

        String jobType = clean(request.getParameter("jobType"));
        String location = clean(request.getParameter("location"));

        String packageValue = required(
                request.getParameter("packageAmount"),
                "Package amount"
        );

        String cgpaValue = required(
                request.getParameter("eligibilityCgpa"),
                "Eligibility CGPA"
        );

        double packageAmount;

        try {
            packageAmount = Double.parseDouble(packageValue);

            if (!Double.isFinite(packageAmount) || packageAmount < 0) {
                throw new NumberFormatException();
            }

        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(
                    "Enter a valid, non-negative package amount."
            );
        }

        double eligibilityCgpa;

        try {
            eligibilityCgpa = Double.parseDouble(cgpaValue);

            if (!Double.isFinite(eligibilityCgpa)
                    || eligibilityCgpa < 0
                    || eligibilityCgpa > 10) {
                throw new NumberFormatException();
            }

        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(
                    "Eligibility CGPA must be between 0 and 10."
            );
        }

        String deadline = clean(request.getParameter("deadline"));

        if (deadline != null) {
            try {
                java.sql.Date.valueOf(deadline);
            } catch (IllegalArgumentException e) {
                throw new IllegalArgumentException(
                        "Enter a valid deadline in YYYY-MM-DD format."
                );
            }
        }

        opportunity.setCompanyId(companyId);
        opportunity.setJobTitle(jobTitle);
        opportunity.setJobType(jobType);
        opportunity.setLocation(location);
        opportunity.setPackageAmount(packageAmount);
        opportunity.setEligibilityCgpa(eligibilityCgpa);
        opportunity.setRequiredSkills(
                clean(request.getParameter("requiredSkills"))
        );
        opportunity.setDescription(
                clean(request.getParameter("description"))
        );
        opportunity.setDeadline(deadline);

        return opportunity;
    }

    private String required(String value, String fieldName) {

        String result = clean(value);

        if (result == null) {
            throw new IllegalArgumentException(
                    fieldName + " is required."
            );
        }

        return result;
    }

    private String clean(String value) {

        if (value == null || value.trim().isEmpty()) {
            return null;
        }

        return value.trim();
    }

    private int parsePositiveInt(
            String value,
            String errorMessage
    ) {

        try {
            int number = Integer.parseInt(value);

            if (number <= 0) {
                throw new NumberFormatException();
            }

            return number;

        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(errorMessage);
        }
    }

    private void loadOpportunities(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        try {
            List<Opportunity> opportunities =
                    opportunityDAO.getAllOpportunities();

            List<Company> companies =
                    companyDAO.getAllCompanies();

            request.setAttribute("opportunities", opportunities);
            request.setAttribute("companies", companies);

        } catch (Exception e) {

            getServletContext().log(
                    "Unable to load opportunities or companies.", e
            );

            request.setAttribute(
                    "opportunityError",
                    "Unable to load opportunities. Check your database connection and table columns."
            );
        }

        request.getRequestDispatcher(JSP_PAGE)
                .forward(request, response);
    }
}