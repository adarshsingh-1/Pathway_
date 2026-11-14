package com.mycompany.pathway.dao;

import com.mycompany.pathway.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.LinkedHashMap;
import java.util.HashMap;

public class AdminDashboardDAO {

    // 1. TOTAL STUDENTS
    public int getTotalStudents() throws SQLException {
        return getCount("SELECT COUNT(*) FROM students");
    }

    // 2. TOTAL COMPANIES
    public int getTotalCompanies() throws SQLException {
        return getCount("SELECT COUNT(*) FROM companies");
    }

    // 3. TOTAL OPPORTUNITIES
    public int getTotalOpportunities() throws SQLException {
        return getCount("SELECT COUNT(*) FROM opportunities");
    }

    // 4. TOTAL APPLICATIONS
    public int getTotalApplications() throws SQLException {
        return getCount("SELECT COUNT(*) FROM applications");
    }

    // 5. NEW STUDENTS THIS WEEK
    public int getNewStudentsThisWeek() throws SQLException {

        String sql
                = "SELECT COUNT(*) FROM students "
                + "WHERE YEARWEEK(created_at, 1) = YEARWEEK(CURDATE(), 1)";

        return getCount(sql);
    }

    // 6. NEW COMPANIES THIS MONTH
    public int getNewCompaniesThisMonth() throws SQLException {

        String sql
                = "SELECT COUNT(*) FROM companies "
                + "WHERE YEAR(created_at) = YEAR(CURDATE()) "
                + "AND MONTH(created_at) = MONTH(CURDATE())";

        return getCount(sql);
    }

    // 7. OPPORTUNITIES CLOSING IN THE NEXT 7 DAYS
    public int getOpportunitiesClosingSoon() throws SQLException {

        String sql
                = "SELECT COUNT(*) FROM opportunities "
                + "WHERE deadline >= CURDATE() "
                + "AND deadline < DATE_ADD(CURDATE(), INTERVAL 8 DAY)";

        return getCount(sql);
    }

    // 8. NUMBER OF STUDENTS SELECTED
    public int getSelectedStudentsCount() throws SQLException {

        String sql
                = "SELECT COUNT(DISTINCT student_id) "
                + "FROM applications WHERE status = 'Selected'";

        return getCount(sql);
    }

    // 9. PLACEMENT RATE
    public double getPlacementRate() throws SQLException {

        int totalStudents = getTotalStudents();

        if (totalStudents == 0) {
            return 0.0;
        }

        int selectedStudents = getSelectedStudentsCount();

        return (selectedStudents * 100.0) / totalStudents;
    }

