<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Покупка нового билета</title>
    <link rel="stylesheet" href="cssResurses/main.css">
    <script src="scriptResurses/buyNewTicketScript.js"></script>

</head>
<body>

<div class="container">

    <!-- Кнопки -->
    <div class="rounded-button-group">
        <h1>Покупка нового билета</h1>
        <div class="button-container">
            <form id="CitySearch" action="BuyNewTicket" method="post">
                <input type="hidden" name="buyNewTicketForm" value="search">

                <%--Выбор маршрута--%>
                <div class="form-group">
                    <label for="departureСity">Выберите город отправления:</label>
                    <select id="departureСity" name="departureСity" required class="large-select">
                        <option value="" disabled selected>Выберите город</option>
                        <option value="Tomsk">Томск</option>
                        <option value="Moscow">Москва</option>
                        <option value="Kemerovo">Кемерово</option>
                        <option value="Yurga">Юрга</option>
                        <option value="Omsk">Омск</option>
                        <option value="Novosibirsk">Новосибирск</option>
                        <option value="Vladivostok">Владивосток</option>
                        <option value="Simferopol">Симфиропль</option>
                        <option value="Saint-Petersburg">Санкт-Петербург</option>
                        <option value="Kaliningrad">Калининград</option>
                        <option value="Novgorod">Новгород</option>
                        <option value="Krasnoyarsk">Красноярск</option>
                        <option value="Cheboksary">Чебоксары</option>
                        <option value="Abakan">Абакан</option>
                        <option value="Voronezh">Воронеж</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="arrivalСity">Выберите город прибытия:</label>
                    <select id="arrivalСity" name="arrivalСity" required class="large-select">
                        <option value="" disabled selected>Выберите город</option>
                        <option value="Tomsk">Томск</option>
                        <option value="Moscow">Москва</option>
                        <option value="Kemerovo">Кемерово</option>
                        <option value="Yurga">Юрга</option>
                        <option value="Omsk">Омск</option>
                        <option value="Novosibirsk">Новосибирск</option>
                        <option value="Vladivostok">Владивосток</option>
                        <option value="Simferopol">Симфиропль</option>
                        <option value="Saint-Petersburg">Санкт-Петербург</option>
                        <option value="Kaliningrad">Калининград</option>
                        <option value="Novgorod">Новгород</option>
                        <option value="Krasnoyarsk">Красноярск</option>
                        <option value="Cheboksary">Чебоксары</option>
                        <option value="Abakan">Абакан</option>
                        <option value="Voronezh">Воронеж</option>
                    </select>
                </div>

                <button type="submit">Поиск</button>
            </form>

            <form id="reset" action="BuyNewTicket" method="get">
                <button type="submit" value="reset">Сбросить</button>
            </form>

            <button class="back-button" style="background-color: #ff5733" onclick="window.location.href='index.jsp';">Главное меню</button>
        </div>
    </div>
    <%--Кнока добавить--%>
    <div id="addModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('addModal')">&times;</span>
            <h2>Заполните свои данные</h2>
            <form action="BuyNewTicket" method="post" class="form">
                <input type="hidden" name="buyNewTicketForm" value="add">
                <input type="hidden" name="priceAdd" id="priceAdd">
                <input type="hidden" name="raceId" id="raceId">

                <%--Форма для записи ФИО и пол--%>
                <div>
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
                    <label for="genderAdd">Пол: </label>
                    <select id="genderAdd" name="genderAdd" class="large-select">
                        <option value="M">Мужской</option>
                        <option value="W">Женский</option>
                    </select>
                </div>
                <%--Паспортные данные--%>
                <div class="form-group">
                    <label for="nameAdd">Паспортные данные:</label><br>
                    <label for="passportSeriesAdd">Серия:</label>
                    <input type="text" id="passportSeriesAdd" name="passportSeriesAdd" required class="input-field">
                    <label for="passportNumberAdd">Номер:</label>
                    <input type="text" id="passportNumberAdd" name="passportNumberAdd" required class="input-field">
                    <label for="departmentCodeAdd">Код подразделения:</label>
                    <input type="text" id="departmentCodeAdd" name="departmentCodeAdd" required class="input-field">
                </div>
                <%--Дата рождения--%>
                <div class="form-group">
                    <div style="display: flex; justify-content: space-between;">
                        <div style="flex: 1; margin-right: 10px;">
                            <label for="dateBirthAdd">Дата рождения:</label>
                            <input type="date" id="dateBirthAdd" name="dateBirthAdd" class="input-field" required>
                        </div>
                    </div>
                </div>
                <%--Вагон и место--%>
                <div>
                    <div class="form-group">
                        <label for="trainAdd">Вагон:</label>
                        <select id="trainAdd" name="trainAdd" class="large-select">
                            <c:forEach var="i" begin="1" end="6">
                                <option value="${i}"> ${i}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="trainPlaceAdd">Место:</label>
                        <select id="trainPlaceAdd" name="trainPlaceAdd" class="large-select">
                            <c:forEach var="i" begin="1" end="30">
                                <option value="${i}"> ${i}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="typePlaceAdd">Тип места:</label>
                        <select id="typePlaceAdd" name="typePlaceAdd" class="large-select">
                            <option value="Sedentary">Сидячее</option>
                            <option value="Compartment">Купе</option>
                        </select>
                    </div>
                </div>

                <div class="button-group">
                    <button type="submit">Добавить</button>
                    <button type="reset" class="reset-button">Сбросить</button>
                </div>
            </form>
        </div>
    </div>


    <h2 style="text-align: center;">Последние новые маршруты</h2>
    <%-- Таблица с данными --%>
    <table border="1" style="margin: 20px auto; width: 80%;">
        <thead>
        <tr>
            <th>Место отправления</th>
            <th>Место прибытия</th>
            <th>Дата отправления</th>
            <th>Дата прибытия</th>
            <th>Время отправления</th>
            <th>Время прибытия</th>
            <th>Осталось билетов</th>
        </tr>
        </thead>
        <tbody id="hover_effect">
        <c:if test="${not empty helperArrayList}">
            <c:forEach var="buyNewTicket" items="${helperArrayList}">
                <tr onclick="selectRow(this, ${buyNewTicket.eighthTableField})">
                    <td><c:out value="${buyNewTicket.firstTableField}"/></td>
                    <td><c:out value="${buyNewTicket.secondTableField}"/></td>
                    <td><c:out value="${buyNewTicket.thirdTableField}"/></td>
                    <td><c:out value="${buyNewTicket.fourthTableField}"/></td>
                    <td><c:out value="${buyNewTicket.fifthTableField}"/></td>
                    <td><c:out value="${buyNewTicket.sixthTableField}"/></td>
                    <c:set var="passengers" value="${buyNewTicket.seventhTableField}"/>
                    <c:set var="totalSeats" value="30"/>
                    <c:set var="remainingSeats" value="${totalSeats - passengers}"/>
                    <td><c:out value="${remainingSeats}"/></td>
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
