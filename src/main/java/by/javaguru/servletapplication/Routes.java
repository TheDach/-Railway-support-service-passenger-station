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

@WebServlet("/Routes")
public class Routes extends HttpServlet {
    private Database createDatabase;

    @Override
    public void init() {
        createDatabase = new Database();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        printRoutes(request, response, getSQLStandardRequest());
    }

    @Override
    public void destroy() {
        createDatabase.destroyDatabase();
    }

    private void printRoutes(HttpServletRequest request, HttpServletResponse response, String sqlRequest) {
        try {
            String ID_Route;
            String Place_departure;
            String Place_arrival;

            ArrayList<Helper> helperArrayList = new ArrayList<>();

            ResultSet resultSet = createDatabase.getStatement().executeQuery(sqlRequest);
            while(resultSet.next()) {
                ID_Route =  resultSet.getString("ID_Route");
                Place_departure = resultSet.getString("Place_departure");
                Place_arrival = resultSet.getString("Place_arrival");

                helperArrayList.add(new Helper(ID_Route, Place_departure, Place_arrival));
            }

            resultSet.close();

            // Передаем список сотрудников в JSP
            request.setAttribute("helperArrayList", helperArrayList);
            // Перенаправляем на JSP
            request.getRequestDispatcher("Routes.jsp").forward(request, response);

        }catch (SQLException | ServletException | IOException exception) {
            exception.printStackTrace();
        }
    }
    private String getSQLStandardRequest() {
        return "SELECT " +
                "ID_Route, " +
                "departure_station.Name_station AS Place_departure, " +
                "arrival_station.Name_station AS Place_arrival " +
                "FROM routes " +
                "JOIN stations AS departure_station ON routes.Place_departure = departure_station.ID_Station " +
                "JOIN stations AS arrival_station ON routes.Place_arrival = arrival_station.ID_Station ";
    }
}
