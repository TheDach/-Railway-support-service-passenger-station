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

@WebServlet("/BuyNewTicket")
public class BuyNewTicket extends HttpServlet {
    private Database createDatabase;

    @Override
    public void init() {
        createDatabase = new Database();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        printBuyNewTicket(request, response, getSQLLast10Race());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        String tempSQLlRequest = "";
        String chooseButton = request.getParameter("buyNewTicketForm");

        switch (chooseButton) {
            case "search": {
                String requestDepartureCity = request.getParameter("departureСity");
                String requestArrivalСity = request.getParameter("arrivalСity");

                if (requestDepartureCity != null && !requestDepartureCity.trim().isEmpty()) { // Фильтрация по городу отправления
                    tempSQLlRequest += " AND departure_station.Name_station LIKE '%" + requestDepartureCity + "%' " +
                            "AND arrival_station.Name_station LIKE '%" + requestArrivalСity + "%' ";
                }
            }
            case "add": {
                String requestNameAdd = request.getParameter("nameAdd");
                String requestSurnameAdd = request.getParameter("surnameAdd");
                String requestPatronymicAdd = request.getParameter("patronymicAdd");
                String requestPassportSeries = request.getParameter("passportSeriesAdd");
                String requestPassportNumber = request.getParameter("passportNumberAdd");
                String requestDateBirth = request.getParameter("dateBirthAdd");
                String requestGender = request.getParameter("genderAdd");
                String requestDepartmentCode = request.getParameter("departmentCodeAdd");
                String requestTrainAdd = request.getParameter("trainAdd"); // Номер вагона
                String requestTrainPlaceAdd = request.getParameter("trainPlaceAdd");
                String requestTypePlaceAdd = request.getParameter("typePlaceAdd");
                String requestPriceAdd = request.getParameter("priceAdd");
                String requestRaceIdAdd = request.getParameter("raceId"); // номер рейса

                String updateSQLRequestPassenger = "INSERT INTO passengers (FIO, Gender, Passport," +
                        " Date_birth, Department_code)" +
                        "VALUE ('" + requestSurnameAdd + " " + requestNameAdd + " " + requestPatronymicAdd +"', '" +
                        requestGender + "', '" + requestPassportSeries + " " + requestPassportNumber + "', '" + requestDateBirth + "', '" + requestDepartmentCode + ")";
                updateBuyNewTicket(updateSQLRequestPassenger);

                int newPassengerId = getLastIdSQL(); // Сразу же получаем id маршрута который только что создали
                String updateSQLRequestTicket = "INSERT INTO tickets (Railway_carriage, Place, Passenger, " +
                        " Race, Price, Type_carriage)" +
                        "VALUE ('" + requestTrainAdd + "', '" + requestTrainPlaceAdd + "', '" + newPassengerId + "', '" + requestRaceIdAdd + "', '" +
                        requestPriceAdd + "', '" + requestTypePlaceAdd + "')";
                updateBuyNewTicket(updateSQLRequestTicket);
            }
        }

        printBuyNewTicket(request, response, getSQLStandardRequest(tempSQLlRequest));
    }

    @Override
    public void destroy() {
        createDatabase.destroyDatabase();
    }

    private void printBuyNewTicket(HttpServletRequest request, HttpServletResponse response, String sqlRequest) {
        try {
            ArrayList<Helper> helperArrayList = new ArrayList<>();
            response.setContentType("text/html");

            ResultSet resultSet = createDatabase.getStatement().executeQuery(sqlRequest);
            while (resultSet.next()) {
                String Date_departure = resultSet.getString("Date_departure");
                String Date_arrival = resultSet.getString("Date_arrival");
                String Departure_station = resultSet.getString("Place_departure");
                String Arrival_station = resultSet.getString("Place_arrival");
                String Time_departure = resultSet.getString("Time_departure");
                String Time_arrival = resultSet.getString("Time_arrival");
                String Route_Count = resultSet.getString("Route_Count");
                String ID_Race = resultSet.getString("ID_Race");

                helperArrayList.add(new Helper(Departure_station, Arrival_station, Date_departure,
                        Date_arrival, Time_departure, Time_arrival, Route_Count, ID_Race));
            }
            resultSet.close();

            // Передаем список сотрудников в JSP
            request.setAttribute("helperArrayList", helperArrayList);
            // Перенаправляем на JSP
            request.getRequestDispatcher("BuyNewTicket.jsp").forward(request, response);

        } catch (ServletException | IOException | SQLException exception) {
            exception.printStackTrace();
        }
    }
    private void updateBuyNewTicket(String sqlRequest) {
        try {
            createDatabase.getStatement().executeUpdate(sqlRequest);

        } catch (SQLException exception) {
            exception.printStackTrace();
        }
    }

    private String getSQLStandardRequest(String req) {
        return  "SELECT " +
                "ID_Race, " +
                "Date_departure, " +
                "Date_arrival, " +
                "departure_station.Name_station AS Place_departure, " +
                "arrival_station.Name_station AS Place_arrival, " +
                "Time_departure, " +
                "Time_arrival, " +
                "COUNT(tickets.Race) AS Route_Count " +
                "FROM " +
                "schedules " +
                "JOIN routes ON routes.ID_Route = schedules.Route " +
                "JOIN stations AS departure_station ON routes.Place_departure = departure_station.ID_Station " +
                "JOIN stations AS arrival_station ON routes.Place_arrival = arrival_station.ID_Station " +
                "LEFT JOIN tickets ON schedules.ID_Race = tickets.Race " +
                "WHERE 1=1 " + req +
                "GROUP BY " +
                "ID_Race, " +
                "Date_departure, " +
                "Date_arrival, " +
                "departure_station.Name_station, " +
                "arrival_station.Name_station, " +
                "Time_departure, " +
                "Time_arrival;";
    }
    private String getSQLLast10Race() {
        return  "SELECT " +
                "ID_Race, " +
                "Date_departure, " +
                "Date_arrival, " +
                "departure_station.Name_station AS Place_departure, " +
                "arrival_station.Name_station AS Place_arrival, " +
                "Time_departure, " +
                "Time_arrival, " +
                "COUNT(tickets.Race) AS Route_Count " +
                "FROM schedules " +
                "JOIN routes ON routes.ID_Route = schedules.Route " +
                "JOIN stations AS departure_station ON routes.Place_departure = departure_station.ID_Station " +
                "JOIN stations AS arrival_station ON routes.Place_arrival = arrival_station.ID_Station " +
                "LEFT JOIN tickets ON schedules.ID_Race = tickets.Race " +
                "WHERE 1=1 " +
                " GROUP BY " +
                "ID_Race, " +
                "Date_departure, " +
                "Date_arrival, " +
                "departure_station.Name_station, " +
                "arrival_station.Name_station, " +
                "Time_departure, " +
                "Time_arrival " +
                "ORDER BY ID_Race DESC " +
                "LIMIT 10";
    }
    private int getLastIdSQL() {
        int newPassengerId = -1;
        try {
            String getLastIdSQL = "SELECT LAST_INSERT_ID()";
            ResultSet rs = createDatabase.getStatement().executeQuery(getLastIdSQL);

            if (rs.next()) {
                newPassengerId = rs.getInt(1); // Получаем ID_Route
            }
        } catch (SQLException exception) {
            exception.printStackTrace();
        }
        return newPassengerId;
    }
}
