<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Пассажиры</title>

    <link rel="stylesheet" href="cssResurses/main.css">
    <script src="scriptResurses/passengersScript.js" defer></script>

</head>
<body>
<div class="container">
<!-- Кнопки -->
<div class="rounded-button-group">
    <h1>Пассажиры</h1>
    <div class="button-container">
        <%--<button onclick="openEditModal()">Изменить</button>--%>

        <!-- Скрытая форма для удаления записи -->
        <form id="deleteForm" action="Passengers" method="post">
            <input type="hidden" name="passengerForms" value="delete">
            <input type="hidden" name="passengerId" id="passengerIdToDelete">
            <button onclick="openDeleteModal()">Удалить</button>
        </form>
        <form id="reset" action="Passengers" method="get">
            <button type="submit" value="reset">Сбросить</button>
        </form>
        <button onclick="openModal('filterModal')">Фильтр</button>
            <button class="back-button" style="background-color: #ff5733" onclick="window.location.href='index.jsp';">Главное меню</button>
    </div>
</div>

<!-- Модальные окна -->
<!-- Окно фильтра -->
    <div id="filterModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('filterModal')">&times;</span>
            <h2>Фильтр пассажиров</h2>
            <form id="filterForm" action="Passengers" method="post">
                <input type="hidden" name="passengerForms" value="filter">

                <div class="form-group">
                    <label for="gender">Выберите пол:</label>
                    <select id="gender" name="gender" class="large-select">
                        <option value="all">Все</option>
                        <option value="W">Женский</option>
                        <option value="M">Мужской</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Выберите дату рождения:</label>
                    <div style="display: flex; justify-content: space-between;">
                        <div style="flex: 1; margin-right: 10px;">
                            <label for="startDate">От:</label>
                            <input type="date" id="startDate" name="startDate" class="input-field">
                        </div>
                        <div style="flex: 1;">
                            <label for="endDate">До:</label>
                            <input type="date" id="endDate" name="endDate" class="input-field">
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="FIO">Поиск по ФИО:</label>
                    <input type="text" id="FIO" name="FIO" placeholder="Введите фамилию" class="input-field">
                </div>

                <div class="button-group">
                    <button type="submit">Фильтровать</button>
                </div>
            </form>
        </div>
    </div>


<!-- Отрисовка таблицы -->
<table border="1" style="margin: 20px auto; width: 80%;">
    <thead>
        <tr>
            <th>ID</th>
            <th>ФИО</th>
            <th>Пол</th>
            <th>Паспорт</th>
            <th>Дата рождения</th>
            <th>Код подразделения</th>
        </tr>
    </thead>

    <tbody id="hover_effect">
        <c:if test="${not empty helperArrayList}">
            <c:forEach var="passenger" items="${helperArrayList}">
                <tr onclick="selectRow(this, ${passenger.idFirstTableField})">
                    <td><c:out value="${passenger.idFirstTableField}"/></td>
                    <td><c:out value="${passenger.firstTableField}"/></td>
                    <td><c:out value="${passenger.secondTableField}"/></td>
                    <td><c:out value="${passenger.thirdTableField}"/></td>
                    <td><c:out value="${passenger.fourthTableField}"/></td>
                    <td><c:out value="${passenger.fifthTableField}"/></td>
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
