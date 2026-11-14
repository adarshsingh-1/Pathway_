package com.mycompany.pathway.controller;

import com.mycompany.pathway.dao.StudentDAO;
import com.mycompany.pathway.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/student-register")
public class StudentRegisterServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String fullName =
                request.getParameter("fullName");

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        String confirmPassword =
                request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/2_Client_Side/Acount.jsp?error=password"
            );

            return;
        }

        StudentDAO studentDAO = new StudentDAO();

        if (studentDAO.emailExists(email)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/2_Client_Side/Acount.jsp?error=email"
            );

            return;
        }

        Student student = new Student();

        student.setFullName(fullName);
        student.setEmail(email);
        student.setPassword(password);

        boolean result = studentDAO.register(student);

        if (result) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/2_Client_Side/StudentLogin.jsp?success=registered"
            );

        } else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/2_Client_Side/Acount.jsp?error=failed"
            );
        }
    }
}