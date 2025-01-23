<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Билеты</title>
    <link rel="stylesheet" href="cssResurses/main.css">
    <script src="scriptResurses/ticketsScript.js" defer></script>

</head>
<body>

<div class="container">

    <!-- Кнопки -->
    <div class="rounded-button-group">
        <h1>Билеты</h1>
        <div class="button-container">
            <form id="addForm" action="BuyNewTicket" method="get">
                <button>Купить билет</button>
            </form>
            <button onclick="openEditModal()">Изменить</button>

            <form id="deleteForm" action="Tickets" method="post">
                <input type="hidden" name="ticketForms" value="delete">
                <input type="hidden" name="ticketId" id="ticketsIdToDelete">
                <button onclick="openDeleteModal()">Удалить</button>
            </form>
            <form id="reset" action="Tickets" method="get">
                <button type="submit" value="reset">Сбросить</button>
            </form>
            <button onclick="openModal('filterModal')">Фильтр</button>
            <button class="back-button" style="background-color: #ff5733" onclick="window.location.href='index.jsp';">Главное меню</button>
        </div>
    </div>
    <!-- Окно Изменить -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('editModal')">&times;</span>
            <h2>Изменить запись</h2>
            <form action="Tickets" method="post" class="form">
                <input type="hidden" name="ticketForms" value="edit">
                <input type="hidden" name="passengerId" id="passengerToEdit">

                <div class="form-group">
                    <label for="nameAdd">Имя:</label>
                    <input type="text" id="nameAdd" name="nameAdd" required class="input-field">
                </div>
                <div class="form-group">
                    <label for="surnameAdd">Фамилия:</label>
                    <input type="text" id="surnameAdd" name="surnameAdd" required class="input-field">
                </div>
                <div class="form-group">
                    <label for="patronymicAdd">Отчество:</label>
                    <input type="text" id="patronymicAdd" name="patronymicAdd" required class="input-field">
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
            <form id="filterForm" action="Tickets" method="post">
                <input type="hidden" name="ticketForms" value="filter">

                <div class="form-group">
                    <label for="FIO">Поиск по ФИО:</label>
                    <input type="text" id="FIO" name="FIO" placeholder="Введите фамилию" class="input-field">
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
    <table border="1" style="margin: 20px auto; width: 80%;">
        <thead>
        <tr>
            <th>Номер билета</th>
            <th>Пассажир</th>
            <th>Дата отправления</th>
            <th>Место Отправления</th>
            <th>Место Прибытия</th>
        </tr>
        </thead>
        <tbody id="hover_effect">
                <c:if test="${not empty helperArrayList}">
                <c:forEach var="schedules" items="${helperArrayList}">
                    <tr onclick="selectRow(this, ${schedules.firstTableField})">
                        <td><c:out value="${schedules.firstTableField}"/></td>
                        <td><c:out value="${schedules.secondTableField}"/></td>
                        <td><c:out value="${schedules.thirdTableField}"/></td>
                        <td><c:out value="${schedules.fourthTableField}"/></td>
                        <td><c:out value="${schedules.fifthTableField}"/></td>
                    </tr>
                    <tr class="details">
                        <td colspan="5">
                            <div class="details-content">
                                <p><strong>Пассажир: </strong><br>
                                    <c:out value="${schedules.secondTableField}"/>
                                </p>
                                <p><strong>Номер поезда:</strong> <c:out value="${schedules.seventhTableField}"/>
                                    <strong>Вагон:</strong> <c:out value="${schedules.tenthTableField}"/>
                                    <strong>Место:</strong> <c:out value="${schedules.eleventhTableField}"/> : <c:out value="${schedules.twelfthTableField}"/>
                                </p>

                                <p><strong>Дата и Время Отправления:</strong><br>
                                    <c:out value="${schedules.thirdTableField}"/>
                                    <c:out value="${schedules.eighthTableField}"/>
                                </p>
                                <p><strong>Дата и Время Прибытия:</strong><br>
                                    <c:out value="${schedules.sixthTableField}"/>
                                    <c:out value="${schedules.ninthTableField}"/>
                                </p>
                                <p>
                                    <strong>Цена:</strong><br>
                                    <c:out value="${schedules.thirteenthTableField}"/>₽
                                </p>
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
