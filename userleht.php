<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['login']) && isset($_POST['password'])) {
    $login = $_POST['login'];
    $password = $_POST['password'];

    // Проверка правильности логина и пароля
    if ($login === 'a' && $password === 'a') {
        // Если логин и пароль правильные, переход на admin.php
        header("Location: admin.php");
        exit;
    } else {
        echo 'Error, invalid login or password';
    }
    // Добавьте здесь обработку неправильных данных, если необходимо
} else if (isset($_GET['project_id'])) {
    $project_id = $_GET['project_id'];

    // Загрузка XML-файла
    $xml = new DOMDocument;
    $xml->load('data.xml');

    // Найти проект по project_id
    $xpath = new DOMXPath($xml);
    $query = "/projects/project[@id='$project_id']";
    $project = $xpath->query($query)->item(0);

    if ($project) {
        $projectName = $project->getElementsByTagName("project_name")->item(0)->nodeValue;

        // Создание процессора XSLT
        $xsl = new DOMDocument;
        $xsl->load('userleht.xslt');
        $proc = new XSLTProcessor;
        $proc->importStyleSheet($xsl);

        // Set the 'project_id' parameter
        $proc->setParameter('', 'project_id', $project_id);

        // Преобразование XML с использованием XSLT и вывод результата
        echo $proc->transformToXML($xml);
    } else {
        // Если проект не найден, вы можете вывести сообщение об ошибке
        echo "Проект не найден.";
    }
} else {
    // Если параметр project_id не был передан, вы можете вывести сообщение о выборе проекта
    echo "Выберите проект из списка.";
}


// Если это не POST-запрос, просто отобразите страницу входа
// Загрузка XML-файла
$xml = new DOMDocument;
$xml->load('data.xml');

// Загрузка XSLT-файла
$xsl = new DOMDocument;
$xsl->load('userleht.xslt');

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['first_name'])) {
    // Загрузка XML-файла
    $xml = new DOMDocument;
    $xml->load('data.xml');

    // Получите project_id из формы
    $project_id = $_POST['project_id'];

    // Проверка, чтобы убедиться, что project_id существует и не является пустым
    if (!empty($project_id)) {
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

        // Добавление новой задачи в проект (используя переданный project_id)
        $xpath = new DOMXPath($xml);
        $query = "/projects/project[@id='$project_id']";
        $project = $xpath->query($query)->item(0);

        if ($project) {
            $project->appendChild($newTask);

            // Сохранение обновленного XML-файла
            $xml->save('data.xml');
            header("Location: userleht.php?project_id=$project_id");
        } else {
            echo "Проект не найден.";
        }
    } else {
        echo "Выберите проект из списка.";
    }
}
?>
