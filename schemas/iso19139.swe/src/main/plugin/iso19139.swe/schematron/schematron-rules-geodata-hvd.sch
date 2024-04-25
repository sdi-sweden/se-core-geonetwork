<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
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

<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
            xmlns:xsl="http://www.w3.org/1999/XSL/Transform" queryBinding="xslt2">
  <!--Detta skript är
  ursprungligen skrivet för CSIRO i Australien av Simon Pigot 2007 men är anpassat för den Svenska
  metadata-profilen Schematronvalidering av Nationell metadataprofil version 3.1.1 Geodataportalen
  Michael Östling 2013-->
  <!--
This work is licensed under the Creative Commons Attribution 2.5 License.
To view a copy of this license, visit
    http://creativecommons.org/licenses/by/2.5/au/

or send a letter to:

Creative Commons,
543 Howard Street, 5th Floor,
San Francisco, California, 94105,
USA.

-->
  <sch:title xmlns="http://www.w3.org/2001/XMLSchema"> Minimumkrav för värdefulla datamängder (HVD)</sch:title>
  <sch:ns prefix="gml" uri="http://www.opengis.net/gml"/>
  <sch:ns prefix="gmd" uri="http://www.isotc211.org/2005/gmd"/>
  <sch:ns prefix="srv" uri="http://www.isotc211.org/2005/srv"/>
  <sch:ns prefix="gco" uri="http://www.isotc211.org/2005/gco"/>
  <sch:ns prefix="geonet" uri="http://www.fao.org/geonetwork"/>
  <sch:ns prefix="skos" uri="http://www.w3.org/2004/02/skos/core#"/>
  <sch:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>

	<sch:pattern fpi="[Geodata.se:106f] OM resursen ingår i HVD är nyckelord obligatoriskt med ett värde ur nyckelordslexikonet Kategori för värdefulla datamängder">
		<sch:title>[Geodata.se:106f] OM resursen ingår i HVD är nyckelord obligatoriskt med ett värde ur nyckelordslexikonet Kategori för värdefulla datamängder</sch:title>
		<sch:rule context="//gmd:MD_DataIdentification|
			//*[@gco:isoType='gmd:MD_DataIdentification']|
			//srv:SV_ServiceIdentification|
			//*[@gco:isoType='srv:SV_ServiceIdentification']">
			<sch:let name="keywordValue_HVD"
               value="//gmd:descriptiveKeywords/*/gmd:keyword/*/text()='HVD'"/>
			<sch:let name="hvd-kategori-thesaurus" value="document('../../../../config/codelist/external/thesauri/theme/hvd-catagories-skos.rdf')"/>
			<sch:let name="hvd-kategorier" value="$hvd-thesaurus//skos:Concept"/>
			<!-- Visa fel om inte HVD Kategori Thesaurs visas. -->
			<sch:assert test="count($hvd-kategorier) > 0"> Kategori för värdefulla datamängder saknas. Installationen är ej korrekt filen </sch:assert>
			<sch:let name="keyword"
               value="//gmd:MD_Keywords[contains(gmd:thesaurusName/*/gmd:title/*/text(), 'Kategori för värdefulla datamängder')]/gmd:keyword/*/text()"/>
			<sch:let name="hvd-kategori-found"
               value="count($hvd-kategori-thesaurus//skos:Concept[skos:prefLabel = $keyword])"/>
			<sch:assert test="$hvd-kategori-found > 0"
      >[Geodata.se:106f] OM resursen ingår i HVD är nyckelord obligatoriskt med ett värde ur nyckelordslexikonet Kategori för värdefulla datamängder
      </sch:assert>

 	  <sch:report test="$hvd-kategori-found > 0">
          <sch:value-of select="$hvd-kategori-found"/> report <sch:value-of select="$keyword" /> 
      </sch:report> 


		</sch:rule>
	</sch:pattern>
	

</sch:schema>
