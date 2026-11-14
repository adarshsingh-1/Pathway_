
package com.mycompany.pathway.controller;

import com.mycompany.pathway.dao.StudentDAO;
import com.mycompany.pathway.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminStudentServlet", urlPatterns = {"/admin-students"})
public class AdminStudentServlet extends HttpServlet {

    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Check whether an admin is logged in
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/3_Admin_Side/admin_Login.jsp"
            );
            return;
        }

        // Retrieve students from the database
        List<Student> students = studentDAO.getAllStudents();

        // Send the list to the JSP
        request.setAttribute("students", students);

        // Display the student-management page
        request.getRequestDispatcher(
                "/3_Admin_Side/Student.jsp"
        ).forward(request, response);
    }
}
