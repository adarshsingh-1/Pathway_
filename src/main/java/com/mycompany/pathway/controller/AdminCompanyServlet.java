
package com.mycompany.pathway.controller;

import com.mycompany.pathway.dao.CompanyDAO;
import com.mycompany.pathway.modal.Company;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(
        name = "AdminCompanyServlet",
        urlPatterns = {"/admin-companies"}
)
public class AdminCompanyServlet extends HttpServlet {

    private static final Logger LOGGER =
            Logger.getLogger(AdminCompanyServlet.class.getName());

    private final CompanyDAO companyDAO = new CompanyDAO();

    // ==========================================
    // CHECK ADMIN LOGIN
    // ==========================================
    private boolean isAdminLoggedIn(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        return session != null
                && session.getAttribute("adminId") != null;
    }

    // ==========================================
    // REDIRECT TO ADMIN LOGIN
    // ==========================================
    private void redirectToLogin(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException {

        response.sendRedirect(
                request.getContextPath()
                + "/3_Admin_Side/admin_Login.jsp"
        );
    }

    // ==========================================
    // GET METHOD - FETCH ALL COMPANIES
    // ==========================================
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        if (!isAdminLoggedIn(request)) {
            redirectToLogin(request, response);
            return;
        }

        try {

            List<Company> companies =
                    companyDAO.getAllCompanies();

            request.setAttribute("companies", companies);

        } catch (RuntimeException e) {

            LOGGER.log(
                    Level.SEVERE,
                    "Failed to load companies.",
                    e
            );

            request.setAttribute(
                    "companyLoadError",
                    "Companies could not be loaded. "
                    + "Please check your database connection."
            );

            request.setAttribute(
                    "companies",
                    Collections.emptyList()
            );
        }

        request.getRequestDispatcher(
                "/3_Admin_Side/Companies.jsp"
        ).forward(request, response);
    }

    // ==========================================
    // POST METHOD - ADD / UPDATE / DELETE
    // ==========================================
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        // Check admin login.
        if (!isAdminLoggedIn(request)) {
            redirectToLogin(request, response);
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        try {

            // ==================================
            // ADD COMPANY
            // ==================================
            if ("add".equals(action)) {

                Company company = getCompanyFromRequest(request);

                boolean inserted =
                        companyDAO.addCompany(company);

                if (!inserted) {
                    throw new RuntimeException(
                            "Company could not be inserted."
                    );
                }

            }

            // ==================================
            // UPDATE COMPANY
            // ==================================
            else if ("update".equals(action)) {

                int companyId = getCompanyId(request);

                Company company = getCompanyFromRequest(request);

                company.setCompanyId(companyId);

                boolean updated =
                        companyDAO.updateCompany(company);

                if (!updated) {
                    throw new RuntimeException(
                            "Company could not be updated. "
                            + "The company ID may not exist."
                    );
                }

            }

            // ==================================
            // DELETE COMPANY
            // ==================================
            else if ("delete".equals(action)) {

                int companyId = getCompanyId(request);

                boolean deleted =
                        companyDAO.deleteCompany(companyId);

                if (!deleted) {
                    throw new RuntimeException(
                            "Company could not be deleted. "
                            + "The company ID may not exist."
                    );
                }

            }

            // ==================================
            // INVALID ACTION
            // ==================================
            else {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid company action."
                );

                return;
            }

            // ==================================
            // REDIRECT AFTER SUCCESS
            // ==================================
            response.sendRedirect(
                    request.getContextPath() + "/admin-companies"
            );

        } catch (IllegalArgumentException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    e.getMessage()
            );

        } catch (RuntimeException e) {

            LOGGER.log(
                    Level.SEVERE,
                    "Company operation failed. Action: " + action,
                    e
            );

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to complete the company operation. "
                    + "Please check the server logs and database."
            );
        }
    }

    // ==========================================
    // GET COMPANY DETAILS FROM JSP FORM
    // ==========================================
    private Company getCompanyFromRequest(
            HttpServletRequest request
    ) {

        String companyName = request.getParameter("companyName");

        if (companyName == null || companyName.trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "Company name is required."
            );
        }

        Company company = new Company();

        company.setCompanyName(companyName.trim());

        company.setContactEmail(
                cleanValue(request.getParameter("email"))
        );

        company.setLocation(
                cleanValue(request.getParameter("location"))
        );

        company.setWebsite(
                cleanValue(request.getParameter("website"))
        );

        company.setDescription(
                cleanValue(request.getParameter("description"))
        );

        return company;
    }

    // ==========================================
    // GET COMPANY ID
    // ==========================================
    private int getCompanyId(HttpServletRequest request) {

        String id = request.getParameter("companyId");

        try {

            int companyId = Integer.parseInt(id);

            if (companyId <= 0) {
                throw new IllegalArgumentException(
                        "Invalid company ID."
                );
            }

            return companyId;

        } catch (NumberFormatException | NullPointerException e) {

            throw new IllegalArgumentException(
                    "A valid company ID is required."
            );
        }
    }

    // ==========================================
    // CLEAN EMPTY FORM VALUES
    // ==========================================
    private String cleanValue(String value) {

        if (value == null || value.trim().isEmpty()) {
            return null;
        }

        return value.trim();
    }
}
