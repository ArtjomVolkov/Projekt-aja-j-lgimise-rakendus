function filterTasks() {
    var checkbox = document.getElementById("show-confirmed");
    var rows = document.getElementsByTagName("tr");
    for (var i = 1; i < rows.length; i++) {
        var cell = rows[i].getElementsByTagName("td")[4]; // Индекс 4 - столбец "Статус"
        if (cell) {
            var text = cell.textContent || cell.innerText;
            if (checkbox.checked && text !== "kinnitatud") {
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
        var cell = rows[i].getElementsByTagName("td")[6]; // Индекс 5 - столбец "Статус"
        if (cell) {
            var text = cell.textContent || cell.innerText;
            if (checkbox.checked && text !== "ootab kinnitust") {
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
        alert("Ees- ja perekonnanimi ei saa olla tühi.");
        return false;
    }

    if (!/^[A-Za-zА-Яа-яЁё\s]*$/.test(firstName) || !/^[A-Za-zА-Яа-яЁё\s]*$/.test(lastName)) {
        alert("Ees- ja perekonnanimi ei tohi sisaldada numbreid ega erimärke..");
        return false;
    }

    return true; // Все проверки пройдены, можно отправить форму
}

function filterByProjectName() {
    var input, filter, table, tr, td, i, txtValue;
    input = document.getElementById("projectName");
    filter = input.value.toUpperCase();
    table = document.getElementsByTagName("table")[0];
    tr = table.getElementsByTagName("tr");

    for (i = 1; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[0];
        if (td) {
            txtValue = td.textContent || td.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}

function openModal() {
    document.getElementById('myModal').style.display = 'block';
}

function closeModal() {
    document.getElementById('myModal').style.display = 'none';
}




