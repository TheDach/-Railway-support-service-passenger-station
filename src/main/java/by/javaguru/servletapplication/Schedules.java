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

@WebServlet("/Schedules")
public class Schedules extends HttpServlet {
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
        printSchedules(request, response, getSQLStandardRequest());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        String tempSQLlRequest = "";
        String chooseButton = request.getParameter("scheduleForms");

        switch (chooseButton) {
            case "add": { // Конопка добавления новой записи
                String requestStartDateAdd = request.getParameter("startDateAdd");
                String requestEndDateAdd = request.getParameter("endDateAdd");
                String requestStartTimeAdd = request.getParameter("startTimeAdd");
                String requestEndTimeAdd = request.getParameter("endTimeAdd");
                String requestBrigadeAdd = request.getParameter("brigadesAdd");
                String requestTrainAdd = request.getParameter("trainAdd");

                String requestPlaceDepartureAdd = request.getParameter("placeDepartureAdd");
                String requestPlaceArrivalAdd = request.getParameter("placeArrivalAdd");

                String updateSQLRequestRoutes = "INSERT INTO routes (Place_departure, Place_arrival)" +
                        "VALUE ('" + requestPlaceDepartureAdd + "', '" + requestPlaceArrivalAdd + "')";
                updateSchedules(updateSQLRequestRoutes);

                int newRouteId = getLastIdSQL(); // Сразу же получаем id маршрута который только что создали
                String updateSQLRequestSchedules = "INSERT INTO schedules " +
                        "(ID_Train, Route, Brigade, Date_departure, Date_arrival, Time_departure, Time_arrival)" +
                        "VALUE ('" + requestTrainAdd + "', '"+ newRouteId + "', '" + requestBrigadeAdd + "', '" + requestStartDateAdd + "', '" +
                        requestEndDateAdd + "', '" + requestStartTimeAdd + "', '" + requestEndTimeAdd + "')";

                updateSchedules(updateSQLRequestSchedules);
                break;
            }
            case "filter": { // кнопка фильтрации
                String requestBrigade = request.getParameter("brigades");
                String requestStartDate = request.getParameter("startDate");
                String requestEndDate = request.getParameter("endDate");
                String requestDepartureCity = request.getParameter("departureСity");
                String requestArrivalСity = request.getParameter("arrivalСity");


                if (!"all".equals(requestBrigade)) {
                    tempSQLlRequest += " AND Brigade = '" + requestBrigade + "'";
                }
                if (requestStartDate != null && !requestStartDate.trim().isEmpty() && requestEndDate != null && !requestEndDate.trim().isEmpty()) {
                    tempSQLlRequest += " AND Date_departure BETWEEN '" + requestStartDate + "' AND '" + requestEndDate + "'";
                }
                if (requestDepartureCity != null && !requestDepartureCity.trim().isEmpty()) { // Фильтрация по городу отправления
                    tempSQLlRequest += " AND departure_station.Name_station LIKE '%" + requestDepartureCity + "%'";
                }
                if (requestArrivalСity != null && !requestArrivalСity.trim().isEmpty()) { // Фильтрация по городу отправления
                    tempSQLlRequest += " AND arrival_station.Name_station LIKE '%" + requestArrivalСity + "%'";
                }
                break;
            }
            case "delete": { // Кнопка удаления записи по id
                String requestIdDeleteSchedule = request.getParameter("scheduleId");
                String requestIdDeleteRoutes =request.getParameter("routeNumberToDelete");

                String deleteSQLRequestSchedule = "DELETE FROM schedules WHERE ID_Race = " + requestIdDeleteSchedule;
                String deleteSQLRequestRoutes = "DELETE FROM routes WHERE ID_Route = " + requestIdDeleteRoutes;

                updateSchedules(deleteSQLRequestSchedule);
                updateSchedules(deleteSQLRequestRoutes);
                break;
            }
            case "edit": { // Конопка редактиования данных
                String requestIdUpdate = request.getParameter("scheduleId");
                String requestStartDateEdit = request.getParameter("startDateEdit");
                String requestEndDateEdit = request.getParameter("endDateEdit");
                String requestStartTimeEdit = request.getParameter("startTimeEdit");
                String requestEndTimeEdit = request.getParameter("endTimeEdit");

                String requestIdRouteNumber = request.getParameter("routeNumberToEdit");
                String requestPlaceDepartureEdit = request.getParameter("placeDepartureEdit");
                String requestPlaceArrivalEdit = request.getParameter("placeArrivalEdit");

                String updateSQLRequestRoutes = "UPDATE routes SET Place_departure = '" + requestPlaceDepartureEdit + "', " +
                        "Place_arrival = '" + requestPlaceArrivalEdit + "' " +
                        "WHERE ID_Route = '" + requestIdRouteNumber + "'";
                String updateSQLRequestSchedules = "UPDATE schedules SET Date_departure = '" + requestStartDateEdit + "', " +
                        "Date_arrival = '" + requestEndDateEdit + "', " +
                        "Time_departure = '" + requestStartTimeEdit + "', " +
                        "Time_arrival = '" + requestEndTimeEdit + "' " +
                        "WHERE ID_Race = '" + requestIdUpdate + "'";

                // Обновляем таблицы
                updateSchedules(updateSQLRequestRoutes);
                updateSchedules(updateSQLRequestSchedules);
                break;
            }
        }

