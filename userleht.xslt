<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name="project_id" />
    <xsl:template match="/">
        <xsl:variable name="project_name" select="/projects/project[@id = $project_id]/project_name" />
        <html>
            <head>
                <title>Отслеживание времени в проекте</title>
                <script src="script.js" type="text/javascript"></script>
                <link rel="stylesheet" type="text/css" href="style.css"/>
            </head>
            <body>
                <form method="post" action="admin.php" class="admin">
                    <label for="login">Логин:(Логин - a)</label>
                    <input type="text" id="login" name="login"/><br/>
                    <label for="password">Пароль:(Пароль - a)</label>
                    <input type="password" id="password" name="password" /><br/>
                    <input type="submit" value="Войти"/>
                </form>
                <h1>Список задач в проекте "<xsl:value-of select="$project_name"/>"</h1>
                <label for="show-confirmed">Показать только подтвержденные задачи:</label>
                <input type="checkbox" id="show-confirmed" onclick="filterTasks()"/>
                <button onclick="location.href='koduleht.php'">Вернуться к списку проектов</button>
                <table border="1">
                    <tr>
                        <th>Задача</th>
                        <th>Исполнитель</th>
                        <th>Должность</th>
                        <th>Затраченное время(в часах)</th>
                        <th>Статус</th>
                    </tr>
                    <xsl:for-each select="/projects/project[@id = $project_id]/task">
                        <tr>
                            <td><xsl:value-of select="report_id"/></td>
                            <td><xsl:value-of select="user/first_name"/> , <xsl:value-of select="user/last_name"/></td>
                            <td><xsl:value-of select="user/role"/></td>
                            <td><xsl:value-of select="entry_time"/></td>
                            <td><xsl:value-of select="status"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                <h1>Подача заявки</h1>
                <!-- Button to open the modal -->
                <button class="open-modal" onclick="openModal()">Подать заявку(для исполнителей)</button>

                <!-- Modal -->
                <div id="myModal" class="modal">
                    <div class="modal-content">
                        <!-- Form for submitting a request -->
                        <form method="post" action="userleht.php" class="add" onsubmit="return validateForm()">
                            <input type="hidden" name="project_id" value="{$project_id}"/>
                            <label for="first_name">Имя:</label>
                            <input type="text" id="first_name" name="first_name" /><br/>
                            <label for="last_name">Фамилия:</label>
                            <input type="text" id="last_name" name="last_name" /><br/>
                            <label for="role">Должность:</label>
                            <select id="role" name="role">
                                <option value="Директор">Директор</option>
                                <option value="Менеджер">Менеджер</option>
                                <option value="Разработчик">Разработчик</option>
                                <option value="Дизайнер">Дизайнер</option>
                                <option value="Тестировщик">Тестировщик</option>
                                <option value="Системный администратор">Системный администратор</option>
                                <option value="Маркетолог">Маркетолог</option>
                                <option value="Аналитик">Аналитик</option>
                                <option value="Бухгалтер">Бухгалтер</option>
                                <option value="HR-менеджер">HR-менеджер</option>
                            </select><br/>
                            <label for="profession">Профессия:</label>
                            <select id="profession" name="profession">
                                <option value="Веб-разработчик">Веб-разработчик</option>
                                <option value="Программист Java">Программист Java</option>
                                <option value="Сетевой администратор">Сетевой администратор</option>
                                <option value="Инженер технической поддержки">Инженер технической поддержки</option>
                                <option value="Системный архитектор">Системный архитектор</option>
                                <option value="Инженер по тестированию">Инженер по тестированию</option>
                                <option value="Frontend-разработчик">Frontend-разработчик</option>
                                <option value="Продукт-менеджер">Продукт-менеджер</option>
                                <option value="База данных администратор">База данных администратор</option>
                                <option value="Специалист по информационной безопасности">Специалист по информационной безопасности</option>
                                <option value="QA инженер">QA инженер</option>
                                <option value="Системный администратор Linux">Системный администратор Linux</option>
                                <option value="Графический дизайнер">Графический дизайнер</option>
                                <option value="Программист Python">Программист Python</option>
                                <option value="DevOps инженер">DevOps инженер</option>
                                <option value="Аналитик данных">Аналитик данных</option>
                                <option value="IT-консультант">IT-консультант</option>
                                <option value="Специалист по машинному обучению">Специалист по машинному обучению</option>
                                <option value="Системный администратор Windows">Системный администратор Windows</option>
                                <option value="Мобильный разработчик">Мобильный разработчик</option>
                            </select><br/>
                            <input type="submit" value="Подать заявку"/>
                        </form>
                        <!-- Button to close the modal -->
                        <button class="close-modal" onclick="closeModal()">Отмена</button>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>