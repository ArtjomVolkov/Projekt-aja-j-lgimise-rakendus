<?php
// Загрузка XML-файла
$xml = new DOMDocument;
$xml->load('data.xml');

// Загрузка XSLT-файла
$xslt = new DOMDocument;
$xslt->load('style.xslt');

// Создание процессора XSLT
$proc = new XSLTProcessor;
$proc->importStyleSheet($xslt);

// Преобразование XML с использованием XSLT и вывод результата
echo $proc->transformToXML($xml);

