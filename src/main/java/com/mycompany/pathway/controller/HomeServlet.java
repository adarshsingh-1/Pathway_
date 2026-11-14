
package com.mycompany.pathway.controller;

import com.mycompany.pathway.dao.HomeDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.time.Year;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private final HomeDAO homeDAO = new HomeDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        try {

            // 1. Get placement statistics
            Map<String, Object> statistics =
                    homeDAO.getPlacementStatistics();

            request.setAttribute(
                    "statistics",
                    statistics
            );

            // 2. Get maximum 8 hiring companies
            List<Map<String, Object>> companies =
                    homeDAO.getHiringCompanies();

            request.setAttribute(
                    "hiringCompanies",
                    companies
            );

            // 3. Get active partners
            request.setAttribute(
                    "activePartners",
                    homeDAO.getActivePartners()
            );

            // 4. Generate current session dynamically
            int currentYear = Year.now().getValue();

            String sessionLabel =
                    currentYear + "-"
                    + String.valueOf(currentYear + 1).substring(2);

            request.setAttribute(
                    "sessionLabel",
                    sessionLabel
            );

        } catch (SQLException e) {

            e.printStackTrace();

            request.setAttribute(
                    "statistics",
                    new HashMap<String, Object>()
            );

            request.setAttribute(
                    "hiringCompanies",
                    Collections.emptyList()
            );

            request.setAttribute(
                    "activePartners",
                    0
            );

            request.setAttribute(
                    "sessionLabel",
                    Year.now().getValue() + "-"
                    + String.valueOf(Year.now().getValue() + 1).substring(2)
            );

            request.setAttribute(
                    "homeError",
                    "Unable to load placement information."
            );
        }

        // Forward to the home page
        request.getRequestDispatcher(
                "/1_Home_Page/index.jsp"
        ).forward(request, response);
    }
}
