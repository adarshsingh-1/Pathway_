
package com.mycompany.pathway.dao;

import com.mycompany.pathway.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class StudentDashboardDAO {

    // 1. TOTAL APPLICATIONS OF LOGGED-IN STUDENT
    public int getTotalApplications(int studentId) {

        String sql =
                "SELECT COUNT(*) FROM applications "
                + "WHERE student_id = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Unable to get total applications.", e
            );
        }

        return 0;
    }


    // 2. SHORTLISTED APPLICATIONS OF LOGGED-IN STUDENT
    public int getShortlistedApplications(int studentId) {

        String sql =
                "SELECT COUNT(*) FROM applications "
                + "WHERE student_id = ? "
                + "AND status = 'Shortlisted'";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Unable to get shortlisted applications.", e
            );
        }

        return 0;
    }


    // 3. TOTAL OPEN OPPORTUNITIES
    // An opportunity is open if its deadline is today or in the future,
    // or if it does not have a deadline.
    public int getOpenOpportunities() {

        String sql =
                "SELECT COUNT(*) FROM opportunities "
                + "WHERE deadline IS NULL "
                + "OR deadline >= CURDATE()";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Unable to get open opportunities.", e
            );
        }

        return 0;
    }


    // 4. STUDENT PROFILE COMPLETION PERCENTAGE
    // Checks 6 optional profile fields:
    // phone, branch, passing_year, cgpa, skills, resume.
    public int getProfileCompletion(int studentId) {

        String sql =
                "SELECT "
                + "(CASE WHEN phone IS NOT NULL "
                + "AND TRIM(phone) <> '' THEN 1 ELSE 0 END) + "

                + "(CASE WHEN branch IS NOT NULL "
                + "AND TRIM(branch) <> '' THEN 1 ELSE 0 END) + "

                + "(CASE WHEN passing_year IS NOT NULL "
                + "THEN 1 ELSE 0 END) + "

                + "(CASE WHEN cgpa IS NOT NULL "
                + "THEN 1 ELSE 0 END) + "

                + "(CASE WHEN skills IS NOT NULL "
                + "AND TRIM(skills) <> '' THEN 1 ELSE 0 END) + "

                + "(CASE WHEN resume IS NOT NULL "
                + "AND TRIM(resume) <> '' THEN 1 ELSE 0 END) "
                + "AS completed_fields "

                + "FROM students WHERE student_id = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    int completedFields =
                            rs.getInt("completed_fields");

                    return Math.round(
                            (completedFields * 100.0f) / 6
                    );
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Unable to calculate profile completion.", e
            );
        }

        return 0;
    }


    // 5. TOP 3 HIGHEST-PACKAGE OPEN OPPORTUNITIES
    public List<Map<String, Object>> getTopOpportunities() {

        List<Map<String, Object>> opportunities =
                new ArrayList<>();

        String sql =
                "SELECT "
                + "o.opportunity_id, "
                + "o.job_title, "
                + "o.package_amount, "
                + "o.location, "
                + "c.company_name "

                + "FROM opportunities o "

                + "JOIN companies c "
                + "ON o.company_id = c.company_id "

                + "WHERE o.deadline IS NULL "
                + "OR o.deadline >= CURDATE() "

                + "ORDER BY o.package_amount DESC, "
                + "o.created_at DESC "

                + "LIMIT 3";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Map<String, Object> opportunity =
                        new LinkedHashMap<>();

                opportunity.put(
                        "opportunityId",
                        rs.getInt("opportunity_id")
                );

                opportunity.put(
                        "jobTitle",
                        rs.getString("job_title")
                );

                opportunity.put(
                        "companyName",
                        rs.getString("company_name")
                );

                opportunity.put(
                        "packageAmount",
                        rs.getBigDecimal("package_amount")
                );

                opportunity.put(
                        "location",
                        rs.getString("location")
                );

                opportunities.add(opportunity);
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Unable to get top opportunities.", e
            );
        }

        return opportunities;
    }


    // 6. RECENT ACTIVITY - LATEST 4 RECORDS
    // Uses existing tables only. No placement_activity table required.
    public List<Map<String, Object>> getRecentActivities(int studentId) {

        List<Map<String, Object>> activities =
                new ArrayList<>();

        String sql =

                // A. Logged-in student's shortlisted applications
                "SELECT "
                + "CONCAT(s.full_name, ' was shortlisted') AS activity_title, "
                + "CONCAT(c.company_name, ' · ', o.job_title) AS activity_description, "
                + "a.application_date AS activity_date "

                + "FROM applications a "

                + "JOIN students s "
                + "ON a.student_id = s.student_id "

                + "JOIN opportunities o "
                + "ON a.opportunity_id = o.opportunity_id "

                + "JOIN companies c "
                + "ON o.company_id = c.company_id "

                + "WHERE a.student_id = ? "
                + "AND a.status = 'Shortlisted' "

                + "UNION ALL "

                // B. Newly posted opportunities
                + "SELECT "
                + "'New opportunity posted' AS activity_title, "
                + "CONCAT(o.job_title, ' · ', c.company_name) AS activity_description, "
                + "o.created_at AS activity_date "

                + "FROM opportunities o "

                + "JOIN companies c "
                + "ON o.company_id = c.company_id "

                + "UNION ALL "

                // C. Newly registered students
                + "SELECT "
                + "'New student profile' AS activity_title, "
                + "CONCAT(s.full_name, ' joined the placement portal') AS activity_description, "
                + "s.created_at AS activity_date "

                + "FROM students s "

                + "UNION ALL "

                // D. Newly added recruiter companies
                + "SELECT "
                + "'Recruiter partnership added' AS activity_title, "
                + "CONCAT(c.company_name, ' joined the placement portal') AS activity_description, "
                + "c.created_at AS activity_date "

                + "FROM companies c "

                + "ORDER BY activity_date DESC "

                + "LIMIT 4";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Map<String, Object> activity =
                            new LinkedHashMap<>();

                    activity.put(
                            "title",
                            rs.getString("activity_title")
                    );

                    activity.put(
                            "description",
                            rs.getString("activity_description")
                    );

                    activity.put(
                            "activityDate",
                            rs.getTimestamp("activity_date")
                    );

                    activities.add(activity);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Unable to get recent activities.", e
            );
        }

        return activities;
    }
}