    // 10. MONTHLY APPLICATION STATUS GRAPH
    public Map<String, List<Integer>> getMonthlyApplicationStats()
            throws SQLException {

        Map<String, List<Integer>> monthlyStats
                = new LinkedHashMap<>();

        // Initialize 12 months with zero values.
        monthlyStats.put("applications", new ArrayList<>());
        monthlyStats.put("interviewed", new ArrayList<>());
        monthlyStats.put("selected", new ArrayList<>());
        monthlyStats.put("rejected", new ArrayList<>());

        for (int i = 0; i < 12; i++) {

            monthlyStats.get("applications").add(0);
            monthlyStats.get("interviewed").add(0);
            monthlyStats.get("selected").add(0);
            monthlyStats.get("rejected").add(0);
        }

        String sql
                = "SELECT MONTH(application_date) AS month_no, "
                + "COUNT(*) AS applications, "
                + "SUM(CASE WHEN status = 'Interview' "
                + "THEN 1 ELSE 0 END) AS interviewed, "
                + "SUM(CASE WHEN status = 'Selected' "
                + "THEN 1 ELSE 0 END) AS selected, "
                + "SUM(CASE WHEN status = 'Rejected' "
                + "THEN 1 ELSE 0 END) AS rejected "
                + "FROM applications "
                + "WHERE application_date IS NOT NULL "
                + "AND YEAR(application_date) = YEAR(CURDATE()) "
                + "GROUP BY MONTH(application_date) "
                + "ORDER BY MONTH(application_date)";

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                int monthIndex = rs.getInt("month_no") - 1;

                // Check valid month index.
                if (monthIndex < 0 || monthIndex >= 12) {
                    continue;
                }

                monthlyStats.get("applications").set(
                        monthIndex,
                        rs.getInt("applications")
                );

                monthlyStats.get("interviewed").set(
                        monthIndex,
                        rs.getInt("interviewed")
                );

                monthlyStats.get("selected").set(
                        monthIndex,
                        rs.getInt("selected")
                );

                monthlyStats.get("rejected").set(
                        monthIndex,
                        rs.getInt("rejected")
                );
            }
        }

        return monthlyStats;
    }

    // COMMON COUNT METHOD
    private int getCount(String sql) throws SQLException {

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

            return 0;
        }
    }

    // 11. FOUR RECENT ACTIVITIES - ONE FROM EACH CATEGORY
    public List<Map<String, String>> getRecentActivities()
            throws SQLException {

        List<Map<String, String>> activities = new ArrayList<>();

        String sql
                = "SELECT * FROM ( "
                + // 1. Latest application activity
                "SELECT * FROM ( "
                + "SELECT "
                + "CASE "
                + "WHEN a.status = 'Shortlisted' THEN CONCAT(s.full_name, ' was shortlisted') "
                + "WHEN a.status = 'Interview' THEN CONCAT(s.full_name, ' moved to interview') "
                + "WHEN a.status = 'Selected' THEN CONCAT(s.full_name, ' was selected') "
                + "WHEN a.status = 'Rejected' THEN CONCAT(s.full_name, ' was rejected') "
                + "ELSE 'New student application received' "
                + "END AS activity_title, "
                + "CONCAT(c.company_name, ' · ', o.job_title) AS activity_description, "
                + "a.application_date AS activity_date "
                + "FROM applications a "
                + "JOIN students s ON a.student_id = s.student_id "
                + "JOIN opportunities o ON a.opportunity_id = o.opportunity_id "
                + "JOIN companies c ON o.company_id = c.company_id "
                + "ORDER BY a.application_date DESC "
                + "LIMIT 1 "
                + ") AS app_activity "
                + "UNION ALL "
                + // 2. Latest opportunity
                "SELECT * FROM ( "
                + "SELECT "
                + "'New opportunity posted' AS activity_title, "
                + "CONCAT(o.job_title, ' · ', c.company_name) AS activity_description, "
                + "o.created_at AS activity_date "
                + "FROM opportunities o "
                + "JOIN companies c ON o.company_id = c.company_id "
                + "ORDER BY o.created_at DESC "
                + "LIMIT 1 "
                + ") AS opportunity_activity "
                + "UNION ALL "
                + // 3. Latest student registration
                "SELECT * FROM ( "
                + "SELECT "
                + "'New student profile' AS activity_title, "
                + "CONCAT(s.full_name, ' joined the placement portal') AS activity_description, "
                + "s.created_at AS activity_date "
                + "FROM students s "
                + "ORDER BY s.created_at DESC "
                + "LIMIT 1 "
                + ") AS student_activity "
                + "UNION ALL "
                + // 4. Latest company partnership
                "SELECT * FROM ( "
                + "SELECT "
                + "'Recruiter partnership added' AS activity_title, "
                + "CONCAT(c.company_name, ' is now accepting applications') AS activity_description, "
                + "c.created_at AS activity_date "
                + "FROM companies c "
                + "ORDER BY c.created_at DESC "
                + "LIMIT 1 "
                + ") AS company_activity "
                + ") AS recent_activity "
                + "WHERE activity_date IS NOT NULL "
                + "ORDER BY activity_date DESC";

        try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Map<String, String> activity = new LinkedHashMap<>();

                activity.put("title",
                        rs.getString("activity_title"));

                activity.put("description",
                        rs.getString("activity_description"));

                java.sql.Timestamp timestamp
                        = rs.getTimestamp("activity_date");

                if (timestamp != null) {
                    activity.put(
                            "date",
                            new java.text.SimpleDateFormat("dd MMM")
                                    .format(timestamp)
                    );
                } else {
                    activity.put("date", "");
                }

                activities.add(activity);
            }
        }

        return activities;
    }

}
