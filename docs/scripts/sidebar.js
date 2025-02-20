document.addEventListener("DOMContentLoaded", function() {
    const toggleButton = document.getElementById("toggle-button");
    const sidebar = document.getElementById("sidebar");

    toggleButton.addEventListener("click", function() {
        sidebar.classList.toggle("hidden");
    });
});

