<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
                xmlns:geonet="http://www.fao.org/geonetwork"
                xmlns:gmd="http://www.isotc211.org/2005/gmd"
                xmlns:xlink='http://www.w3.org/1999/xlink'
                xmlns:gco="http://www.isotc211.org/2005/gco"
                xmlns:gmx="http://www.isotc211.org/2005/gmx"
                xmlns:srv="http://www.isotc211.org/2005/srv"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:dcterms="http://purl.org/dc/terms/"
                xmlns:util="java:org.fao.geonet.util.XslUtil"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xls="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="#all">

  <!-- ================================================================= -->


  <xsl:variable name="inspiretheme-th"
                select="document(concat('file:///', replace(util:getConfigValue('codeListDir'), '\\', '/'), '/external/thesauri/theme/inspire-theme.rdf.new'))"/>
  <xsl:variable name="inspiretheme" select="$inspiretheme-th//skos:Concept"/>

  <!-- Fix -->

  <xsl:template match="gmd:keyword[../gmd:thesaurusName/gmd:CI_Citation/gmd:title/*/text() = 'GEMET - INSPIRE themes, version 1.0']">
    <xsl:copy copy-namespaces="no">
      <xsl:copy-of select="@*" />

      <xsl:choose>
        <xsl:when test="gmx:Anchor">
          <xsl:variable name="value" select="lower-case(gmx:Anchor)" />
          <xsl:variable name="key" select="$inspiretheme[skos:prefLabel[@xml:lang='sv' and lower-case(text()) = $value]]/@rdf:about" />

          <gmx:Anchor xlink:href="{$key}"><xsl:value-of select="gmx:Anchor" /></gmx:Anchor>
        </xsl:when>
        <xsl:when test="gco:CharacterString">
          <xsl:variable name="value" select="lower-case(gco:CharacterString)" />
          <xsl:variable name="key" select="$inspiretheme[skos:prefLabel[@xml:lang='sv' and lower-case(text()) = $value]]/@rdf:about" />

          <gmx:Anchor xlink:href="{$key}"><xsl:value-of select="gco:CharacterString" /></gmx:Anchor>
        </xsl:when>        
        <xsl:otherwise>
          <xsl:apply-templates select="*" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>


  <!-- ================================================================= -->
   
  <!-- copy everything else as is -->

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  
    <!-- Remove geonet:* elements. -->
  <xsl:template match="geonet:*" priority="2"/>
  
</xsl:stylesheet>
