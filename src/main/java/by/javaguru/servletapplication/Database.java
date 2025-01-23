package by.javaguru.servletapplication;

import java.sql.*;

public class Database {

    private final String USER_NAME = "root";
    private final String PASSWORD = "1234";
    private final String CONNECTION_URL = "jdbc:mysql://localhost:3306/railway_transportation";
    private Connection connection;
    private Statement statement;

    public Database() {
        connection = null;
        statement = null;

        try {
            String DRIVER = "com.mysql.cj.jdbc.Driver";
            Class.forName(DRIVER);
            this.connection = DriverManager.getConnection(CONNECTION_URL, USER_NAME, PASSWORD);
            this.statement = this.connection.createStatement();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        return this.connection;
    }
    public Statement getStatement() {
        return this.statement;
    }

    public void closeConnection() {
        try {
            connection.close();
        } catch (SQLException exception) {
            exception.printStackTrace();
        }
    }
    public void closeStatement() {
        try {
            this.statement.close();
        } catch (SQLException exception) {
            exception.printStackTrace();
        }
    }
    public void destroyDatabase() {
        closeStatement();
        closeConnection();
    }
}
