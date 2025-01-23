<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Расписание рейсов</title>
    <link rel="stylesheet" href="cssResurses/main.css">
    <script src="scriptResurses/schedulesScript.js" defer></script>

</head>
<body>

<div class="container">

    <!-- Кнопки -->
    <div class="rounded-button-group">
        <h1>Расписание рейсов</h1>
        <div class="button-container">
            <button onclick="openModal('addModal')">Добавить</button>
            <button onclick="openEditModal()">Изменить</button>

            <form id="deleteForm" action="Schedules" method="post">
                <input type="hidden" name="scheduleForms" value="delete">
                <input type="hidden" name="scheduleId" id="schedulesIdToDelete">
                <input type="hidden" name="routeNumberToDelete" id="routeNumberToDelete">
                <button onclick="openDeleteModal()">Удалить</button>
            </form>
            <form id="reset" action="Schedules" method="get">
                <button type="submit" value="reset">Сбросить</button>
            </form>
            <button onclick="openModal('filterModal')">Фильтр</button>
            <button class="back-button" style="background-color: #ff5733" onclick="window.location.href='index.jsp';">Главное меню</button>
        </div>
    </div>

    <!-- Окно Добавить -->
    <div id="addModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('addModal')">&times;</span>
            <h2>Добавить запись</h2>
            <form action="Schedules" method="post" class="form">
                <input type="hidden" name="scheduleForms" value="add">

                <%-- Дата  и время отправления--%>
                <div class="form-group">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <div style="flex: 1; margin-right: 10px;">
                            <label for="startDateAdd">Дата отправления:</label>
                            <input type="date" id="startDateAdd" name="startDateAdd" class="input-field">
                        </div>
                        <div style="flex: 1; margin-left: 10px;">
                            <label for="startTimeAdd">Время отправления:</label>
                            <input type="time" id="startTimeAdd" name="startTimeAdd" class="input-field">
                        </div>
                    </div>
                </div>

                <%-- Дата  и время прибытия--%>
                <div class="form-group">
                    <div style="display: flex; justify-content: space-between;">
                        <div style="flex: 1; margin-right: 10px;">
                            <label for="endDateAdd">Дата прибытия:</label>
                            <input type="date" id="endDateAdd" name="endDateAdd" class="input-field">
                        </div>
                        <div style="flex: 1; margin-left: 10px;">
                            <label for="endTimeAdd">Время прибытия:</label>
                            <input type="time" id="endTimeAdd" name="endTimeAdd" class="input-field">
                        </div>
                    </div>
                </div>

                <!-- Место отправления и прибытия -->
                <div class="form-group">
                    <label for="placeDepartureAdd">Место отправления:</label>
                    <select id="placeDepartureAdd" name="placeDepartureAdd" required class="large-select">
                        <option value="" disabled selected>Выберите должность</option>
                        <option value="1">Томск</option>
                        <option value="2">Москва</option>
                        <option value="3">Кемерово</option>
                        <option value="4">Юрга</option>
                        <option value="5">Омск</option>
                        <option value="6">Новосибирск</option>
                        <option value="7">Владивосток</option>
                        <option value="8">Симфиропль</option>
                        <option value="9">Санкт-Петербург</option>
                        <option value="10">Калининград</option>
                        <option value="11">Новгород</option>
                        <option value="12">Красноярск</option>
                        <option value="13">Чебоксары</option>
                        <option value="14">Абакан</option>
                        <option value="15">Воронеж</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="placeArrivalAdd">Место прибытия:</label>
                    <select id="placeArrivalAdd" name="placeArrivalAdd" required class="large-select">
                        <option value="" disabled selected>Выберите должность</option>
                        <option value="1">Томск</option>
                        <option value="2">Москва</option>
                        <option value="3">Кемерово</option>
                        <option value="4">Юрга</option>
                        <option value="5">Омск</option>
                        <option value="6">Новосибирск</option>
                        <option value="7">Владивосток</option>
                        <option value="8">Симфиропль</option>
                        <option value="9">Санкт-Петербург</option>
                        <option value="10">Калининград</option>
                        <option value="11">Новгород</option>
                        <option value="12">Красноярск</option>
                        <option value="13">Чебоксары</option>
                        <option value="14">Абакан</option>
                        <option value="15">Воронеж</option>
                    </select>
                </div>

                <!-- Выбор бригады -->
                <div class="form-group">
                    <label for="brigadesAdd">Выберите бригаду:</label>
                    <select id="brigadesAdd" name="brigadesAdd" class="large-select">
                        <option value="all">Все</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                    </select>
                </div>
                <!-- Выбор поезда -->
                <div class="form-group">
                    <label for="trainAdd">Выберите поезд:</label>
                    <select id="trainAdd" name="trainAdd" class="large-select">
                        <option value="all">Все</option>
                        <option value="1">Топека: грузовой </option>
                        <option value="2">СервТранс: Грузовой</option>
                        <option value="3">Ачисон: Грузовой</option>
                        <option value="4">Ласточка: Пассажирский</option>
                        <option value="5">Синара: Пассажирский</option>
                        <option value="6">Сапасн: Пассажирский</option>
                    </select>
                </div>

                <div class="button-group">
                    <button type="submit">Добавить</button>
                    <button type="reset" class="reset-button">Сбросить</button>
                </div>
            </form>
        </div>
    </div>
    <!-- Окно Изменить -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('editModal')">&times;</span>
            <h2>Изменить запись</h2>
            <form action="Schedules" method="post" class="form">
                <input type="hidden" name="scheduleForms" value="edit">
                <input type="hidden" name="scheduleId" id="schedulesIdToEdit">
                <input type="hidden" name="routeNumberToEdit" id="routeNumberToEdit">

                <%-- Дата  и время отправления--%>
                <div class="form-group">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <div style="flex: 1; margin-right: 10px;">
                            <label for="startDateEdit">Дата отправления:</label>
                            <input type="date" id="startDateEdit" name="startDateEdit" class="input-field">
                        </div>
                        <div style="flex: 1; margin-left: 10px;">
                            <label for="startTimeEdit">Время отправления:</label>
                            <input type="time" id="startTimeEdit" name="startTimeEdit" class="input-field">
                        </div>
                    </div>
                </div>

                <%-- Дата  и время прибытия--%>
                <div class="form-group">
                    <div style="display: flex; justify-content: space-between;">
                        <div style="flex: 1; margin-right: 10px;">
                            <label for="endDateEdit">Дата прибытия:</label>
                            <input type="date" id="endDateEdit" name="endDateEdit" class="input-field">
                        </div>
                        <div style="flex: 1; margin-left: 10px;">
                            <label for="endTimeEdit">Время прибытия:</label>
                            <input type="time" id="endTimeEdit" name="endTimeEdit" class="input-field">
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="placeDepartureEdit">Место отправления:</label>
                    <select id="placeDepartureEdit" name="placeDepartureEdit" required class="large-select" >
                        <option value="" disabled selected>Выберите город</option>
                        <option value="1">Томск</option>
                        <option value="2">Москва</option>
                        <option value="3">Кемерово</option>
                        <option value="4">Юрга</option>
                        <option value="5">Омск</option>
                        <option value="6">Новосибирск</option>
                        <option value="7">Владивосток</option>
                        <option value="8">Симфиропль</option>
                        <option value="9">Санкт-Петербург</option>
                        <option value="10">Калининград</option>
                        <option value="11">Новгород</option>
                        <option value="12">Красноярск</option>
                        <option value="13">Чебоксары</option>
                        <option value="14">Абакан</option>
                        <option value="15">Воронеж</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="placeArrivalEdit">Место отправления:</label>
                    <select id="placeArrivalEdit" name="placeArrivalEdit" required class="large-select">
                        <option value="" disabled selected>Выберите город</option>
                        <option value="1">Томск</option>
                        <option value="2">Москва</option>
                        <option value="3">Кемерово</option>
                        <option value="4">Юрга</option>
                        <option value="5">Омск</option>
                        <option value="6">Новосибирск</option>
                        <option value="7">Владивосток</option>
                        <option value="8">Симфиропль</option>
                        <option value="9">Санкт-Петербург</option>
                        <option value="10">Калининград</option>
                        <option value="11">Новгород</option>
                        <option value="12">Красноярск</option>
                        <option value="13">Чебоксары</option>
                        <option value="14">Абакан</option>
                        <option value="15">Воронеж</option>
                    </select>
                </div>
                <div class="button-group">
                    <button type="submit">Сохранить изменения</button>
                    <button type="reset" class="reset-button">Сбросить</button>
                </div>
            </form>
        </div>
    </div>
    <!-- Окно Фильтра -->
    <div id="filterModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('filterModal')">&times;</span>
            <h2>Фильтр рейсов</h2>
            <form id="filterForm" action="Schedules" method="post">
                <input type="hidden" name="scheduleForms" value="filter">

                <div class="form-group">
                    <label for="brigades">Выберите бригаду:</label>
                    <select id="brigades" name="brigades" class="large-select">
                        <option value="all">Все</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Выберите дату отправления:</label>
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
                    <label for="departureСity">Поиск по городам отправления:</label>
                    <input type="text" id="departureСity" name="departureСity" placeholder="Введите город" class="input-field">
                </div>
                <div class="form-group">
                    <label for="arrivalСity">Поиск по городам прибытия:</label>
                    <input type="text" id="arrivalСity" name="arrivalСity" placeholder="Введите город" class="input-field">
                </div>

                <div class="button-group">
                    <button type="submit">Фильтровать</button>
                </div>
            </form>
        </div>
    </div>

    <%-- Таблица с данными --%>
    <table border="1" style="margin: 10px auto; width: 100%;">
        <thead>
            <tr>
                <th>ID Рейса</th>
                <th>Номер Маршрута</th>
                <th>Дата Отправления</th>
                <th>Место Отправления</th>
                <th>Место Прибытия</th>
            </tr>
        </thead>
        <tbody id="hover_effect">
            <c:if test="${not empty helperArrayList}">
                <c:forEach var="schedules" items="${helperArrayList}">
                    <tr onclick="selectRow(this, ${schedules.idFirstTableField})">
                        <td><c:out value="${schedules.idFirstTableField}"/></td>
                        <td><c:out value="${schedules.idSecondTableField}"/></td>
                        <td><c:out value="${schedules.firstTableField}"/></td>
                        <td><c:out value="${schedules.fifthTableField}"/></td>
                        <td><c:out value="${schedules.sixthTableField}"/></td>
                    </tr>
                    <tr class="details">
                        <td colspan="5">
                            <div class="details-content">
                                <p><strong>Дата и Время Отправления:</strong> <c:out value="${schedules.firstTableField}"/> <c:out value="${schedules.secondTableField}"/> </p>
                                <p><strong>Дата и Время Прибытия:</strong> <c:out value="${schedules.thirdTableField}"/> <c:out value="${schedules.fourthTableField}"/></p>
                                <p>
                                    <strong>Номер Бригады:</strong>
                                    <c:out value="${schedules.idFourthTableField}"/>
                                </p>
                                <p><strong>Информация о Поезде:</strong>
                                    Поезд: <c:out value="${schedules.idSecondTableField}"/>,
                                    Тип: <c:out value="${schedules.eighthTableField}"/>,
                                    Кол-во вагонов: <c:out value="${schedules.ninthTableField}"/>
                                </p>
                                <p><strong>Количество пассажиров на маршруте:</strong> <c:out value="${schedules.idFifthTableField}"/> </p>

                                <c:set var="passengers" value="${schedules.idFifthTableField}"/>
                                <c:set var="totalSeats" value="30"/>
                                <c:set var="remainingSeats" value="${totalSeats - passengers}"/>
                                <p><strong>Оставшиеся места:</strong> <c:out value="${remainingSeats}"/></p>
                            </div>
                        </td>
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