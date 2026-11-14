package com.mycompany.pathway.dao;

import com.mycompany.pathway.modal.Opportunity;
import com.mycompany.pathway.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OpportunityDAO {

    public List<Opportunity> getAllOpportunities() {

        List<Opportunity> opportunities = new ArrayList<>();

        String sql
                = "SELECT o.*, c.company_name "
                + "FROM opportunities o "
                + "LEFT JOIN companies c "
                + "ON o.company_id = c.company_id "
                + "ORDER BY o.created_at DESC";

        try (
                Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Opportunity opportunity = new Opportunity();

                opportunity.setOpportunityId(
                        rs.getInt("opportunity_id")
                );

                opportunity.setCompanyId(
                        rs.getInt("company_id")
                );

                opportunity.setCompanyName(
                        rs.getString("company_name")
                );

                opportunity.setJobTitle(
                        rs.getString("job_title")
                );

                opportunity.setJobType(
                        rs.getString("job_type")
                );

                opportunity.setLocation(
                        rs.getString("location")
                );

                opportunity.setPackageAmount(
                        rs.getDouble("package_amount")
                );

                opportunity.setEligibilityCgpa(
                        rs.getDouble("eligibility_cgpa")
                );

                opportunity.setRequiredSkills(
                        rs.getString("required_skills")
                );

                opportunity.setDescription(
                        rs.getString("description")
                );

                opportunity.setDeadline(
                        String.valueOf(rs.getDate("deadline"))
                );

                opportunities.add(opportunity);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return opportunities;
    }

    public void updateOpportunity(Opportunity opportunity) throws java.sql.SQLException {
        String sql = "UPDATE opportunities SET "
                + "company_id = ?, "
                + "job_title = ?, "
                + "job_type = ?, "
                + "location = ?, "
                + "package_amount = ?, "
                + "eligibility_cgpa = ?, "
                + "required_skills = ?, "
                + "description = ?, "
                + "deadline = ? "
                + "WHERE opportunity_id = ?";

        try (
                Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, opportunity.getCompanyId());
            ps.setString(2, opportunity.getJobTitle());
            ps.setString(3, opportunity.getJobType());
            ps.setString(4, opportunity.getLocation());
            ps.setDouble(5, opportunity.getPackageAmount());
            ps.setDouble(6, opportunity.getEligibilityCgpa());
            ps.setString(7, opportunity.getRequiredSkills());
            ps.setString(8, opportunity.getDescription());

            if (opportunity.getDeadline() == null
                    || opportunity.getDeadline().trim().isEmpty()) {
                ps.setNull(9, java.sql.Types.DATE);
            } else {
                ps.setDate(9, java.sql.Date.valueOf(opportunity.getDeadline()));
            }

            ps.setInt(10, opportunity.getOpportunityId());

            ps.executeUpdate();
        }
    }

    public void deleteOpportunity(int opportunityId) throws java.sql.SQLException {
        String sql = "DELETE FROM opportunities WHERE opportunity_id = ?";

        try (
                Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, opportunityId);
            ps.executeUpdate();
        }
    }

    public void addOpportunity(Opportunity opportunity) throws java.sql.SQLException {

        String sql = "INSERT INTO opportunities "
                + "(company_id, job_title, job_type, location, "
                + "package_amount, eligibility_cgpa, required_skills, "
                + "description, deadline) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (
                Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, opportunity.getCompanyId());
            ps.setString(2, opportunity.getJobTitle());
            ps.setString(3, opportunity.getJobType());
            ps.setString(4, opportunity.getLocation());
            ps.setDouble(5, opportunity.getPackageAmount());
            ps.setDouble(6, opportunity.getEligibilityCgpa());
            ps.setString(7, opportunity.getRequiredSkills());
            ps.setString(8, opportunity.getDescription());

            if (opportunity.getDeadline() == null
                    || opportunity.getDeadline().trim().isEmpty()) {
                ps.setNull(9, java.sql.Types.DATE);
            } else {
                ps.setDate(
                        9,
                        java.sql.Date.valueOf(opportunity.getDeadline())
                );
            }

            ps.executeUpdate();
        }
    }
}
