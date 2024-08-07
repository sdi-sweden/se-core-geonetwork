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

<!-- Change to Inspire theme thesauraus -->
  <xsl:variable name="inspire-theme-th"
                select="document(concat('file:///', replace(util:getConfigValue('codeListDir'), '\\', '/'), '/external/thesauri/theme/inspire-theme.rdf'))"/>
  <xsl:variable name="inspire-theme" select="$inspire-theme-th//skos:Concept"/>

  <!-- Fix -->
<!--   <xsl:template match="gmd:thesaurusName/gmd:CI_Citation/gmd:title[gco:CharacterString = 'Tjänsteklassificering' or
                        lower-case(gco:CharacterString) = 'kommissionens förordning (eu) nr 1089/2010 av den 23 november 2010 om genomförande av europaparlamentets och rådets direktiv 2007/2/eg vad gäller interoperabilitet för rumsliga datamängder och datatjänster' or
                        lower-case(gco:CharacterString) = 'kommissionens förordning (eg) nr 1205/2008 av den 3 december 2008 om genomförande av europaparlamentets och rådets direktiv 2007/2/eg om metadata 2018-12-03']">
    <gmd:title>
      <gco:CharacterString>KOMMISSIONENS FÖRORDNING (EG) nr 1205/2008 av den 3 december 2008 om genomförande av Europaparlamentets och rådets direktiv 2007/2/EG om metadata</gco:CharacterString>
    </gmd:title>
  </xsl:template> -->

<!--   <xsl:template match="gmd:thesaurusName/gmd:CI_Citation[gmd:title/gco:CharacterString = 'Tjänsteklassificering' or
                        lower-case(gmd:title/gco:CharacterString) = 'kommissionens förordning (eu) nr 1089/2010 av den 23 november 2010 om genomförande av europaparlamentets och rådets direktiv 2007/2/eg vad gäller interoperabilitet för rumsliga datamängder och datatjänster']/gmd:date/gmd:CI_Date">
     <gmd:CI_Date>
       <gmd:date>
         <gco:Date>2017-01-01</gco:Date>
       </gmd:date>
       <gmd:dateType>
         <gmd:CI_DateTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</gmd:CI_DateTypeCode>
       </gmd:dateType>
     </gmd:CI_Date>  
  </xsl:template> -->

<!--   <xsl:template match="gmd:keyword[../gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString = 'Tjänsteklassificering' or
                        lower-case(../gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString) = 'kommissionens förordning (eu) nr 1089/2010 av den 23 november 2010 om genomförande av europaparlamentets och rådets direktiv 2007/2/eg vad gäller interoperabilitet för rumsliga datamängder och datatjänster']">
    <xsl:copy copy-namespaces="no">
      <xsl:copy-of select="@*" />

      <xsl:choose>
        <xsl:when test="gco:CharacterString">
          <xsl:variable name="value" select="lower-case(gco:CharacterString)" />
          <xsl:variable name="key" select="$spatialdataservicecategory[skos:prefLabel[@xml:lang='sv' and lower-case(text()) = $value]]/@rdf:about" />

          <gmx:Anchor xlink:href="{$key}"><xsl:value-of select="gco:CharacterString" /></gmx:Anchor>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="*" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>
 -->
  <xsl:template match="gmd:keyword[../gmd:thesaurusName/gmd:CI_Citation/gmd:title/*/text() = 'GEMET - INSPIRE themes, version 1.0']">
    <xsl:copy copy-namespaces="no">
      <xsl:copy-of select="@*" />

      <xsl:choose>
        <xsl:when test="gco:CharacterString">
          <xsl:variable name="value" select="lower-case(gco:CharacterString)" />
          <xsl:variable name="key" select="$inspire-theme[skos:prefLabel[@xml:lang='sv' and lower-case(text()) = $value]]/@rdf:about" />

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
