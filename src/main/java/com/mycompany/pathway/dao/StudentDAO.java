
package com.mycompany.pathway.dao;

import com.mycompany.pathway.model.Student;
import com.mycompany.pathway.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    // REGISTER STUDENT
    public boolean register(Student student) {

        String sql = "INSERT INTO students "
                + "(full_name, email, password) "
                + "VALUES (?, ?, ?)";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, student.getFullName());
            ps.setString(2, student.getEmail());
            ps.setString(3, student.getPassword());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // CHECK WHETHER EMAIL EXISTS
    public boolean emailExists(String email) {

        String sql = "SELECT student_id FROM students WHERE email = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // STUDENT LOGIN
    public Student login(String email, String password) {

        String sql = "SELECT * FROM students "
                + "WHERE email = ? AND password = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    Student student = new Student();

                    student.setStudentId(rs.getInt("student_id"));
                    student.setFullName(rs.getString("full_name"));
                    student.setEmail(rs.getString("email"));
                    student.setPhone(rs.getString("phone"));
                    student.setBranch(rs.getString("branch"));
                    student.setPassingYear(rs.getInt("passing_year"));
                    student.setCgpa(rs.getDouble("cgpa"));
                    student.setSkills(rs.getString("skills"));
                    student.setResume(rs.getString("resume"));

                    return student;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // GET STUDENT BY ID
    public Student getStudentById(int studentId) {

        String sql = "SELECT * FROM students WHERE student_id = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    Student student = new Student();

                    student.setStudentId(rs.getInt("student_id"));
                    student.setFullName(rs.getString("full_name"));
                    student.setEmail(rs.getString("email"));
                    student.setPhone(rs.getString("phone"));
                    student.setBranch(rs.getString("branch"));
                    student.setPassingYear(rs.getInt("passing_year"));
                    student.setCgpa(rs.getDouble("cgpa"));
                    student.setSkills(rs.getString("skills"));
                    student.setResume(rs.getString("resume"));

                    return student;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // UPDATE STUDENT PROFILE
    public boolean updateProfile(Student student) {

        String sql = "UPDATE students SET "
                + "full_name = ?, "
                + "phone = ?, "
                + "branch = ?, "
                + "passing_year = ?, "
                + "cgpa = ?, "
                + "skills = ?, "
                + "resume = ? "
                + "WHERE student_id = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, student.getFullName());
            ps.setString(2, student.getPhone());
            ps.setString(3, student.getBranch());
            ps.setInt(4, student.getPassingYear());
            ps.setDouble(5, student.getCgpa());
            ps.setString(6, student.getSkills());
            ps.setString(7, student.getResume());
            ps.setInt(8, student.getStudentId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // GET ALL STUDENTS FOR ADMIN
    public List<Student> getAllStudents() {

        List<Student> students = new ArrayList<>();

        String sql = "SELECT student_id, full_name, email, phone, "
                + "branch, passing_year, cgpa, skills, resume "
                + "FROM students ORDER BY student_id DESC";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Student student = new Student();

                student.setStudentId(rs.getInt("student_id"));
                student.setFullName(rs.getString("full_name"));
                student.setEmail(rs.getString("email"));
                student.setPhone(rs.getString("phone"));
                student.setBranch(rs.getString("branch"));
                student.setPassingYear(rs.getInt("passing_year"));
                student.setCgpa(rs.getDouble("cgpa"));
                student.setSkills(rs.getString("skills"));
                student.setResume(rs.getString("resume"));

                students.add(student);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return students;
    }
}
