document.addEventListener("DOMContentLoaded", function() {
    const toggleButton = document.getElementById("toggle-button");
    const sidebar = document.getElementById("sidebar");
    const body = document.body; // Получаем элемент body

    toggleButton.addEventListener("click", function() {
        sidebar.classList.toggle("hidden");
        body.classList.toggle("sidebar-hidden"); // Добавляем/удаляем класс для body
    });
});
