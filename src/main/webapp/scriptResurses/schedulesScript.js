function toggleDetails(row) {
    // Получаем следующую строку после нажатой
    const nextRow = row.nextElementSibling;

    // Проверяем, является ли следующая строка строкой с деталями
    if (nextRow && nextRow.classList.contains('details')) {
        // Переключаем видимость строки с деталями
        if (nextRow.style.display === 'table-row') {
            nextRow.style.display = 'none'; // Скрываем
        } else {
            nextRow.style.display = 'table-row'; // Показываем
        }
    }
}


function openModal(modalId) {
    document.getElementById(modalId).style.display = "block";
}

function closeModal(modalId) {
    document.getElementById(modalId).style.display = "none";
}

// Закрытие модального окна при клике вне его
window.onclick = function(event) {
    const modals = document.getElementsByClassName("modal");
    for (let i = 0; i < modals.length; i++) {
        if (event.target == modals[i]) {
            modals[i].style.display = "none";
        }
    }
}

// для выделения строки при наведении и нажатии
function selectRow(row, id) {
    // Удаляем класс 'selected' у всех строк
    toggleDetails(row); // для развертывания информации
    const rows = document.querySelectorAll('#hover_effect tr');
    rows.forEach(r => r.classList.remove('selected'));

    // Добавляем класс 'selected' к текущей строке
    row.classList.add('selected');

    // Получаем данные из ячеек выбранной строки
    const cells = row.querySelectorAll('td');
    const scheduleIdToEdit = id; // ID для редактирования
    const scheduleIdToDelete = id; // ID для удаления
    const routeNumber = cells[1].innerText; // Предположим, что номер маршрута находится во второй ячейке

    document.getElementById('schedulesIdToDelete').value = scheduleIdToEdit;
    document.getElementById('schedulesIdToEdit').value = scheduleIdToDelete;
    document.getElementById('routeNumberToDelete').value = routeNumber;
    document.getElementById('routeNumberToEdit').value = routeNumber;
}


function openEditModal() {
    const selectedRow = document.querySelector('#hover_effect tr.selected');
    if (selectedRow) {
        openModal('editModal');
    } else {
        alert('Выберите запись для редактирования');
    }
}
function openDeleteModal() {
    const selectedRow = document.querySelector('#hover_effect tr.selected');
    if (selectedRow) {
        openModal('deleteModal');
    } else {
        alert('Выберите запись для удаления');
    }
}


