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

@WebServlet("/Tickets")
public class Tickets extends HttpServlet {

    Database createDatabase;

    @Override
    public void init() {
        createDatabase = new Database();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        printTickets(request,response, getSQLStandardRequest());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        String tempSQLlRequest = getSQLStandardRequest();
        String chooseButton = request.getParameter("ticketForms");

        switch (chooseButton) {
            case "filter": { // кнопка фильтрации
                String requestFIO = request.getParameter("FIO");
                String requestStartDate = request.getParameter("startDate");
                String requestEndDate = request.getParameter("endDate");
                String requestDepartureCity = request.getParameter("departureСity");
                String requestArrivalСity = request.getParameter("arrivalСity");


                if (requestStartDate != null && !requestStartDate.trim().isEmpty() && requestEndDate != null && !requestEndDate.trim().isEmpty()) { // Фильтрация по дате отправления
                    tempSQLlRequest += " AND Date_departure BETWEEN '" + requestStartDate + "' AND '" + requestEndDate + "'";
                }
                if (requestDepartureCity != null && !requestDepartureCity.trim().isEmpty()) { // Фильтрация по городу отправления
                    tempSQLlRequest += " AND departure_station.Name_station  LIKE '%" + requestDepartureCity + "%'";
                }
                if (requestArrivalСity != null && !requestArrivalСity.trim().isEmpty()) { // Фильтрация по городу отправления
                    tempSQLlRequest += " AND arrival_station.Name_station LIKE '%" + requestArrivalСity + "%'";
                }
                if (requestFIO != null && !requestFIO.trim().isEmpty()) { // Фильтрация по ФИО
                    tempSQLlRequest += " AND FIO LIKE '%" + requestFIO + "%'";
                }
                break;
            }
            case "delete": { // Кнопка удаления записи по id
                String requestIdDeleteTicket =request.getParameter("ticketId");

                String deleteSQLRequestTicket = "DELETE FROM tickets WHERE Ticket_number = " + requestIdDeleteTicket;

                updateTickets(deleteSQLRequestTicket);
                break;
            }
            case "edit": { // Конопка редактиования данных
                String requestPassengerUpdate = request.getParameter("passengerId");
                String requestNameUpdate = request.getParameter("nameAdd");
                String requestSurnameUpdate = request.getParameter("surnameAdd");
                String requestPatronymicUpdate = request.getParameter("patronymicAdd");

                String updateSQLRequestPassengers = "UPDATE passengers SET FIO = '"
                        + requestSurnameUpdate + " " + requestNameUpdate + " " + requestPatronymicUpdate + "' " +
                        "WHERE FIO = '" + requestPassengerUpdate + "'";

                System.out.println(updateSQLRequestPassengers);
                // Обновляем таблицы
                updateTickets(updateSQLRequestPassengers);
                break;
            }
        }
        printTickets(request,response, tempSQLlRequest);
    }

    @Override
    public void destroy() {
        createDatabase.destroyDatabase();
    }

    private void printTickets(HttpServletRequest request, HttpServletResponse response, String sqlRequest) {
        try {
            ArrayList<Helper> helperArrayList = new ArrayList<>();
            ResultSet resultSet = createDatabase.getStatement().executeQuery(sqlRequest);

            while(resultSet.next()) {
                // Основная информация
                String Ticket_number = resultSet.getString("Ticket_number");
                String Passenger = resultSet.getString("FIO");
                String Place_departure = resultSet.getString("Place_departure");
                String Place_arrival = resultSet.getString("Place_arrival");
                String Date_departure = resultSet.getString("Date_departure");

                // Дополнительная информация
                String Date_arrival = resultSet.getString("Date_arrival");
                String ID_Train = resultSet.getString("ID_Train");
                String Time_departure = resultSet.getString("Time_departure");
                String Time_arrival = resultSet.getString("Time_arrival");
                String Railway_carriage = resultSet.getString("Railway_carriage");
                String Place = resultSet.getString("Place");
                String Type_carriage = resultSet.getString("Type_carriage");
                String Price = resultSet.getString("Price");

                helperArrayList.add(new Helper(Ticket_number, Passenger, Date_departure, Place_departure, Place_arrival,
                        Date_arrival, ID_Train, Time_departure, Time_arrival, Railway_carriage, Place, Type_carriage, Price));
            }

            resultSet.close();

            // Передаем список сотрудников в JSP
            request.setAttribute("helperArrayList", helperArrayList);
            // Перенаправляем на JSP
            request.getRequestDispatcher("Tickets.jsp").forward(request, response);


        } catch (SQLException | ServletException | IOException exception) {
            exception.printStackTrace();
        }
    }
    private void updateTickets(String sqlRequest) {
        try {
            createDatabase.getStatement().executeUpdate(sqlRequest);

        } catch (SQLException exception) {
            exception.printStackTrace();
        }
    }

    private String getSQLStandardRequest() {
        return  "SELECT " +
                "Ticket_number, " +
                "passengers.FIO, " +
                "departure_station.Name_station AS Place_departure, " +
                "arrival_station.Name_station AS Place_arrival, " +
                "schedules.Date_departure, " + // Основня информация
                "schedules.Date_arrival, " +
                "schedules.ID_Train, " +
                "Time_departure, " +
                "Time_arrival, " +
                "Railway_carriage, " +
                "Place, " +
                "Type_carriage, " +
                "Price " +
                "FROM tickets " +
                "LEFT JOIN passengers ON passengers.ID_Passenger = tickets.Passenger " +
                "JOIN schedules ON tickets.Race = schedules.ID_Race " +
                "JOIN routes ON routes.ID_Route = schedules.Route " +
                "JOIN stations AS departure_station ON routes.Place_departure = departure_station.ID_Station " +
                "JOIN stations AS arrival_station ON routes.Place_arrival = arrival_station.ID_Station " +
                "WHERE 1=1 ";
    }
}
