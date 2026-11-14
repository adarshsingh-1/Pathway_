
package com.mycompany.pathway.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            System.getenv("Pathway_url");

    private static final String USER =
            System.getenv("Pathway_User");

    private static final String PASSWORD =
            System.getenv("Pathway_Password");

    public static Connection getConnection() throws SQLException {

        if (URL == null || URL.isBlank()
                || USER == null || USER.isBlank()
                || PASSWORD == null || PASSWORD.isBlank()) {

            throw new SQLException(
                    "Database environment variables are missing."
            );
        }

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("MySQL Driver Loaded Successfully");

            Connection con = DriverManager.getConnection(
                    URL,
                    USER,
                    PASSWORD
            );

            System.out.println("TiDB Connected Successfully!");

            return con;

        } catch (ClassNotFoundException e) {

            throw new SQLException(
                    "MySQL JDBC Driver not found.",
                    e
            );
        }
    }
}
