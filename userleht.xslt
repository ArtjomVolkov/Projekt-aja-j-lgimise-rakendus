<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name="project_id" />
    <xsl:template match="/">
        <xsl:variable name="project_name" select="/projects/project[@id = $project_id]/project_name" />
        <html>
            <head>
                <title>Aja jälgimine projektis</title>
                <script src="script.js" type="text/javascript"></script>
                <link rel="stylesheet" type="text/css" href="style.css"/>
            </head>
            <body>
                <form method="post" action="admin.php" class="admin">
                    <label for="login">Login:(Login - a)</label>
                    <input type="text" id="login" name="login"/><br/>
                    <label for="password">Password:(Password - a)</label>
                    <input type="password" id="password" name="password" /><br/>
                    <input type="submit" value="Logi sisse"/>
                </form>
                <h1>Projekti ülesannete loetelu "<xsl:value-of select="$project_name"/>"</h1>
                <a href="data.xml">Ссылка на XML-файл</a>
                <br/>
                <a href="data.json">Ссылка на JSON-файл</a>
                <br/>
                <label for="show-confirmed">Näita ainult kinnitatud ülesandeid:</label>
                <input type="checkbox" id="show-confirmed" onclick="filterTasks()"/>
                <button onclick="location.href='koduleht.php'">Tagasi projektide nimekirja juurde</button>
                <table border="1">
                    <tr>
                        <th>Ülesanne</th>
                        <th>Esineja</th>
                        <th>Positsioon</th>
                        <th>Kulutatud aeg (tundides)</th>
                        <th>Staatus</th>
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
                <h1>Taotluse esitamine</h1>
                <!-- Button to open the modal -->
                <button class="open-modal" onclick="openModal()">Kandideerida (esinejatele)</button>

                <!-- Modal -->
                <div id="myModal" class="modal">
                    <div class="modal-content">
                        <!-- Form for submitting a request -->
                        <form method="post" action="userleht.php" class="add" onsubmit="return validateForm()">
                            <input type="hidden" name="project_id" value="{$project_id}"/>
                            <label for="first_name">Nimi:</label>
                            <input type="text" id="first_name" name="first_name" /><br/>
                            <label for="last_name">Perenimi:</label>
                            <input type="text" id="last_name" name="last_name" /><br/>
                            <label for="role">Positsioon:</label>
                            <select id="role" name="role">
                                <option value="Juht">Juht</option>
                                <option value="Arendaja">Arendaja</option>
                                <option value="Disainer">Disainer</option>
                                <option value="Testija">Testija</option>
                                <option value="Süsteemiadministraator">Süsteemiadministraator</option>
                                <option value="Turundaja">Turundaja</option>
                                <option value="Analüütik">Analüütik</option>
                                <option value="Raamatupidaja">Raamatupidaja</option>
                                <option value="Personalijuht">Personalijuht</option>
                            </select><br/>
                            <label for="profession">Amet:</label>
                            <select id="profession" name="profession">
                                <option value="Veebiarendaja">Veebiarendaja</option>
                                <option value="Java programmeerija">Java programmeerija</option>
                                <option value="Võrguadministraator">Võrguadministraator</option>
                                <option value="Tehnilise toe insener">Tehnilise toe insener</option>
                                <option value="Süsteemiarhitekt">Süsteemiarhitekt</option>
                                <option value="Testinsener">Testinsener</option>
                                <option value="Frontend-arendaja">Frontend-arendaja</option>
                                <option value="Produktijuht">Produktijuht</option>
                                <option value="Andmebaasiadministraator">Andmebaasiadministraator</option>
                                <option value="Infoturbe spetsialist">Infoturbe spetsialist</option>
                                <option value="QA insener">QA insener</option>
                                <option value="Linuxi süsteemiadministraator">Linuxi süsteemiadministraator</option>
                                <option value="Graafiline disainer">Graafiline disainer</option>
                                <option value="Python programmeerija">Python programmeerija</option>
                                <option value="DevOps insener">DevOps insener</option>
                                <option value="Andmeanalüütik">Andmeanalüütik</option>
                                <option value="IT-konsultant">IT-konsultant</option>
                                <option value="Machine Learning spetsialist">Machine Learning spetsialist</option>
                                <option value="Windowsi süsteemiadministraator">Windowsi süsteemiadministraator</option>
                                <option value="Mobiilirakenduste arendaja">Mobiilirakenduste arendaja</option>
                            </select><br/>
                            <input type="submit" value="Rakenda"/>
                        </form>
                        <!-- Button to close the modal -->
                        <button class="close-modal" onclick="closeModal()">Tagasi</button>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>