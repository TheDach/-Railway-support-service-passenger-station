package by.javaguru.servletapplication;

import java.sql.*;

public class Main {

    public static void print(String text) {
        System.out.print(text);
    }

    public static void main(String[] args) throws ClassNotFoundException {
        System.out.println("Hello world!");

        String userName = "root";
        String password = "1234";
        String connectionURL = "jdbc:mysql://localhost:3306/railway_transportation";


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(connectionURL, userName, password);
            Statement statement = connection.createStatement(); // Объект для принятия запросов

            System.out.println("CONNECTED: We're connected to the database!");

            // Для запросов
            ResultSet resultSet = statement.executeQuery("select * from staff");

            print("Name " + " Surname " + " Post " + " Brigade ");
            while(resultSet.next()) {

                print("\n" + resultSet.getString(2) + " ");
                print(resultSet.getString(3) + " ");
                print(resultSet.getString(4) + " ");
                print(resultSet.getString(5) + "\n");
                print("----------------------");
            }



        } catch (SQLException e) {
            print("SQLException: " + e.getMessage());
        }
    }
}


