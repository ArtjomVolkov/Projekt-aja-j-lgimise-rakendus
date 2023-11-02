<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['login']) && isset($_POST['password'])) {
    $login = $_POST['login'];
    $password = $_POST['password'];

    // Проверка правильности логина и пароля
    if ($login === 'admin' && $password === 'admin') {
        // Если логин и пароль правильные, переход на admin.php
        header("Location: admin.php");
        exit;
    }
    else {
        alert('Error, invalid login or password');
    }
    // Добавьте здесь обработку неправильных данных, если необходимо
}


// Если это не POST-запрос, просто отобразите страницу входа
// Загрузка XML-файла
$xml = new DOMDocument;
$xml->load('data.xml');

// Загрузка XSLT-файла
$xsl = new DOMDocument;
$xsl->load('style.xslt');

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['first_name'])) {
    // Загрузка XML-файла
    $xml = new DOMDocument;
    $xml->load('data.xml');

    // Создание новой задачи в XML
    $newTask = $xml->createElement("task");

    $newUser = $xml->createElement("user");

    $newUser->appendChild($xml->createElement("first_name", $_POST['first_name']));
    $newUser->appendChild($xml->createElement("last_name", $_POST['last_name']));
    $newUser->appendChild($xml->createElement("role", $_POST['role']));
    $newUser->appendChild($xml->createElement("profession", $_POST['profession']));

    $tasks = $xml->getElementsByTagName("task");
    $reportId = $tasks->count() + 1; // Вычисляем новый report_id

    $newTask->appendChild($xml->createElement("report_id", $reportId));
    $newTask->appendChild($newUser);
    $newTask->appendChild($xml->createElement("entry_time", " "));
    $newTask->appendChild($xml->createElement("status", "ожидает подтверждения"));

    // Добавление новой задачи в проект
    $project = $xml->getElementsByTagName("project")->item(0);
    $project->appendChild($newTask);

    // Сохранение обновленного XML-файла
    $xml->save('data.xml');
    header("Location: index.php");
}

// Создание процессора XSLT
$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl);

// Преобразование XML с использованием XSLT и вывод результата
echo $proc->transformToXML($xml);
?>
