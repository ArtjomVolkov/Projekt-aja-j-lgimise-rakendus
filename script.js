function filterTasks() {
    var checkbox = document.getElementById("show-confirmed");
    var rows = document.getElementsByTagName("tr");
    for (var i = 1; i < rows.length; i++) {
        var cell = rows[i].getElementsByTagName("td")[4]; // Индекс 4 - столбец "Статус"
        if (cell) {
            var text = cell.textContent || cell.innerText;
            if (checkbox.checked && text !== "подтверждена") {
                rows[i].style.display = "none";
            } else {
                rows[i].style.display = "";
            }
        }
    }
}


function filterTasks2() {
    var checkbox = document.getElementById("show-confirmed");
    var rows = document.getElementsByTagName("tr");
    for (var i = 1; i < rows.length; i++) {
        var cell = rows[i].getElementsByTagName("td")[4]; // Индекс 4 - столбец "Статус"
        if (cell) {
            var text = cell.textContent || cell.innerText;
            if (checkbox.checked && text !== "ожидает подтверждения") {
                rows[i].style.display = "none";
            } else {
                rows[i].style.display = "";
            }
        }
    }
}