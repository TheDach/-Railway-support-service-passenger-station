<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Маршруты</title>
    <link rel="stylesheet" href="cssResurses/main.css">
    <script src="scriptResurses/staffScript.js" defer></script>

</head>
<body>
<div class="container">

    <!-- Кнопки -->
    <div class="rounded-button-group">
        <h1>Маршруты</h1>
        <div class="button-container">
            <button class="back-button" style="background-color: #ff5733" onclick="window.location.href='index.jsp';">Главное меню</button>
        </div>
    </div>

    <!-- Основаня таблица -->
    <table border="1" style="margin: 20px auto; width: 80%;">
        <thead>
        <tr>
            <th>ID</th>
            <th>Место отправления</th>
            <th>Место прибытия</th>
        </tr>
        </thead>

        <tbody id="hover_effect">
        <c:if test="${not empty helperArrayList}">
            <c:forEach var="routes" items="${helperArrayList}">
                <tr onclick="selectRow(this, ${routes.firstTableField})">
                    <td><c:out value="${routes.firstTableField}"/></td>
                    <td><c:out value="${routes.secondTableField}"/></td>
                    <td><c:out value="${routes.thirdTableField}"/></td>
                </tr>
            </c:forEach>
        </c:if>
        <c:if test="${empty helperArrayList}">
            <tr>
                <td colspan="5">Нет данных для отображения.</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

<div style="height: 10%; background-color: #d0d0d0; text-align: center; padding: 10px;">
    <p>© 2025 Все права защищены</p>
</div>
</body>
</html>