        printSchedules(request, response, getSQLStandardRequest(tempSQLlRequest));
    }

    @Override
    public void destroy() {
        createDatabase.destroyDatabase();
    }

    private void printSchedules(HttpServletRequest request, HttpServletResponse response, String sqlRequest) {
        try {
            int ID_Race;
            int Number_routes;
            int ID_Train;
            int Brigade;
            int Count_passengers;
            String Date_departure;
            String Date_arrival;
            String Time_departure;
            String Time_arrival;
            String Name_station_Place_departure;
            String Name_station_Place_arrival;
            String Type_train;
            String Number_wagons;
            String Name_trains;

            ArrayList<Helper> helperArrayList = new ArrayList<>();
            response.setContentType("text/html");

            ResultSet resultSet = createDatabase.getStatement().executeQuery(sqlRequest);
            while (resultSet.next()) {

                ID_Race = resultSet.getInt("ID_Race");
                Number_routes = resultSet.getInt("ID_Route");
                Date_departure = resultSet.getString("Date_departure");
                Date_arrival = resultSet.getString("Date_arrival");
                Name_station_Place_departure = resultSet.getString("Place_departure");
                Name_station_Place_arrival = resultSet.getString("Place_arrival");
                Time_departure = resultSet.getString("Time_departure");
                Time_arrival = resultSet.getString("Time_arrival");

                ID_Train = resultSet.getInt("ID_Train");
                Name_trains = resultSet.getString("Name");
                Type_train = resultSet.getString("Type");
                Number_wagons = resultSet.getString("Number_wagons");
                Brigade = resultSet.getInt("ID_Brigade");
                Count_passengers = resultSet.getInt("Route_Count");


                helperArrayList.add(new Helper(ID_Race, Number_routes, ID_Train, Brigade, Count_passengers, Date_departure, Time_departure,
                        Date_arrival, Time_arrival, Name_station_Place_departure, Name_station_Place_arrival,
                        Name_trains, Type_train, Number_wagons));
            }

            resultSet.close();

            // Передаем список сотрудников в JSP
            request.setAttribute("helperArrayList", helperArrayList);
            // Перенаправляем на JSP
            request.getRequestDispatcher("Schedules.jsp").forward(request, response);

        } catch (SQLException | ServletException | IOException exception) {
            exception.printStackTrace();
        }
    }
    private void updateSchedules(String sqlRequest) {
        try {
            createDatabase.getStatement().executeUpdate(sqlRequest);

        } catch (SQLException exception) {
            exception.printStackTrace();
        }
    }

    private String getSQLStandardRequest() {
        return  "SELECT " +
                "ID_Race, " +
                "routes.ID_Route, " +
                "Date_departure, " +
                "Date_arrival, " +
                "departure_station.Name_station AS Place_departure, " +
                "arrival_station.Name_station AS Place_arrival, " +
                "Time_departure, " +
                "Time_arrival, " +
                "trains.ID_Train, " +
                "trains.Name, " +
                "trains.Type, " +
                "trains.Number_wagons, " +
                "brigades.ID_Brigade, " +
                "COUNT(tickets.Race) AS Route_Count " +
                "FROM schedules " +
                "JOIN trains ON schedules.ID_Train = trains.ID_Train " +
                "JOIN brigades ON brigades.ID_Brigade = schedules.Brigade " +
                "JOIN routes ON routes.ID_Route = schedules.Route " +
                "JOIN stations AS departure_station ON routes.Place_departure = departure_station.ID_Station " +
                "JOIN stations AS arrival_station ON routes.Place_arrival = arrival_station.ID_Station " +
                "LEFT JOIN tickets ON schedules.ID_Race = tickets.Race " +
                "WHERE 1=1 " +
                "GROUP BY " +
                "ID_Race, " +
                "routes.ID_Route, " +
                "Date_departure, " +
                "Date_arrival, " +
                "departure_station.Name_station, " +
                "arrival_station.Name_station, " +
                "Time_departure, " +
                "Time_arrival, " +
                "trains.ID_Train, " +
                "trains.Name, " +
                "trains.Type, " +
                "trains.Number_wagons, " +
                "brigades.ID_Brigade ";
    }
    private String getSQLStandardRequest(String req) {
        return  "SELECT " +
                "ID_Race, " +
                "routes.ID_Route, " +
                "Date_departure, " +
                "Date_arrival, " +
                "departure_station.Name_station AS Place_departure, " +
                "arrival_station.Name_station AS Place_arrival, " +
                "Time_departure, " +
                "Time_arrival, " +
                "trains.ID_Train, " +
                "trains.Name, " +
                "trains.Type, " +
                "trains.Number_wagons, " +
                "brigades.ID_Brigade, " +
                "COUNT(tickets.Race) AS Route_Count " +
                "FROM schedules " +
                "JOIN trains ON schedules.ID_Train = trains.ID_Train " +
                "JOIN brigades ON brigades.ID_Brigade = schedules.Brigade " +
                "JOIN routes ON routes.ID_Route = schedules.Route " +
                "JOIN stations AS departure_station ON routes.Place_departure = departure_station.ID_Station " +
                "JOIN stations AS arrival_station ON routes.Place_arrival = arrival_station.ID_Station " +
                "LEFT JOIN tickets ON schedules.ID_Race = tickets.Race " +
                "WHERE 1=1 " + req +
                " GROUP BY " +
                "ID_Race, " +
                "routes.ID_Route, " +
                "Date_departure, " +
                "Date_arrival, " +
                "departure_station.Name_station, " +
                "arrival_station.Name_station, " +
                "Time_departure, " +
                "Time_arrival, " +
                "trains.ID_Train, " +
                "trains.Name, " +
                "trains.Type, " +
                "trains.Number_wagons, " +
                "brigades.ID_Brigade ";
    }
    private String getSQLStaffRequest(String brigadeID) {
        return  "SELECT staff.Name, staff.Surname, staff.Post, brigades.ID_Brigade " +
                "FROM staff " +
                "JOIN brigades ON staff.Brigade = brigades.ID_Brigade " +
                "JOIN schedules ON schedules.Brigade = brigades.ID_Brigade " +
                "WHERE brigades.ID_Brigade = '" + brigadeID + "' " +
                "GROUP BY staff.Name, staff.Surname, staff.Post, brigades.ID_Brigade;";
    }

    private int getLastIdSQL() {
        int newRouteId = -1;
        try {
            String getLastIdSQL = "SELECT LAST_INSERT_ID()";
            ResultSet rs = createDatabase.getStatement().executeQuery(getLastIdSQL);

            if (rs.next()) {
                newRouteId = rs.getInt(1); // Получаем ID_Route
            }
        } catch (SQLException exception) {
            exception.printStackTrace();
        }
        return newRouteId;
    }
}
