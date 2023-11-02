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
        var cell = rows[i].getElementsByTagName("td")[5]; // Индекс 5 - столбец "Статус"
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

function validateForm() {
    var firstName = document.getElementById("first_name").value;
    var lastName = document.getElementById("last_name").value;

    if (firstName === "" || lastName === "") {
        alert("Имя и фамилия не могут быть пустыми.");
        return false;
    }

    if (!/^[A-Za-zА-Яа-яЁё\s]*$/.test(firstName) || !/^[A-Za-zА-Яа-яЁё\s]*$/.test(lastName)) {
        alert("Имя и фамилия не могут содержать цифры или специальные символы.");
        return false;
    }

    return true; // Все проверки пройдены, можно отправить форму
}



