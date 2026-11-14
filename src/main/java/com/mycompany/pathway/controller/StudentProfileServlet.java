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

@WebServlet("/student-profile")
public class StudentProfileServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null
                || session.getAttribute("studentId") == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/2_Client_Side/StudentLogin.jsp"
            );

            return;
        }

        int studentId =
                (int) session.getAttribute("studentId");

        StudentDAO studentDAO =
                new StudentDAO();

        Student student =
                studentDAO.getStudentById(studentId);

        request.setAttribute("student", student);

        request.getRequestDispatcher(
                "/2_Client_Side/student_Profile.jsp"
        ).forward(request, response);
    }
}