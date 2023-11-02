<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <head>
                <title>Палень Администратора</title>
                <script src="script.js" type="text/javascript"></script>
                <link rel="stylesheet" type="text/css" href="style.css"/>
            </head>
            <body>
                <h1>Список задач в проекте (Администратор)</h1>
                <form action="index.php" class="back">
                    <input type="submit" value="Вернуться"/>
                </form>
                <label for="show-confirmed">Показать только не подтвержденные задачи:</label>
                <input type="checkbox" id="show-confirmed" onclick="filterTasks2()"/>
                <table border="1">
                    <tr>
                        <th>Отчет</th>
                        <th>Имя</th>
                        <th>Фамилия</th>
                        <th>Должность</th>
                        <th>Затраченное время</th>
                        <th>Статус</th>
                        <th>Профессия</th>
                        <th>Действия</th>
                    </tr>
                    <xsl:for-each select="/project/task">
                        <tr>
                            <td><xsl:value-of select="report_id"/></td>
                            <td><xsl:value-of select="user/first_name"/></td>
                            <td><xsl:value-of select="user/last_name"/></td>
                            <td><xsl:value-of select="user/role"/></td>
                            <td>
                                <xsl:choose>
                                    <xsl:when test="status='ожидает подтверждения'">
                                        <form method="post">
                                            <input type="hidden" name="report_id" value="{report_id}"/>
                                            <input type="number" name="hours" value="{entry_time}"/>
                                            <input type="submit" name="confirm" value="Подтвердить"/>
                                        </form>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <span><xsl:value-of select="entry_time"/></span>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </td>
                            <td><xsl:value-of select="status"/></td>
                            <td><xsl:value-of select="user/profession"/></td>
                            <td>
                                <form method="post">
                                    <input type="hidden" name="delete_report_id" value="{report_id}"/>
                                    <input type="submit" name="delete" value="Удалить"/>
                                </form>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
