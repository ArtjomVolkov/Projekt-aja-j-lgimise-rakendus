<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <html>
            <head>
                <title>Administraatori</title>
                <script src="script.js" type="text/javascript"></script>
                <link rel="stylesheet" type="text/css" href="style.css"/>
            </head>
            <body>
                <h1>Projekti ülesannete nimekiri (administraator)</h1>
                <form action="koduleht.php" class="back">
                    <input type="submit" value="Tagasi"/>
                </form>
                <label for="projectName">Otsi projekti nime järgi:</label>
                <input type="text" id="projectName" oninput="filterByProjectName()" />
                <label for="show-confirmed">Näita ainult kinnitamata ülesandeid:</label>
                <input type="checkbox" id="show-confirmed" onclick="filterTasks2()"/>
                <table border="1">
                    <tr>
                        <th>Projekt</th>
                        <th>Aruanne</th>
                        <th>Nimi</th>
                        <th>Perenimi</th>
                        <th>Positsioon</th>
                        <th>Kulutatud aeg</th>
                        <th>Status</th>
                        <th>Amet</th>
                        <th>Meetmed</th>
                    </tr>
                    <xsl:for-each select="/projects/project/task">
                        <tr>
                            <td><xsl:value-of select="ancestor::project/project_name"/></td>
                            <td><xsl:value-of select="report_id"/></td>
                            <td><xsl:value-of select="user/first_name"/></td>
                            <td><xsl:value-of select="user/last_name"/></td>
                            <td><xsl:value-of select="user/role"/></td>
                            <td>
                                <xsl:choose>
                                    <xsl:when test="status='ootab kinnitust'">
                                        <form method="post">
                                            <input type="hidden" name="report_id" value="{report_id}"/>
                                            <input type="number" name="hours" value="{entry_time}"/>
                                            <input type="submit" name="confirm" value="Kinnita"/>
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
                                    <input type="submit" name="delete" value="Kustuta"/>
                                </form>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
