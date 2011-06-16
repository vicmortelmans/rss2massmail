<?xml version="1.0"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml"/><!-- omitting this will cause the meta-tag not to be closed, as is required in html-->
  <xsl:output indent="yes"/>
  
  <xsl:template match="html">
      <xsl:message>CREATING HTML FILE <xsl:value-of select="$htmlfile"/></xsl:message>
      <html>
        <head>
          <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
          <title>
            <xsl:value-of select="$lastItem/title"/>
          </title>
          <style>
            a:link {color: #000000}
            a:visited {color: #000000}
            a:hover {color: #404040}
            a:active {color: #404040}
          </style>
        </head>
        <body>
          <!-- Heading -->
          <table style="width: 100%; padding: 3px">
            <tr>
              <td style="text-align: left; font-weight: bold">
                <a href="{$lastItem/link}">
                  <h2 style="color: #404040">
                    <xsl:value-of select="$lastItem/title"/>
                  </h2>
                </a>
              </td>
              <td style="text-align: right">
                REAGEER via 
                <a id="e0my" target="_blank" title="doorstroming@yahoogroups.com">
                  <xsl:attribute name="href">
                    <xsl:text>mailto:doorstroming@yahoogroups.com?subject=Re:</xsl:text><xsl:value-of select="encode-for-uri($lastItem/title)"/>
                  </xsl:attribute>
                  doorstroming@yahoogroups.com
                </a>
                of op de
                <a href="{$lastItem/link}#addcomments" id="e0my" target="_blank" title="{$lastItem/link}#addcomments">
                  webstek
                </a>
                <br/>
                SLUIT AAN OP HET FORUM via 
                <a href="mailto:doorstroming-subscribe@yahoogroups.com" id="e0my" target="_blank" title="doorstroming-subscribe@yahoogroups.com">
                  doorstroming-subscribe@yahoogroups.com
                </a>
                <br/>
                SCHRIJF JE UIT van deze verzendlijst via 
                <a href="mailto:info@doorstroming.net?subject=Uitschrijven" id="aywt" title="mailto:info@doorstroming.net?subject=Uitschrijven">
                  info@doorstroming.net
                </a>
              </td>
            </tr>
          </table>
          <table style="background-color: #B0B0B0; width: 100%; padding: 3px">
            <tr>
              <td style="text-align: left; font-weight: bold">
                <xsl:value-of select="$author"/>
              </td>
              <td style="text-align: right; font-weight: bold">
                <a href="{$pdfURL}">
                  Lezen als PDF
                </a>
              </td>
            </tr>
          </table>
          <xsl:apply-templates mode="article" select = "$article"/>
        </body>
      </html>
  </xsl:template>
  
  <xsl:template match="*|/" mode="article">
    <xsl:copy>
      <xsl:apply-templates mode="article"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="text()" mode="article">
    <xsl:value-of select="."/>
  </xsl:template>
  
  <xsl:template match="@*" mode="article"/>
  
  <xsl:template match="processing-instruction()|comment()" mode="article"/>

</xsl:stylesheet>
