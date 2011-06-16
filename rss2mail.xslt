<?xml version="1.0"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml"/><!-- omitting this will cause the meta-tag not to be closed, as is required in html-->
  <xsl:output indent="yes"/>
  
  <xsl:param name="feedURL"/>
  
  <xsl:template match="/">
    <!-- no actual input is expected! -->
    <xsl:variable name="lastItem" select="document($feedURL)//channel/item[1]"/>
    <!--xsl:message>LASTITEM: <xsl:copy-of select="$lastItem"/></xsl:message-->
    <xsl:variable name="query">
      <xsl:call-template name="replace">
        <xsl:with-param name="string">
          <xsl:text>select * from html where url="$lastItemURL"</xsl:text>
        </xsl:with-param>
        <xsl:with-param name="parameters">
          <lastItemURL><xsl:value-of select="$lastItem/link"/></lastItemURL>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <!--xsl:message>QUERY: <xsl:value-of select="$query"/></xsl:message-->
    <xsl:variable name="queryURL">
      <xsl:call-template name="replace">
        <xsl:with-param name="string">
          <xsl:text>http://query.yahooapis.com/v1/public/yql?q=$query&amp;diagnostics=true&amp;env=$env</xsl:text>
        </xsl:with-param>
        <xsl:with-param name="parameters">
          <query><xsl:value-of select="encode-for-uri($query)"/></query>
          <env><xsl:value-of select="encode-for-uri('store://datatables.org/alltableswithkeys')"/></env>
        </xsl:with-param>
      </xsl:call-template>    
    </xsl:variable>
    <!--xsl:message>QUERYURL: <xsl:copy-of select="$queryURL"/></xsl:message-->
    <!-- download the article -->
    <xsl:variable name="webpage" select="document($queryURL)//results"/>
    <!--xsl:message>WEBPAGE: <xsl:copy-of select="$webpage"/></xsl:message-->
    <!--xsl:variable name="article" select="$webpage//*[contains(concat( ' ', @class, ' ' ), concat( ' ', 'MsoNormal', ' ' ))]"/-->
    <xsl:variable name="article" select="$webpage//*[contains(concat( ' ', @class, ' ' ), concat( ' ', 'article-content', ' ' ))]//p"/>
    <!--xsl:message>ARTICLE: <xsl:copy-of select="$article"/></xsl:message-->
    <xsl:variable name="pdfURL" select="concat('http://www.doorstroming.net',$webpage//a[@title='PDF']/@href)"/>
    <!--xsl:message>PDFURL: <xsl:value-of select="$pdfURL"/></xsl:message-->
    <xsl:variable name="author" select="normalize-space($webpage//span[@class='createby']/text())"/>
    <!--xsl:message>AUTHOR: <xsl:copy-of select="$author"/></xsl:message-->
    
    <xsl:apply-templates/>

  </xsl:template>
  
  <xsl:template name="replace">
   <xsl:param name="string"/>
   <xsl:param name="parameters"/>
   <xsl:choose>
     <xsl:when test="count($parameters/*) &gt; 0">
       <xsl:variable name="string2">
          <xsl:value-of select="replace($string,concat('\$',name($parameters/*[1])),normalize-space($parameters/*[1]))"/>
       </xsl:variable>
       <xsl:call-template name="replace">
         <xsl:with-param name="string" select="$string2"/>
         <xsl:with-param name="parameters">
          <xsl:copy-of select="$parameters/*[position() &gt; 1]"/>
         </xsl:with-param>
       </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
       <xsl:value-of select="$string"/>
     </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
