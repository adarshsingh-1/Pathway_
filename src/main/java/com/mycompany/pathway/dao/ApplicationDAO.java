package com.mycompany.pathway.dao;

import com.mycompany.pathway.model.Application;
import com.mycompany.pathway.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO {

    // Get total applications submitted by a student
    public int getApplicationCount(int studentId) {

        String sql
                = "SELECT COUNT(*) "
                + "FROM applications "
                + "WHERE student_id = ?";

        try (
                Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // Get pending application count for a student
    public int getPendingCount(int studentId) {

        String sql
                = "SELECT COUNT(*) "
                + "FROM applications "
                + "WHERE student_id = ? "
                + "AND status = 'Pending'";

        try (
                Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // Submit an application
    // Submit an application
    public boolean apply(int studentId, int opportunityId) {

        String sql
                = "INSERT INTO applications "
                + "(student_id, opportunity_id, status) "
                + "VALUES (?, ?, ?)";

        try (
                Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setInt(2, opportunityId);
            ps.setString(3, "Pending");

            int rowsInserted = ps.executeUpdate();

            return rowsInserted > 0;

        } catch (Exception e) {

            throw new RuntimeException(
                    "Unable to save application. Check student ID, "
                    + "opportunity ID, foreign keys and database connection.",
                    e
            );
        }
    }

    // Check whether student has already applied
    public boolean alreadyApplied(int studentId, int opportunityId) {

        String sql
                = "SELECT application_id "
                + "FROM applications "
                + "WHERE student_id = ? "
                + "AND opportunity_id = ?";

        try (
                Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setInt(2, opportunityId);

            try (ResultSet rs = ps.executeQuery()) {

                return rs.next();
            }

        } catch (Exception e) {

            throw new RuntimeException(
                    "Unable to check existing application.",
                    e
            );
        }
    }

    // Get all applications submitted by a particular student
    public List<Application> getApplicationsByStudent(int studentId) {

        List<Application> applications = new ArrayList<>();

        String sql
                = "SELECT a.application_id, "
                + "a.student_id, "
                + "a.opportunity_id, "
                + "a.application_date, "
                + "a.status, "
                + "o.job_title, "
                + "o.package_amount, "
                + "c.company_name "
                + "FROM applications a "
                + "JOIN opportunities o "
                + "ON a.opportunity_id = o.opportunity_id "
                + "JOIN companies c "
                + "ON o.company_id = c.company_id "
                + "WHERE a.student_id = ? "
                + "ORDER BY a.application_date DESC";

        try (
                Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Application application = new Application();

                    application.setApplicationId(
                            rs.getInt("application_id")
                    );

                    application.setStudentId(
                            rs.getInt("student_id")
                    );

                    application.setOpportunityId(
                            rs.getInt("opportunity_id")
                    );

                    application.setJobTitle(
                            rs.getString("job_title")
                    );

                    application.setCompanyName(
                            rs.getString("company_name")
                    );

                    application.setApplicationDate(
                            rs.getString("application_date")
                    );

                    application.setStatus(
                            rs.getString("status")
                    );

                    application.setPackageAmount(
                            rs.getDouble("package_amount")
                    );

                    applications.add(application);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return applications;
    }

    // Get all applications for the admin dashboard
    public List<Application> getAllApplications() {

        List<Application> applications = new ArrayList<>();

        String sql
                = "SELECT a.application_id, "
                + "a.student_id, "
                + "a.opportunity_id, "
                + "a.application_date, "
                + "a.status, "
                + "s.full_name, "
                + "s.email, "
                + "o.job_title, "
                + "o.package_amount, "
                + "c.company_name "
                + "FROM applications a "
                + "JOIN students s "
                + "ON a.student_id = s.student_id "
                + "JOIN opportunities o "
                + "ON a.opportunity_id = o.opportunity_id "
                + "JOIN companies c "
                + "ON o.company_id = c.company_id "
                + "ORDER BY a.application_date DESC";

        try (
                Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Application application = new Application();

                application.setApplicationId(
                        rs.getInt("application_id")
                );

                application.setStudentId(
                        rs.getInt("student_id")
                );

                application.setOpportunityId(
                        rs.getInt("opportunity_id")
                );

                application.setStudentName(
                        rs.getString("full_name")
                );

                application.setStudentEmail(
                        rs.getString("email")
                );

                application.setJobTitle(
                        rs.getString("job_title")
                );

                application.setCompanyName(
                        rs.getString("company_name")
                );

                application.setApplicationDate(
                        rs.getString("application_date")
                );

                application.setStatus(
                        rs.getString("status")
                );

                application.setPackageAmount(
                        rs.getDouble("package_amount")
                );

                applications.add(application);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return applications;
    }

    // Update an application's status from the admin dashboard
    public boolean updateApplicationStatus(
            int applicationId,
            String status
    ) {

        String sql
                = "UPDATE applications "
                + "SET status = ? "
                + "WHERE application_id = ?";

        try (
                Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, applicationId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
