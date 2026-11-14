
package com.mycompany.pathway.dao;

import com.mycompany.pathway.modal.Company;
import com.mycompany.pathway.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CompanyDAO {

    // ==========================================
    // GET ALL COMPANIES
    // ==========================================
    public List<Company> getAllCompanies() {

        List<Company> companies = new ArrayList<>();

        String sql = "SELECT company_id, company_name, email, "
                + "location, website, description "
                + "FROM companies "
                + "ORDER BY company_id DESC";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Company company = new Company();

                company.setCompanyId(rs.getInt("company_id"));
                company.setCompanyName(rs.getString("company_name"));
                company.setContactEmail(rs.getString("email"));
                company.setLocation(rs.getString("location"));
                company.setWebsite(rs.getString("website"));
                company.setDescription(rs.getString("description"));

                companies.add(company);
            }

        } catch (SQLException e) {

            throw new RuntimeException(
                    "Failed to fetch companies from the database.", e
            );
        }

        return companies;
    }

    // ==========================================
    // ADD COMPANY
    // ==========================================
    public boolean addCompany(Company company) {

        String sql = "INSERT INTO companies "
                + "(company_name, email, location, website, description) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, company.getCompanyName());
            ps.setString(2, company.getContactEmail());
            ps.setString(3, company.getLocation());
            ps.setString(4, company.getWebsite());
            ps.setString(5, company.getDescription());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            throw new RuntimeException(
                    "Failed to insert company.", e
            );
        }
    }

    // ==========================================
    // UPDATE COMPANY
    // ==========================================
    public boolean updateCompany(Company company) {

        String sql = "UPDATE companies SET "
                + "company_name = ?, "
                + "email = ?, "
                + "location = ?, "
                + "website = ?, "
                + "description = ? "
                + "WHERE company_id = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, company.getCompanyName());
            ps.setString(2, company.getContactEmail());
            ps.setString(3, company.getLocation());
            ps.setString(4, company.getWebsite());
            ps.setString(5, company.getDescription());
            ps.setInt(6, company.getCompanyId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            throw new RuntimeException(
                    "Failed to update company.", e
            );
        }
    }

    // ==========================================
    // DELETE COMPANY
    // ==========================================
    public boolean deleteCompany(int companyId) {

        String sql = "DELETE FROM companies WHERE company_id = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, companyId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            throw new RuntimeException(
                    "Failed to delete company.", e
            );
        }
    }
}
