<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <head>
                <title>Projekti tähtaegade taotlemine.</title>
                <link rel="stylesheet" type="text/css" href="koduleht.css"/>
            </head>
            <body>
                <h1>Projekti tähtaegade taotlemine.</h1>
                <h2>Projektide nimekiri</h2>
                <ul>
                    <xsl:for-each select="/projects/project">
                        <li>
                            <a href="userleht.php?project_id={@id}">
                                <xsl:value-of select="project_name"/>
                            </a>
                        </li>
                    </xsl:for-each>
                </ul>
                <h2>Uue projekti lisamine:</h2>
                <form method="post" action="koduleht.php">
                    <label for="new_project_name">Projekti nimi:</label>
                    <input type="text" id="new_project_name" name="new_project_name"/>
                    <input type="submit" value="Lisa"/>
                </form>
                <h2>Kustuta projekt:</h2>
                <form method="post" action="koduleht.php">
                    <label for="delete_project_id">Valige kustutatav projekt:</label>
                    <select id="delete_project_id" name="delete_project_id">
                        <xsl:for-each select="/projects/project">
                            <option value="{@id}">
                                <xsl:value-of select="project_name"/>
                            </option>
                        </xsl:for-each>
                    </select>
                    <input type="submit" value="Kustuta"/>
                </form>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
