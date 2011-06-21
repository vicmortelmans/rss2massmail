<?xml version="1.0"?>

<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:out-xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" indent="yes"/>
  <xsl:namespace-alias stylesheet-prefix="out-xsl" result-prefix="xsl"/>

  <xsl:param name="url"/>
  
  <xsl:template match="xsl:stylesheet">
    <xsl:copy-of select="@*"/>
    <out-xsl:include href="{$url}"/>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
