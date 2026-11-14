
package com.mycompany.pathway.controller;

import com.mycompany.pathway.dao.ApplicationDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/apply-opportunity")
public class ApplyOpportunityServlet extends HttpServlet {

    private static final Logger LOGGER =
            Logger.getLogger(ApplyOpportunityServlet.class.getName());

    private final ApplicationDAO applicationDAO = new ApplicationDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String contextPath = request.getContextPath();

        // Check student session
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("studentId") == null) {

            response.sendRedirect(
                    contextPath + "/2_Client_Side/StudentLogin.jsp"
            );
            return;
        }

        try {

            // Get student ID safely
            Object studentValue = session.getAttribute("studentId");

            int studentId = Integer.parseInt(studentValue.toString());

            // Get opportunity ID from the Apply form
            String opportunityValue =
                    request.getParameter("opportunityId");

            if (opportunityValue == null
                    || opportunityValue.trim().isEmpty()) {

                response.sendRedirect(
                        contextPath + "/opportunities?message=invalidOpportunity"
                );
                return;
            }

            int opportunityId = Integer.parseInt(opportunityValue);

            if (studentId <= 0 || opportunityId <= 0) {

                response.sendRedirect(
                        contextPath + "/opportunities?message=invalidOpportunity"
                );
                return;
            }

            // Check whether student has already applied
            if (applicationDAO.alreadyApplied(studentId, opportunityId)) {

                response.sendRedirect(
                        contextPath + "/opportunities?message=alreadyApplied"
                );
                return;
            }

            // Save application in database
            boolean result = applicationDAO.apply(
                    studentId,
                    opportunityId
            );

            if (result) {

                response.sendRedirect(
                        contextPath + "/student-applications?message=success"
                );

            } else {

                response.sendRedirect(
                        contextPath + "/opportunities?message=failed"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    contextPath + "/opportunities?message=invalidOpportunity"
            );

        } catch (RuntimeException e) {

            LOGGER.log(
                    Level.SEVERE,
                    "Failed to submit opportunity application.",
                    e
            );

            response.sendRedirect(
                    contextPath + "/opportunities?message=databaseError"
            );
        }
    }
}
