package by.javaguru.servletapplication;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

// Удалять билет если пользователь был удален и наоборот в целом омжно

@WebServlet("/Passengers")
public class Passengers extends HttpServlet {
    Database createDatabase;

    public void print(String string) {
        System.out.println(string);
    }

    @Override
    public void init() {
        createDatabase = new Database();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        printPassengers(request, response, getSQLStandardRequest());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {

        String tempSQLlRequest = getSQLStandardRequest();
        String chooseButton = request.getParameter("passengerForms");

        switch (chooseButton) {
            case "filter": { // кнопка фильтрации
                String requestGender = request.getParameter("gender");
                String requestStartDate = request.getParameter("startDate");
                String requestEndDate = request.getParameter("endDate");
                String requestFIO = request.getParameter("FIO");

                if (!"all".equals(requestGender)) { // Фильтрация по должности
                    tempSQLlRequest += " AND Gender = '" + requestGender + "'";
                }
                if (requestStartDate != null && !requestStartDate.trim().isEmpty() && requestEndDate != null && !requestEndDate.trim().isEmpty()) {
                    tempSQLlRequest += " AND Date_birth BETWEEN '" + requestStartDate + "' AND '" + requestEndDate + "'";
                }
                if (requestFIO != null && !requestFIO.trim().isEmpty()) { // Фильтрация по ФИО
                    tempSQLlRequest += " AND FIO LIKE '%" + requestFIO + "%'";
                }
                break;
            }
            case "delete": { // Кнопка удаления записи по id
                String requestIdDelete = request.getParameter("passengerId");

                String deleteSQLRequestPassenger = "DELETE FROM passengers WHERE ID_Passenger = " + requestIdDelete;
                String deleteSQLRequestTicket = "DELETE FROM tickets WHERE Passenger = " + requestIdDelete;

                updatePassengers(deleteSQLRequestPassenger);
                updatePassengers(deleteSQLRequestTicket);
                break;
            }
            /*case "edit": { // Конопка редактиования данных
                String requestIdUpdate = request.getParameter("staffId");
                String requestName = request.getParameter("nameEdit");
                String requestSurname = request.getParameter("surnameEdit");
                String requestPost = request.getParameter("postEdit");
                String requestBrigade = request.getParameter("brigadeEdit");

                String updateSQLRequest = "UPDATE passengers SET Name = '" + requestName + "', " +
                        "Surname = '" + requestSurname + "', " +
                        "Post = '" + requestPost + "', " +
                        "Brigade = '" + requestBrigade + "' " +
                        "WHERE ID_Passenger = '" + requestIdUpdate + "'";

                updatePassengers(updateSQLRequest);
                break;
            }*/
        }

        printPassengers(request, response, tempSQLlRequest);
    }

    @Override
    public void destroy() {
        createDatabase.destroyDatabase();
    }

    private void updatePassengers(String sqlRequest) {
        try {
            createDatabase.getStatement().executeUpdate(sqlRequest);

        } catch (SQLException exception) {
            exception.printStackTrace();
        }
    }
    private void printPassengers (HttpServletRequest request, HttpServletResponse response, String sqlRequest) {
        try {
            int ID_Passenger;
            String FIO;
            String Gender;
            String Passport;
            String Date_birth;
            String Department_code;

            ArrayList<Helper> helperArrayList = new ArrayList<>();
            response.setContentType("text/html");

            ResultSet resultSet = createDatabase.getStatement().executeQuery(sqlRequest);
            while (resultSet.next()) {

                ID_Passenger = resultSet.getInt("ID_Passenger");
                FIO = resultSet.getString("FIO");
                Gender = resultSet.getString("Gender");
                Passport = resultSet.getString("Passport");
                Date_birth = resultSet.getString("Date_birth");
                Department_code = resultSet.getString("Department_code");

                helperArrayList.add(new Helper(ID_Passenger, FIO, Gender, Passport, Date_birth, Department_code));
            }

            resultSet.close();

            // Передаем список сотрудников в JSP
            request.setAttribute("helperArrayList", helperArrayList);
            // Перенаправляем на JSP
            request.getRequestDispatcher("Passengers.jsp").forward(request, response);

        } catch (SQLException | ServletException | IOException exception) {
            exception.printStackTrace();
        }
    }

    private String getSQLStandardRequest() {
        return "select * from passengers where 1=1";
    }
}
