<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Список сотрудников</title>
    <link rel="stylesheet" href="cssResurses/main.css">
    <script src="scriptResurses/staffScript.js" defer></script>

</head>
<body>

<div class="container">
<!-- Кнопки -->
<div class="rounded-button-group">
    <h1>Сотрудники</h1>
    <div class="button-container">
        <button onclick="openModal('addModal')">Добавить</button>
        <button onclick="openEditModal()">Изменить</button>

        <!-- Скрытая форма для удаления записи -->
        <form id="deleteForm" action="Staff" method="post">
            <input type="hidden" name="staffForms" value="delete">
            <input type="hidden" name="staffId" id="staffIdToDelete">
            <button onclick="openDeleteModal()">Удалить</button>
        </form>
        <form id="reset" action="Staff" method="get">
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
        <h2>Фильтр сотрудников</h2>
        <form id="filterForm" action="Staff" method="post">
            <input type="hidden" name="staffForms" value="filter">

            <div class="form-group">
                <label for="post">Выберите должность:</label>
                <select id="post" name="post" class="large-select">
                    <option value="all">Все</option>
                    <option value="machinist">Машинист</option>
                    <option value="conductor">Проводник</option>
                </select>
            </div>

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
                <label for="surname">Поиск по фамилии:</label>
                <input type="text" id="surname" name="surname" placeholder="Введите фамилию" class="input-field">
            </div>

            <div class="button-group">
                <button type="submit">Фильтровать</button>
            </div>
        </form>
    </div>
</div>

<!-- Окно добавить -->
<div id="addModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('addModal')">&times;</span>
        <h2>Добавить запись</h2>
        <form action="Staff" method="post" class="form">
            <input type="hidden" name="staffForms" value="add">

            <div class="form-group">
                <label for="nameAdd">Имя:</label>
                <input type="text" id="nameAdd" name="nameAdd" required class="input-field">
            </div>
            <div class="form-group">
                <label for="surnameAdd">Фамилия:</label>
                <input type="text" id="surnameAdd" name="surnameAdd" required class="input-field">
            </div>
            <div class="form-group">
                <label for="postAdd">Должность:</label>
                <select id="postAdd" name="postAdd" required class="large-select">
                    <option value="" disabled selected>Выберите должность</option>
                    <option value="Machinist">Машинист</option>
                    <option value="Conductor">Проводник</option>
                </select>
            </div>
            <div class="form-group">
                <label for="brigadeAdd">Бригада:</label>
                <select id="brigadeAdd" name="brigadeAdd" required class="large-select">
                    <option value="" disabled selected>Выберите бригаду</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
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
        <form action="Staff" method="post" class="form">
            <input type="hidden" name="staffForms" value="edit">
            <input type="hidden" name="staffId" id="staffIdToEdit">

            <div class="form-group">
                <label for="nameEdit">Имя:</label>
                <input type="text" id="nameEdit" name="nameEdit" required class="input-field">
            </div>
            <div class="form-group">
                <label for="surnameEdit">Фамилия:</label>
                <input type="text" id="surnameEdit" name="surnameEdit" required class="input-field">
            </div>
            <div class="form-group">
                <label for="postEdit">Должность:</label>
                <select id="postEdit" name="postEdit" required class="large-select">
                    <option value="" disabled selected>Выберите должность</option>
                    <option value="Machinist">Машинист</option>
                    <option value="Conductor">Проводник</option>
                </select>
            </div>
            <div class="form-group">
                <label for="brigadeEdit">Бригада:</label>
                <select id="brigadeEdit" name="brigadeEdit" required class="large-select">
                    <option value="" disabled selected>Выберите бригаду</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                </select>
            </div>
            <div class="button-group">
                <button type="submit">Сохранить изменения</button>
                <button type="reset" class="reset-button">Сбросить</button>
            </div>
        </form>
    </div>
</div>

<!-- Основаня таблица -->
<table border="1" style="margin: 20px auto; width: 80%;">
    <thead>
        <tr>
            <th>ID</th>
            <th>Имя</th>
            <th>Фамилия</th>
            <th>Должность</th>
            <th>Номер бригады</th>
        </tr>
    </thead>

    <tbody id="hover_effect">
        <c:if test="${not empty helperArrayList}">
            <c:forEach var="staff" items="${helperArrayList}">
                <tr onclick="selectRow(this, ${staff.idFirstTableField})">
                    <td><c:out value="${staff.idFirstTableField}"/></td>
                    <td><c:out value="${staff.firstTableField}"/></td>
                    <td><c:out value="${staff.secondTableField}"/></td>
                    <td><c:out value="${staff.thirdTableField}"/></td>
                    <td><c:out value="${staff.fourthTableField}"/></td>
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
