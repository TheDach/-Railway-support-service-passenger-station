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
    const rows = document.querySelectorAll('#hover_effect tr');
    rows.forEach(r => r.classList.remove('selected'));

    // Добавляем класс 'selected' к текущей строке
    row.classList.add('selected');

    document.getElementById('passengerIdToDelete').value = id;
    document.getElementById('passengerIdToEdit').value = id;
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
