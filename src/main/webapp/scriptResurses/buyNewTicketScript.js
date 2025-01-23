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
    openModal("addModal");
    const rows = document.querySelectorAll('#hover_effect tr');
    rows.forEach(r => r.classList.remove('selected'));


    // Добавляем класс 'selected' к текущей строке
    row.classList.add('selected');

    const price = getRandomNumber(400, 1200); // для указания цены в билете
    const idRace = id;

    document.getElementById('priceAdd').value = price;
    document.getElementById('raceId').value = idRace;

}

// Функция для генерации случайного числа в заданном диапазоне
function getRandomNumber(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}


