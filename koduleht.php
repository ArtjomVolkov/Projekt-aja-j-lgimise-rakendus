<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['new_project_name'])) {
        // Если есть POST-запрос для добавления нового проекта
        $newProjectName = $_POST['new_project_name'];

        // Загрузка JSON-файла
        $jsonData = json_decode(file_get_contents('data.json'), true);

        // Создание нового проекта
        $newProject = [
            "id" => uniqid(),
            "project_name" => $newProjectName,
        ];

        // Добавление нового проекта в массив проектов
        $jsonData["projects"][$newProject["id"]] = $newProject;

        // Сохранение обновленного JSON-файла
        file_put_contents('data.json', json_encode($jsonData));

        // Загрузка XML-файла
        $xml = new DOMDocument;
        $xml->load('data.xml');

        // Создание нового проекта в XML
        $projects = $xml->getElementsByTagName("projects")->item(0);
        $newProjectNode = $xml->createElement("project");
        $newProjectNode->setAttribute("id", $newProject["id"]);
        $newProjectNode->appendChild($xml->createElement("project_name", $newProject["project_name"]));
        $projects->appendChild($newProjectNode);

        // Сохранение обновленного XML-файла
        $xml->save('data.xml');

        header("Location: koduleht.php");
    } elseif (isset($_POST['delete_project_id'])) {
        // Если есть POST-запрос для удаления проекта
        $deleteProjectId = $_POST['delete_project_id'];

        // Загрузка JSON-файла
        $jsonData = json_decode(file_get_contents('data.json'), true);

        // Найти и удалить проект с указанным ID в JSON
        if (isset($jsonData["projects"][$deleteProjectId])) {
            unset($jsonData["projects"][$deleteProjectId]);
        }

        // Сохранение обновленного JSON-файла
        file_put_contents('data.json', json_encode($jsonData, JSON_PRETTY_PRINT));

        // Загрузка XML-файла
        $xml = new DOMDocument;
        $xml->load('data.xml');

        // Найти и удалить проект с указанным ID в XML
        $xpath = new DOMXPath($xml);
        $query = "//project[@id='$deleteProjectId']";
        $projects = $xpath->query($query);

        if ($projects->length > 0) {
            $project = $projects->item(0);
            $project->parentNode->removeChild($project);
        }

        // Сохранение обновленного XML-файла
        $xml->save('data.xml');

        header("Location: koduleht.php");
    }
}
// Загрузка XML-файла
$xml = new DOMDocument;
$xml->load('data.xml');

// Загрузка XSLT-файла для отображения всех проектов
$xsl = new DOMDocument;
$xsl->load('koduleht.xslt');

// Создание процессора XSLT
$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl);

// Преобразование XML с использованием XSLT и вывод результата
echo $proc->transformToXML($xml);
if (isset($_GET['code'])) {
    die(highlight_file(__FILE__, 1));
}
?>
