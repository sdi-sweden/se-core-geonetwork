<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~ Copyright (C) 2001-2016 Food and Agriculture Organization of the
  ~ United Nations (FAO-UN), United Nations World Food Programme (WFP)
  ~ and United Nations Environment Programme (UNEP)
  ~
  ~ This program is free software; you can redistribute it and/or modify
  ~ it under the terms of the GNU General Public License as published by
  ~ the Free Software Foundation; either version 2 of the License, or (at
  ~ your option) any later version.
  ~
  ~ This program is distributed in the hope that it will be useful, but
  ~ WITHOUT ANY WARRANTY; without even the implied warranty of
  ~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  ~ General Public License for more details.
  ~
  ~ You should have received a copy of the GNU General Public License
  ~ along with this program; if not, write to the Free Software
  ~ Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
  ~
  ~ Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
  ~ Rome - Italy. email: geonetwork@osgeo.org
  -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:geonet="http://www.fao.org/geonetwork"
                xmlns:saxon="http://saxon.sf.net/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:void="http://www.w3.org/TR/void/"
                xmlns:dcat="http://www.w3.org/ns/dcat#" xmlns:dct="http://purl.org/dc/terms/"
                xmlns:skos="http://www.w3.org/2004/02/skos/core#"
                xmlns:adms   = "http://www.w3.org/ns/adms#"
                xmlns:cnt    = "http://www.w3.org/2011/content#"
                xmlns:earl   = "http://www.w3.org/ns/earl#"
                xmlns:gco    = "http://www.isotc211.org/2005/gco"
                xmlns:gmd    = "http://www.isotc211.org/2005/gmd"
                xmlns:gml    = "http://www.opengis.net/gml"
                xmlns:gmx    = "http://www.isotc211.org/2005/gmx"
                xmlns:gsp    = "http://www.opengis.net/ont/geosparql#"
                xmlns:i      = "http://inspire.ec.europa.eu/schemas/common/1.0"
                xmlns:i-gp   = "http://inspire.ec.europa.eu/schemas/geoportal/1.0"
                xmlns:locn   = "http://www.w3.org/ns/locn#"
                xmlns:owl    = "http://www.w3.org/2002/07/owl#"
                xmlns:org    = "http://www.w3.org/ns/org#"
                xmlns:prov   = "http://www.w3.org/ns/prov#"
                xmlns:schema = "http://schema.org/"
                xmlns:srv    = "http://www.isotc211.org/2005/srv"
                xmlns:vcard  = "http://www.w3.org/2006/vcard/ns#"
                xmlns:wdrs   = "http://www.w3.org/2007/05/powder-s#"
                xmlns:xlink  = "http://www.w3.org/1999/xlink"
                xmlns:xsi    = "http://www.w3.org/2001/XMLSchema-instance"
                version="2.0"
                extension-element-prefixes="saxon" exclude-result-prefixes="#all">

  <xsl:output indent="yes"/>

  <xsl:include href="../../common/base-variables.xsl"/>
  <xsl:include href="../../common/profiles-loader-tpl-rdf.xsl"/>

  <xsl:variable name="port">
    <xsl:choose>
      <xsl:when test="$env/system/server/protocol = 'https'">
        <xsl:value-of select="$env/system/server/securePort"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$env/system/server/port"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="url" select="concat($env/system/server/protocol, '://',
    $env/system/server/host,
    if ($port='80') then '' else concat(':', $port),
    /root/gui/url)"/>

  <!-- TODO: should use Java language code mapper -->
  <xsl:variable name="iso2letterLanguageCode" select="substring(/root/gui/language, 1, 2)"/>


  <xsl:variable name="inspireEnabled" select="$env/system/inspire/enable = 'true'"/>

  <xsl:template match="/">

    <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
             xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
             xmlns:foaf="http://xmlns.com/foaf/0.1/"
             xmlns:void="http://www.w3.org/TR/void/"
             xmlns:dcat="http://www.w3.org/ns/dcat#"
             xmlns:dct="http://purl.org/dc/terms/"
             xmlns:skos="http://www.w3.org/2004/02/skos/core#"
             xmlns:schema="http://schema.org/"
             xmlns:adms="http://www.w3.org/ns/adms#"
             xmlns:vcard="http://www.w3.org/2006/vcard/ns#"
             xmlns:cnt="http://www.w3.org/2011/content#"
             xmlns:gsp="http://www.opengis.net/ont/geosparql#"
             xmlns:dc="http://purl.org/dc/elements/1.1/"
             xmlns:dctype="http://purl.org/dc/dcmitype/"
             xmlns:owl="http://www.w3.org/2002/07/owl#"
             xmlns:org="http://www.w3.org/ns/org#"
             xmlns:prov="http://www.w3.org/ns/prov#">
    <!-- Metadata element -->

      <xsl:call-template name="catalogue"/>

      <xsl:apply-templates mode="to-dcat" select="/root/*"/>

      <xsl:apply-templates mode="references" select="/root/*"/>
    </rdf:RDF>

  </xsl:template>


  <xsl:template name="catalogue">


    <!-- First, the local catalog description using dcat:Catalog.
      "Typically, a web-based data catalog is represented as a single instance of this class."
      ... also describe harvested catalogues if harvested records are in the current dump.
    -->
    <dcat:Catalog rdf:about="{$url}">

      <!-- A name given to the catalog. -->
      <dct:title xml:lang="{$iso2letterLanguageCode}">
        <xsl:value-of select="$env/system/site/name"/>
      </dct:title>

      <!-- free-text account of the catalog. -->
      <dct:description xml:lang="{$iso2letterLanguageCode}">
        <xsl:value-of select="$env/system/site/name"/>
      </dct:description>

      <rdfs:label xml:lang="{$iso2letterLanguageCode}">
        <xsl:value-of select="$env/system/site/name"/> (<xsl:value-of
        select="$env/system/site/organization"/>)
      </rdfs:label>

      <!-- The homepage of the catalog -->
      <foaf:homepage rdf:resource="{$url}" />

      <!-- FIXME : void:Dataset -->
      <void:openSearchDescription><xsl:value-of select="$url"/>/srv/eng/portal.opensearch
      </void:openSearchDescription>
      <void:uriLookupEndpoint><xsl:value-of select="$url"/>/srv/eng/rdf.search?any=
      </void:uriLookupEndpoint>


      <!-- The entity responsible for making the catalog online. -->
      <dct:publisher rdf:resource="{$url}/organization/0">
				<foaf:Agent rdf:about="https://register.geodata.se/register/organisationer/Lantmateriet">
					<foaf:name>Lantmateriet</foaf:name>
					<dct:type rdf:resource="http://purl.org/adms/publishertype/NationalAuthority"/>
					<foaf:mbox rdf:resource="mailto:geodatasupport@lantmateriet.se"/>
				</foaf:Agent>
			</dct:publisher>

      <!-- The knowledge organization system (KOS) used to classify catalog's datasets.
      
      <xsl:for-each select="/root/gui/thesaurus/thesauri/thesaurus">
        <dcat:themes rdf:resource="{$url}/thesaurus/{key}"/>
      </xsl:for-each>
		-->

      <!-- The language of the catalog. This refers to the language used
        in the textual metadata describing titles, descriptions, etc.
        of the datasets in the catalog.

        http://www.ietf.org/rfc/rfc3066.txt

        Multiple values can be used. The publisher might also choose to describe
        the language on the dataset level (see dataset language).
      -->
     	<dct:language rdf:resource="http://publications.europa.eu/resource/authority/language/SWE"/>
			<dct:license rdf:resource="http://creativecommons.org/licenses/by/4.0/"/>


      <!-- This describes the license under which the catalog can be used/reused and not the datasets.
        Even if the license of the catalog applies to all of its datasets it should be
        replicated on each dataset.-->

      <!-- TODO using VoIDx
      <dct:license>
      </dct:license>
      -->


      <!-- The geographical area covered by the catalog.
      <dct:Location>

       </dct:Location> -->

      <!-- List all catalogue records
        <dcat:dataset rdf:resource="http://localhost:8080/geonetwork/dataset/1"/>
        <dcat:record rdf:resource="http://localhost:8080/geonetwork/metadata/1"/>
      -->
      <xsl:apply-templates mode="record-reference" select="/root/*"/>
    </dcat:Catalog>

    <!-- Organization in charge of the catalogue defined in the administration
    > system configuration -->
    <foaf:Organization rdf:about="{$url}/organization/0">
      <foaf:name>
        <xsl:value-of select="$env/system/site/organization"></xsl:value-of>
      </foaf:name>
    </foaf:Organization>

    <!-- ConceptScheme describes all thesaurus available in the catalogue
      * Resource identifier is a local identifier for local thesaurus or public URI if external
    -->
    <xsl:for-each select="/root/gui/thesaurus/thesauri/thesaurus">
      <skos:ConceptScheme rdf:about="{$url}/thesaurus/{key}">
        <dct:title>
          <xsl:value-of select="title"/>
        </dct:title>
        <!-- TODO : add conceptSchemes
          <dc:description>Thesaurus name.</dc:description>
          <dc:creator>
          <foaf:Organization>
          <foaf:name>Thesaurus org</foaf:name>
          </foaf:Organization>
          </dc:creator>-->
        <dct:uri><xsl:value-of select="$url"/>/srv/eng/thesaurus.download?ref=<xsl:value-of
          select="key"/>
        </dct:uri>
        <!--
          <dct:issued>2008-06-01</dct:issued>
          <dct:modified>2008-06-01</dct:modified>-->
      </skos:ConceptScheme>
    </xsl:for-each>
  </xsl:template>


  <!-- Avoid request and gui tag in template modes related to metadata conversion -->
  <xsl:template mode="record-reference" match="gui|request|metadata"/>

  <xsl:template mode="to-dcat" match="gui|request|metadata"/>

  <xsl:template mode="references" match="gui|request|metadata"/>

  <xsl:template mode="record-reference" match="metadata" priority="2">
    <dcat:dataset rdf:resource="{$url}/resource/{geonet:info/uuid}"/>
   <!-- <dcat:record rdf:resource="{$url}/metadata/{geonet:info/uuid}"/> -->
  </xsl:template>


</xsl:stylesheet>
