<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <title>Отслеживание времени в проекте</title>
            </head>
            <body>
                <h1>Список задач в проекте</h1>
                <table border="1">
                    <tr>
                        <th>Имя задачи</th>
                        <th>Исполнитель</th>
                        <th>Затраченное время</th>
                        <th>Статус</th>
                    </tr>
                    <xsl:for-each select="/project/task">
                        <tr>
                            <td><xsl:value-of select="name"/></td>
                            <td><xsl:value-of select="user"/></td>
                            <td><xsl:value-of select="time"/></td>
                            <td><xsl:value-of select="status"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
