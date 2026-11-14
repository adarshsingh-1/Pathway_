package com.mycompany.pathway.controller;

import com.mycompany.pathway.dao.AdminDAO;
import com.mycompany.pathway.model.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.security.GeneralSecurityException;
import java.util.Locale;

@WebServlet("/admin-login")
public class AdminLoginServlet extends HttpServlet {

    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null
                && session.getAttribute("adminId") != null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-dashboard"
            );
            return;
        }

        request.getRequestDispatcher(
                "/3_Admin_Side/admin_Login.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null
                || email.trim().isEmpty()
                || password.isEmpty()) {

            request.setAttribute(
                    "error",
                    "Please enter your email and password."
            );

            request.getRequestDispatcher(
                    "/3_Admin_Side/admin_Login.jsp"
            ).forward(request, response);

            return;
        }

        email = email.trim().toLowerCase(Locale.ROOT);

        try {
            Admin admin = adminDAO.loginAdmin(email, password);

            if (admin == null) {

                request.setAttribute(
                        "error",
                        "Invalid email or password."
                );

                request.setAttribute("email", email);

                request.getRequestDispatcher(
                        "/3_Admin_Side/admin_Login.jsp"
                ).forward(request, response);

                return;
            }

            // Create a fresh session after successful authentication.
            HttpSession oldSession = request.getSession(false);

            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession session = request.getSession(true);

            session.setAttribute("adminId", admin.getAdminId());
            session.setAttribute("adminName", admin.getName());
            session.setAttribute("adminEmail", admin.getEmail());

            session.setMaxInactiveInterval(30 * 60);

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin-dashboard"
            );

        } catch (SQLException | GeneralSecurityException e) {

            throw new ServletException(
                    "Error while authenticating administrator.",
                    e
            );
        }
    }
}