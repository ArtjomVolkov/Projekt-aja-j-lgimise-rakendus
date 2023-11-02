<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['new_project_name'])) {
        // Если есть POST-запрос для добавления нового проекта
        $newProjectName = $_POST['new_project_name'];

        // Загрузка XML-файла
        $xml = new DOMDocument;
        $xml->load('data.xml');

        // Создание нового проекта
        $projects = $xml->getElementsByTagName("projects")->item(0);
        $newProject = $xml->createElement("project");
        $newProject->setAttribute("id", uniqid()); // Создайте уникальный ID для проекта
        $newProject->appendChild($xml->createElement("project_name", $newProjectName));
        $projects->appendChild($newProject);

        // Сохранение обновленного XML-файла
        $xml->save('data.xml');
        header("Location: projekt.php");
    } elseif (isset($_POST['delete_project_id'])) {
        // Если есть POST-запрос для удаления проекта
        $deleteProjectId = $_POST['delete_project_id'];

        // Загрузка XML-файла
        $xml = new DOMDocument;
        $xml->load('data.xml');

        // Найти и удалить проект с указанным ID
        $xpath = new DOMXPath($xml);
        $query = "//project[@id='$deleteProjectId']";
        $projects = $xpath->query($query);

        if ($projects->length > 0) {
            $project = $projects->item(0);
            $project->parentNode->removeChild($project);
        }

        // Сохранение обновленного XML-файла
        $xml->save('data.xml');
        header("Location: projekt.php");
    }
}
// Загрузка XML-файла
$xml = new DOMDocument;
$xml->load('data.xml');

// Загрузка XSLT-файла для отображения всех проектов
$xsl = new DOMDocument;
$xsl->load('projekt.xslt');

// Создание процессора XSLT
$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl);

// Преобразование XML с использованием XSLT и вывод результата
echo $proc->transformToXML($xml);
?>
