package by.javaguru.servletapplication;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/Staff")
public class Staff extends HttpServlet {
    private Database createDatabase;

    public void print(String string) {
        System.out.println(string);
    }

    @Override
    public void init() {
        // Подключение к базе данных через диспетчер драйверов
         createDatabase = new Database();
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) {
        printStaff(request, response, getSQLStandardRequest());
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) {

        String tempSQLlRequest = getSQLStandardRequest();
        String chooseButton = request.getParameter("staffForms");

        switch (chooseButton) {
            case "filter": { // кнопка фильтрации
                String requestPost = request.getParameter("post");
                String requestSurname = request.getParameter("surname");
                String requestBrigade = request.getParameter("brigades");

                if (!"all".equals(requestPost)) { // Фильтрация по должности
                    tempSQLlRequest += " AND Post = '" + requestPost + "'";
                }
                if (!"all".equals(requestBrigade)) {
                    tempSQLlRequest += " AND Brigade = '" + requestBrigade + "'";
                }
                if (requestSurname != null && !requestSurname.trim().isEmpty()) { // Фильтрация по фамилии
                    tempSQLlRequest += " AND Surname LIKE '%" + requestSurname + "%'";
                }
                break;
            }
            case "add": { // Конопка добавления новой записи
                String requestName = request.getParameter("nameAdd");
                String requestSurname = request.getParameter("surnameAdd");
                String requestPost = request.getParameter("postAdd");
                String requestBrigade = request.getParameter("brigadeAdd");

                String updateSQLRequest = "INSERT INTO staff (Name, Surname, Post, Brigade)" +
                        "VALUE ('" + requestName + "', '" + requestSurname + "', '" + requestPost + "', '" + requestBrigade + "')";

                updateStaff(updateSQLRequest);
                break;
            }
            case "delete": { // Кнопка удаления записи по id
                String requestIdDelete = request.getParameter("staffId");

                String deleteSQLRequest = "DELETE FROM staff WHERE ID_Staff = " + requestIdDelete;

                updateStaff(deleteSQLRequest);
                break;
            }
            case "edit": { // Конопка редактиования данных
                String requestIdUpdate = request.getParameter("staffId");
                String requestName = request.getParameter("nameEdit");
                String requestSurname = request.getParameter("surnameEdit");
                String requestPost = request.getParameter("postEdit");
                String requestBrigade = request.getParameter("brigadeEdit");

                String updateSQLRequest = "UPDATE staff SET Name = '" + requestName + "', " +
                        "Surname = '" + requestSurname + "', " +
                        "Post = '" + requestPost + "', " +
                        "Brigade = '" + requestBrigade + "' " +
                        "WHERE ID_Staff = '" + requestIdUpdate + "'";

                updateStaff(updateSQLRequest);
                break;
            }
        }
        printStaff(request, response, tempSQLlRequest);
    }
    @Override
        public void destroy() {
         createDatabase.destroyDatabase();
    }

    private void updateStaff(String sqlRequest) {
        try {
            createDatabase.getStatement().executeUpdate(sqlRequest);

        } catch (SQLException exception) {
            exception.printStackTrace();
        }
    }
    private void printStaff (HttpServletRequest request, HttpServletResponse response, String sqlRequest) {
        try {
            int ID_Staff;
            String Name;
            String Surname;
            String Post;
            String Brigade;

            ArrayList<Helper> helperArrayList = new ArrayList<>();
            response.setContentType("text/html");

            ResultSet resultSet = createDatabase.getStatement().executeQuery(sqlRequest);
            while (resultSet.next()) {

                ID_Staff = resultSet.getInt("ID_Staff");
                Name = resultSet.getString("Name");
                Surname = resultSet.getString("Surname");
                Post = resultSet.getString("Post");
                Brigade = resultSet.getString("Brigade");

                helperArrayList.add(new Helper(ID_Staff, Name, Surname, Post, Brigade));
            }

            resultSet.close();

            // Передаем список сотрудников в JSP
            request.setAttribute("helperArrayList", helperArrayList);
            // Перенаправляем на JSP
            request.getRequestDispatcher("Staff.jsp").forward(request, response);

        } catch (SQLException | ServletException | IOException exception) {
            exception.printStackTrace();
        }
    }
    private String getSQLStandardRequest() {
        return "select * from staff where 1=1";
    }
}
