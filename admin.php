<?php
// Загрузка XML-файла
$xml = new DOMDocument;
$xml->load('data.xml');

// Получите имя текущего проекта
$projectName = '';
if (isset($_GET['project_id'])) {
    $project_id = $_GET['project_id'];
    $xpath = new DOMXPath($xml);
    $query = "/projects/project[@id='$project_id']/project_name";
    $projectNameNode = $xpath->query($query)->item(0);
    if ($projectNameNode) {
        $projectName = $projectNameNode->nodeValue;
    }
}



if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['confirm'])) {
    // Если есть POST-запрос "Подтвердить", обработать подтверждение задачи
    $reportId = $_POST['report_id'];
    $hours = $_POST['hours'];

    // Найти соответствующую задачу в XML и обновить статус и время
    $xpath = new DOMXPath($xml);
    $query = "//project/task[report_id='$reportId']";
    $tasks = $xpath->query($query);

    if ($tasks->length > 0) {
        $task = $tasks->item(0);
        $task->getElementsByTagName('status')->item(0)->nodeValue = 'kinnitatud';
        $task->getElementsByTagName('entry_time')->item(0)->nodeValue = $hours;
    }
    // Сохранить обновленный XML-файл
    $xml->save('data.xml');

        // Загрузка данных из JSON-файла
        $jsonData = file_get_contents('data.json');
        $data = json_decode($jsonData, true);

        // Проверка существования задачи в JSON-данных
        foreach ($data['projects'] as &$project) {
            if (isset($project['tasks'])) {
                foreach ($project['tasks'] as &$task) {
                    if ($task['report_id'] == $reportId) {
                        $task['entry_time'] = $hours;
                        $task['status'] = 'kinnitatud';
                        break;
                    }
                }
            }
        }

        // Сохранение обновленных данных в JSON-файле
        file_put_contents('data.json', json_encode($data, JSON_PRETTY_PRINT));
    header("Location: admin.php");
}
    elseif (isset($_POST['delete_report_id'])) {
        $deleteReportId = $_POST['delete_report_id'];

        // Найти соответствующую задачу в XML и удалить её
        $xpath = new DOMXPath($xml);
        $query = "//project/task[report_id='$deleteReportId']";
        $tasks = $xpath->query($query);

        if ($tasks->length > 0) {
            $task = $tasks->item(0);
            $task->parentNode->removeChild($task);
        }

        // Сохранить обновленный XML-файл
        $xml->save('data.xml');
        // Загрузка данных из JSON-файла
        $jsonData = file_get_contents('data.json');
        $data = json_decode($jsonData, true);

        // Проверка существования задачи в JSON-данных
        foreach ($data['projects'] as &$project) {
            if (isset($project['tasks'])) {
                foreach ($project['tasks'] as $key => $task) {
                    if ($task['report_id'] == $deleteReportId) {
                        // Удаление задачи из массива задач для указанного проекта
                        unset($project['tasks'][$key]);
                        break;
                    }
                }
            }
        }

        // Сохранение обновленных данных в JSON-файле
        file_put_contents('data.json', json_encode($data, JSON_PRETTY_PRINT));
        header("Location: admin.php");
    }
    elseif (isset($_POST['edit_hours'])) {
        $reportId = $_POST['edit_report_id'];
        $newHours = $_POST['new_hours'];

        // Найти соответствующую задачу в XML и обновить "Затраченное время"
        $xpath = new DOMXPath($xml);
        $query = "//project/task[report_id='$reportId']";
        $tasks = $xpath->query($query);

        if ($tasks->length > 0) {
            $task = $tasks->item(0);
            $task->getElementsByTagName('entry_time')->item(0)->nodeValue = $newHours;
        }

        // Сохранить обновленный XML-файл
        $xml->save('data.xml');

        // Загрузка данных из JSON-файла
        $jsonData = file_get_contents('data.json');
        $data = json_decode($jsonData, true);

        // Проверка существования задачи в JSON-данных
        foreach ($data['projects'] as &$project) {
            if (isset($project['tasks'])) {
                foreach ($project['tasks'] as &$task) {
                    if ($task['report_id'] == $reportId) {
                        $task['entry_time'] = $newHours;
                        $task['status'] = 'kinnitatud';
                        break;
                    }
                }
            }
        }

        // Сохранение обновленных данных в JSON-файле
        file_put_contents('data.json', json_encode($data, JSON_PRETTY_PRINT));
        header("Location: admin.php");
    }
}

// Загрузка XSLT-файла
$xsl = new DOMDocument;
$xsl->load('admin.xslt');

// Создание процессора XSLT
$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl);
$proc->setParameter('', 'project_name', $projectName);


// Преобразование XML с использованием XSLT и вывод результата
echo $proc->transformToXML($xml);
?>
