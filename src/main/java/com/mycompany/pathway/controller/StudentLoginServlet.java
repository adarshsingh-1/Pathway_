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

@WebServlet("/student-login")
public class StudentLoginServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        StudentDAO studentDAO = new StudentDAO();

        Student student =
                studentDAO.login(email, password);

        if (student != null) {

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                    "studentId",
                    student.getStudentId()
            );

            session.setAttribute(
                    "studentName",
                    student.getFullName()
            );

            response.sendRedirect(
                    request.getContextPath()
                    + "/student-dashboard"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/2_Client_Side/StudentLogin.jsp?error=invalid"
            );
        }
    }
}