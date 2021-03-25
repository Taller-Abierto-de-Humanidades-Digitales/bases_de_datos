<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">

<!-- Crear los elementos estructurales del body HTML -->

<html>
<body>
<h1>Mi página Web con XML y XSLT</h1>

<table>
<tr>
<th>num. documento</th>
<th>resumen</th>
</tr>
<!-- etiqueta para iterar en cada coincidencia -->
<xsl:for-each select="libro/documento">
<tr>
<td> <xsl:value-of select="numDoc" /> </td>
<td> <xsl:value-of select="resumenDoc" /> </td>
</tr>
</xsl:for-each>

</table>
</body>
</html>
</xsl:template>

</xsl:stylesheet>
