<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <head>
                <title>Приложение для определения сроков выполнения проектов.</title>
                <link rel="stylesheet" type="text/css" href="koduleht.css"/>
            </head>
            <body>
                <h1>Приложение для определения сроков выполнения проектов.</h1>
                <h2>Список проектов</h2>
                <ul>
                    <xsl:for-each select="/projects/project">
                        <li>
                            <a href="userleht.php?project_id={@id}">
                                <xsl:value-of select="project_name"/>
                            </a>
                        </li>
                    </xsl:for-each>
                </ul>
                <h2>Добавить новый проект:</h2>
                <form method="post" action="koduleht.php">
                    <label for="new_project_name">Название проекта:</label>
                    <input type="text" id="new_project_name" name="new_project_name"/>
                    <input type="submit" value="Добавить"/>
                </form>
                <h2>Удалить проект:</h2>
                <form method="post" action="koduleht.php">
                    <label for="delete_project_id">Выберите проект для удаления:</label>
                    <select id="delete_project_id" name="delete_project_id">
                        <xsl:for-each select="/projects/project">
                            <option value="{@id}">
                                <xsl:value-of select="project_name"/>
                            </option>
                        </xsl:for-each>
                    </select>
                    <input type="submit" value="Удалить"/>
                </form>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
