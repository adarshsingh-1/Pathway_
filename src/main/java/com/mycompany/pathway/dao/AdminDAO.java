package com.mycompany.pathway.dao;

import com.mycompany.pathway.model.Admin;
import com.mycompany.pathway.util.DBConnection;

import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.security.spec.KeySpec;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.Base64;
import java.util.Locale;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class AdminDAO {

    private static final int ITERATIONS = 210000;
    private static final int KEY_LENGTH = 256;
    private static final int SALT_LENGTH = 16;

    private static final SecureRandom RANDOM = new SecureRandom();

    // REGISTER ADMIN
    public boolean registerAdmin(Admin admin)
            throws SQLException, GeneralSecurityException {

        if (admin == null
                || admin.getName() == null
                || admin.getEmail() == null
                || admin.getPasswordHash() == null) {

            throw new IllegalArgumentException(
                    "Admin details are required."
            );
        }

        String fullName = admin.getName().trim();
        String email = admin.getEmail().trim()
                .toLowerCase(Locale.ROOT);
        String password = admin.getPasswordHash();

        if (fullName.isEmpty() || email.isEmpty()
                || password.isEmpty()) {

            throw new IllegalArgumentException(
                    "Name, email, and password cannot be empty."
            );
        }

        String hashedPassword = hashPassword(password);

        String sql =
                "INSERT INTO admins (full_name, email, password) "
                + "VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, hashedPassword);

            return ps.executeUpdate() > 0;
        }
    }

    // LOGIN ADMIN
    public Admin loginAdmin(String email, String password)
            throws SQLException, GeneralSecurityException {

        String sql =
                "SELECT admin_id, full_name, email, password "
                + "FROM admins WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(
                    1,
                    email.trim().toLowerCase(Locale.ROOT)
            );

            try (ResultSet rs = ps.executeQuery()) {

                if (!rs.next()) {
                    return null;
                }

                String storedPassword = rs.getString("password");

                if (!verifyPassword(password, storedPassword)) {
                    return null;
                }

                Admin admin = new Admin();

                admin.setAdminId(rs.getInt("admin_id"));
                admin.setName(rs.getString("full_name"));
                admin.setEmail(rs.getString("email"));

                // Never put the stored password hash in the session.
                return admin;
            }
        }
    }

    // GENERATE PASSWORD HASH
    private String hashPassword(String password)
            throws GeneralSecurityException {

        byte[] salt = new byte[SALT_LENGTH];
        RANDOM.nextBytes(salt);

        byte[] hash = deriveHash(
                password,
                salt,
                ITERATIONS
        );

        return ITERATIONS + ":"
                + Base64.getEncoder().encodeToString(salt) + ":"
                + Base64.getEncoder().encodeToString(hash);
    }

    // VERIFY PASSWORD
    private boolean verifyPassword(
            String password,
            String storedPassword
    ) throws GeneralSecurityException {

        if (password == null || storedPassword == null) {
            return false;
        }

        try {
            String[] parts = storedPassword.split(":", -1);

            if (parts.length != 3) {
                return false;
            }

            int iterations = Integer.parseInt(parts[0]);

            // Reject malformed or unexpectedly expensive hash parameters.
            if (iterations < 1 || iterations > 1000000) {
                return false;
            }

            byte[] salt = Base64.getDecoder().decode(parts[1]);
            byte[] expectedHash =
                    Base64.getDecoder().decode(parts[2]);

            if (salt.length != SALT_LENGTH
                    || expectedHash.length != KEY_LENGTH / 8) {
                return false;
            }

            byte[] actualHash = deriveHash(
                    password,
                    salt,
                    iterations
            );

            return MessageDigest.isEqual(
                    expectedHash,
                    actualHash
            );

        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    // DERIVE PBKDF2 HASH
    private byte[] deriveHash(
            String password,
            byte[] salt,
            int iterations
    ) throws GeneralSecurityException {

        PBEKeySpec spec = new PBEKeySpec(
                password.toCharArray(),
                salt,
                iterations,
                KEY_LENGTH
        );

        try {
            SecretKeyFactory factory =
                    SecretKeyFactory.getInstance(
                            "PBKDF2WithHmacSHA256"
                    );

            return factory.generateSecret(spec).getEncoded();

        } finally {
            spec.clearPassword();
        }
    }
}