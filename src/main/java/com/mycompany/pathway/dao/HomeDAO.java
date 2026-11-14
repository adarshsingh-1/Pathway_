
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

public class HomeDAO {

    // Get all placement statistics for the home page
    public Map<String, Object> getPlacementStatistics()
            throws SQLException {

        Map<String, Object> statistics = new LinkedHashMap<>();

        String sql =
                "SELECT "
                + "(SELECT COUNT(*) FROM students) AS total_students, "

                + "(SELECT COUNT(*) FROM opportunities "
                + "WHERE deadline IS NULL OR deadline >= CURDATE()) "
                + "AS open_jobs, "

                + "(SELECT COUNT(DISTINCT company_id) "
                + "FROM opportunities "
                + "WHERE deadline IS NULL OR deadline >= CURDATE()) "
                + "AS recruiting_companies, "

                + "(SELECT CASE "
                + "WHEN (SELECT COUNT(*) FROM students) = 0 THEN 0 "
                + "ELSE ROUND(100.0 * "
                + "(SELECT COUNT(DISTINCT student_id) "
                + "FROM applications WHERE status = 'Selected') "
                + "/ (SELECT COUNT(*) FROM students)) "
                + "END) AS placement_rate";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            if (rs.next()) {
                statistics.put(
                        "totalStudents",
                        rs.getInt("total_students")
                );

                statistics.put(
                        "openJobs",
                        rs.getInt("open_jobs")
                );

                statistics.put(
                        "recruitingCompanies",
                        rs.getInt("recruiting_companies")
                );

                statistics.put(
                        "placementRate",
                        rs.getInt("placement_rate")
                );
            }
        }

        return statistics;
    }

    // Get maximum 8 companies currently hiring
    public List<Map<String, Object>> getHiringCompanies()
            throws SQLException {

        List<Map<String, Object>> companies = new ArrayList<>();

        String sql =
                "SELECT "
                + "c.company_id, "
                + "c.company_name, "
                + "c.location, "
                + "MAX(o.created_at) AS latest_opportunity "
                + "FROM companies c "
                + "INNER JOIN opportunities o "
                + "ON c.company_id = o.company_id "
                + "WHERE o.deadline IS NULL "
                + "OR o.deadline >= CURDATE() "
                + "GROUP BY c.company_id, c.company_name, c.location "
                + "ORDER BY latest_opportunity DESC "
                + "LIMIT 8";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Map<String, Object> company = new LinkedHashMap<>();

                String companyName = rs.getString("company_name");

                company.put(
                        "companyId",
                        rs.getInt("company_id")
                );

                company.put(
                        "companyName",
                        companyName
                );

                company.put(
                        "location",
                        rs.getString("location")
                );

                // First letter for the company card
                String initial = "?";

                if (companyName != null
                        && !companyName.trim().isEmpty()) {

                    initial = companyName.trim()
                            .substring(0, 1)
                            .toUpperCase();
                }

                company.put("initial", initial);

                companies.add(company);
            }
        }

        return companies;
    }

    // Get number of active recruiting partners
    public int getActivePartners() throws SQLException {

        String sql =
                "SELECT COUNT(DISTINCT company_id) "
                + "FROM opportunities "
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
        }

        return 0;
    }
}
