package com.mycompany.pathway.controller;

import com.mycompany.pathway.dao.StudentDAO;
import com.mycompany.pathway.model.Student;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/update-profile")
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException {

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

        Student student = new Student();

        student.setStudentId(studentId);

        student.setFullName(
                request.getParameter("fullName")
        );

        student.setPhone(
                request.getParameter("phone")
        );

        student.setBranch(
                request.getParameter("branch")
        );

        student.setPassingYear(
                Integer.parseInt(
                        request.getParameter("passingYear")
                )
        );

        student.setCgpa(
                Double.parseDouble(
                        request.getParameter("cgpa")
                )
        );

        student.setSkills(
                request.getParameter("skills")
        );

        student.setResume(
                request.getParameter("resume")
        );

        StudentDAO studentDAO =
                new StudentDAO();

        studentDAO.updateProfile(student);

        response.sendRedirect(
                request.getContextPath()
                + "/student-profile"
        );
    }
}