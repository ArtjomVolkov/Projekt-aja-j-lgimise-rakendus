<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <head>
                <title>Отслеживание времени в проекте</title>
                <script src="script.js" type="text/javascript"></script>
                <link rel="stylesheet" type="text/css" href="style.css"/>
            </head>
            <body>
                <form method="post" action="admin.php" class="admin">
                    <label for="login">Логин:</label>
                    <input type="text" id="login" name="login"/><br/>
                    <label for="password">Пароль:</label>
                    <input type="password" id="password" name="password" /><br/>
                    <input type="submit" value="Войти"/>
                </form>
                <h1>Список задач в проекте</h1>
                <label for="show-confirmed">Показать только подтвержденные задачи:</label>
                <input type="checkbox" id="show-confirmed" onclick="filterTasks()"/>
                <table border="1">
                    <tr>
                        <th>Отчет</th>
                        <th>Исполнитель</th>
                        <th>Должность</th>
                        <th>Затраченное время(в часах)</th>
                        <th>Статус</th>
                        <th>Профессия</th>
                    </tr>
                    <xsl:for-each select="/project/task">
                        <tr>
                            <td><xsl:value-of select="report_id"/></td>
                            <td><xsl:value-of select="user/first_name"/> , <xsl:value-of select="user/last_name"/></td>
                            <td><xsl:value-of select="user/role"/></td>
                            <td><xsl:value-of select="entry_time"/></td>
                            <td><xsl:value-of select="status"/></td>
                            <td><xsl:value-of select="user/profession"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
                <h1>Подача заявки</h1>
                <form method="post" action="index.php" class="add">
                    <label for="first_name">Имя:</label>
                    <input type="text" id="first_name" name="first_name" /><br/>
                    <label for="last_name">Фамилия:</label>
                    <input type="text" id="last_name" name="last_name" /><br/>
                    <label for="role">Должность:</label>
                    <input type="text" id="role" name="role" /><br/>
                    <label for="profession">Профессия:</label>
                    <input type="text" id="profession" name="profession" /><br/>
                    <input type="submit" value="Подать заявку"/>
                </form>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>