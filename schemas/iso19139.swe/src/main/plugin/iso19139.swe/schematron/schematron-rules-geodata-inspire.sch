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
	<sch:title xmlns="http://www.w3.org/2001/XMLSchema">Nationell metadataprofil 4.0 för Inspire teman (iso19139.swe)</sch:title>
	<sch:ns prefix="gml" uri="http://www.opengis.net/gml"/>
	<sch:ns prefix="gmd" uri="http://www.isotc211.org/2005/gmd"/>
	<sch:ns prefix="srv" uri="http://www.isotc211.org/2005/srv"/>
	<sch:ns prefix="gco" uri="http://www.isotc211.org/2005/gco"/>
	<sch:ns prefix="geonet" uri="http://www.fao.org/geonetwork"/>
	<sch:ns prefix="skos" uri="http://www.w3.org/2004/02/skos/core#"/>
	<sch:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
	<!-- INSPIRE metadata rules / START -->
	<!-- ############################################ -->

	<sch:pattern fpi="[Geodata.se:106c] OM resursen ingår i Inspire är nyckelord obligatoriskt med ett värde ur nyckelordslexikonet GEMET">
		<sch:title>[Geodata.se:106c]OM resursen ingår i Inspire är nyckelord obligatoriskt med ett värde ur nyckelordslexikonet GEMET</sch:title>
		<sch:rule context="//gmd:MD_DataIdentification|
			//*[@gco:isoType='gmd:MD_DataIdentification']|
			//srv:SV_ServiceIdentification|
			//*[@gco:isoType='srv:SV_ServiceIdentification']">
			<sch:let name="keywordValue_INSPIRE"
               value="//gmd:descriptiveKeywords/*/gmd:keyword/*/text()='Inspire'"/>
			<sch:let name="inspire-thesaurus" value="document('../../../../config/codelist/external/thesauri/theme/inspire-theme.rdf')"/>
			<sch:let name="inspire-theme" value="$inspire-thesaurus//skos:Concept"/>
			<!-- Visa fel om inte Inspire Thesaurs visas. -->
			<sch:assert test="count($inspire-theme) > 0"> INSPIRE Themes saknas. Installationen är ej korrekt filen </sch:assert>
			<sch:let name="keyword"
               value="//gmd:MD_Keywords[contains(gmd:thesaurusName/*/gmd:title/*/text(), 'GEMET')]/gmd:keyword/*/text()"/>
			<sch:let name="inspire-theme-found"
               value="count($inspire-thesaurus//skos:Concept[skos:prefLabel = $keyword])"/>
			<sch:assert test="not($keywordValue_INSPIRE) or $inspire-theme-found > 0"
      >[Geodata.se:106c] Om resursen ingår i Inspire är nyckelord obligatoriskt med ett värde ur nyckelordslexikonet GEMET</sch:assert>
			<!--<sch:report test="$inspire-theme-found > 0">
        <sch:value-of select="$inspire-theme-found"/> report <sch:value-of select="$keyword"
        />
      </sch:report>-->
		</sch:rule>
	</sch:pattern>

	<sch:pattern fpi="[Geodata.se:106d] Nyckelord tjänsteklassificering är obligatoriskt för tjänster">
		<sch:title>[Geodata.se:106d] Nyckelord tjänsteklassificering är obligatoriskt för tjänster</sch:title>
		<sch:rule context="//gmd:hierarchyLevel[1]/*[@codeListValue ='service']">
			<sch:let name="keywordValue_INS" value="//gmd:descriptiveKeywords/*/gmd:keyword/*/text()='Inspire'"/>
			<sch:let name="srvCategory-thesaurus" value="document('../../../../config/codelist/external/thesauri/theme/SpatialDataServiceCategorySwedish.rdf')"/>
			<sch:let name="srvCategory-value" value="$srvCategory-thesaurus//skos:Concept"/>
			<!-- Visa fel om inte Inspire Thesaurs visas. -->
			<sch:let name="keywordValue_SDT"
               value="//gmd:MD_Keywords[contains(gmd:thesaurusName/*/gmd:title/*/text(), 'KOMMISSIONENS FÖRORDNING (EG) nr 1205/2008')]/gmd:keyword/*/text()"/>
			<sch:let name="srvCategory-found"
               value="count($srvCategory-thesaurus//skos:Concept[skos:prefLabel = $keywordValue_SDT])"/>
            <sch:let name="keywordValue_Link"
               value="//gmd:MD_Keywords[contains(gmd:thesaurusName/*/gmd:title/*/text(), 'KOMMISSIONENS FÖRORDNING (EG) nr 1205/2008')]/gmd:keyword/gmx:Anchor/@xlink:href"/>
            <sch:let name="srvCategorylink-found"
               value="count($srvCategory-thesaurus//skos:Concept/@rdf:about = $keywordValue_Link)"/> 
			<sch:assert test="not($keywordValue_INS) or ($srvCategory-found > 0 or srvCategorylink-found > 0)"
      >[Geodata.se:106d] Ett nyckelord tjänsteklassificering är obligatoriskt för tjänster som ingår i Inspire.</sch:assert>
<!--     	  <sch:report test="$srvCategory-found > 0">
            <sch:value-of select="$srvCategory-found"/> report <sch:value-of select="$keywordValue_SDT"/>
          </sch:report>  -->
		</sch:rule>
	</sch:pattern>

	<sch:pattern	fpi="[Geodata.se:106g] OM resursen ingår i Inspire är nyckelord obligatoriskt med värdet Inspire ur nyckelordslexikonet Initiativ">
		<sch:title>[Geodata.se:106g] OM resursen ingår i Inspire är nyckelord obligatoriskt med värdet Inspire ur nyckelordslexikonet Initiativ</sch:title>
		<sch:rule
      context="//gmd:MD_DataIdentification|
			//*[@gco:isoType='gmd:MD_DataIdentification']|
			//srv:SV_ServiceIdentification|
			//*[@gco:isoType='srv:SV_ServiceIdentification']">
			<sch:let name="keywordValue_SDT"
               value="//gmd:descriptiveKeywords/*/gmd:keyword/*/text()='Inspire'"/>
			<sch:let name="thesaurus_name_SDT"
               value="//gmd:descriptiveKeywords/*/gmd:thesaurusName/*/gmd:title/*/text()='Initiativ'"/>
			<!--			<sch:assert test="$keywordValue_SDT">[Geodata.se:106g] Nyckelord är obligatoriskt för Inspire resurser med värdet Inspire i nyckelordslexikonet Initiativ</sch:assert>
      <sch:assert test="$thesaurus_name_SDT">[Geodata.se:106g] Nyckelord är obligatoriskt för Inspire resurser med värdet Inspire i nyckelordslexikonet Initiativ</sch:assert>
      -->
			<sch:assert test="$thesaurus_name_SDT and $keywordValue_SDT">[Geodata.se:106g] OM resursen ingår i Inspire är nyckelord obligatoriskt med värdet Inspire ur nyckelordslexikonet Initiativ</sch:assert>
			<!--         <sch:report test="$keywordValue_SDT">[Geodata.se:106g] Nyckelord är obligatoriskt för Inspire resurser med värdet Inspire i nyckelordslexikonet Initiativ<sch:value-of select="$keywordValue_SDT"/></sch:report>
      <sch:report test="$thesaurus_name_SDT">[Geodata.se:106g] Nyckelord är obligatoriskt för Inspire resurser med värdet Inspire i nyckelordslexikonet Initiativ<sch:value-of select="$thesaurus_name_SDT"/></sch:report>
-->
		</sch:rule>
	</sch:pattern>

	<sch:pattern fpi="[Geodata.se:109]">
		<sch:title>Data som ingår i Inspire skall ha en överensstämmelserapport [Geodata.se:109]</sch:title>
		<sch:rule context="/gmd:MD_Metadata">

			<sch:let name="degree" value="gmd:dataQualityInfo/*/gmd:report/gmd:DQ_DomainConsistency"/>
			<sch:let name="keywordValue_INS" value="//gmd:descriptiveKeywords/*/gmd:keyword/*/text()='Inspire'"/>
			<sch:assert test="$degree or not($keywordValue_INS)">[Geodata.se:109] Resurser som ingår i Inspire skall ha en överensstämmelserapport </sch:assert>

		<!--	<sch:report test="$degree">(2.8.1) Degree of conformity found:
				<sch:value-of select="$degree"/>
			</sch:report>
		 -->						
		</sch:rule>

		<sch:rule context="/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report">
			<sch:let name="keywordValue_INS" value="//gmd:descriptiveKeywords/*/gmd:keyword/*/text()='Inspire'"/>

			<sch:let name="report_count" value="count(/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/gmd:DQ_DomainConsistency)" />
			<sch:let name="title_count" value="count(/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report[gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title])" />
			<sch:let name="explanation_count" value="count(/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report[gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:explanation/gco:CharacterString])" />
			<sch:let name="pass_count" value="count(/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report[gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:pass/gco:Boolean])" />
			<sch:let name="date_count" value="count(/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report[gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:date/gco:Date])" />
			<sch:let name="dateType_count" value="count(/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report[gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue])" />
			<sch:let name="resourceType" value="//gmd:MD_Metadata/gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue"/>

			<sch:let name="datasetSpec" value="//gmd:specification/*/gmd:title/*/text()/lower-case(.) = 'kommissionens förordning (eu) nr 1089/2010 av den 23 november 2010 om genomförande av europaparlamentets och rådets direktiv 2007/2/eg vad gäller interoperabilitet för rumsliga datamängder och datatjänster'" />
			<sch:let name="serviceSpec" value="//gmd:specification/*/gmd:title/*/text()/lower-case(.) = 'kommissionens förordning (eg) nr 976/2009 av den 19 oktober 2009 om genomförande av europaparlamentets och rådets direktiv 2007/2/eg med avseende på nättjänster'" />
			
			<sch:assert
				test="($title_count > 0 and $pass_count > 0 and $date_count > 0 and $explanation_count > 0) or not($keywordValue_INS)">[Geodata.se:109] Resurser som ingår i Inspire bör ha en överensstämmelserapport
			</sch:assert>
			
			<sch:assert test="($title_count = $report_count) or not($keywordValue_INS)">[Geodata.se:109a] Resurser som ingår i Inspire bör ha en överensstämmelserapport  - namn på specifikation saknas </sch:assert>
			<sch:assert test="($explanation_count = $report_count) or not($keywordValue_INS)">[Geodata.se:109b] Resurser som ingår i Inspire skall ha en överensstämmelserapport - beskrivning av specifikationsuppfyllelse saknas </sch:assert>
			<sch:assert test="($pass_count = $report_count) or not($keywordValue_INS)">[Geodata.se:109c] Resurser som ingår i Inspire skall ha en överensstämmelserapport) - överensstämmelse (ja/nej) saknas </sch:assert>
			<sch:assert test="($date_count = $report_count and $dateType_count = $report_count) or not($keywordValue_INS)">[Geodata.se:109d] Resurser som ingår i Inspire skall ha en överensstämmelserapport) - publiceringsdatum för specifikation saknas </sch:assert>
			<sch:assert test="(($resourceType = 'dataset' or $resourceType = 'series') and   $datasetSpec)  or $resourceType = 'service' or not($keywordValue_INS)">[Geodata.se:109e] Datamängder som ingår i Inspire skall ha en överensstämmelserapport mot genomförandebestämmelsen: Kommissionens förordning (EU) nr 1089/2010 av den 23 november 2010 om genomförande av Europaparlamentets och rådets direktiv 2007/2/EG vad gäller interoperabilitet för rumsliga datamängder och datatjänster  </sch:assert>
			<sch:assert test="($resourceType = 'service' and   $serviceSpec)  or ($resourceType = 'dataset' or $resourceType = 'series') or not($keywordValue_INS)">[Geodata.se:109f] Tjänster som ingår i Inspire skall ha en överensstämmelserapport mot genomförandebestämmelsen: Kommissionens förordning (EG) nr 976/2009 av den 19 oktober 2009 om genomförande av Europaparlamentets och rådets direktiv 2007/2/EG med avseende på nättjänster  </sch:assert>
			<sch:assert test="($explanation_count = $report_count) or not($keywordValue_INS)">[Geodata.se:109g] Resurser som ingår i Inspire skall ha en överensstämmelserapport) - förklaring saknas </sch:assert>

		</sch:rule>
	</sch:pattern>



	<sch:pattern fpi="[Geodata.se:113b] Metadatakontakt måste ha epostadress och organisation eller person angiven">
		<sch:title>[Geodata.se:113b] Metadatakontakt måste ha epostadress och organisation eller person angiven</sch:title>
		<sch:rule context="//gmd:MD_Metadata">
			<sch:assert
        test="(((gmd:contact/gmd:CI_ResponsibleParty/gmd:organisationName) or (gmd:contact/gmd:CI_ResponsibleParty/gmd:individualName)) and (gmd:contact/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress))"
      >[Geodata.se:113b] Metadatakontakt måste ha epostadress och organisation eller person angiven</sch:assert>
		</sch:rule>
	</sch:pattern>

	<!-- INSPIRE metadata rules / END -->
	<!-- Kontroller för Geodata.se -->
	<!-- Kontrollera att fileidentifier finns med-->

	<!-- ========================================================================================== -->
	<!-- Abstract Patterns                                                                          -->
	<!-- ========================================================================================== -->

	<!-- Test that an element has a value or has a valid nilReason value -->
	<!-- <sch:pattern abstract="true" id="TypeNillablePattern">
    <sch:rule context="$context">
      <sch:assert test="(string-length(.) &gt; 0) or
        (@gco:nilReason = 'inapplicable' or
        @gco:nilReason = 'missing' or
        @gco:nilReason = 'template' or
        @gco:nilReason = 'unknown' or
        @gco:nilReason = 'withheld' or
        starts-with(@gco:nilReason, 'other:'))">
        Elementet <sch:name/> måste ha ett värde eller giltigt NIL-värde.
      </sch:assert>
    </sch:rule>
  </sch:pattern>
  -->
	<!-- Test that an element has a value - the value is not nillable -->
	<!--
  <sch:pattern abstract="true" id="TypeNotNillablePattern">
    <sch:rule context="$context">
      <sch:assert test="string-length(.) &gt; 0 and count(./@gco:nilReason) = 0">
        The <sch:name/> element is not nillable and shall have a value.
      </sch:assert>
    </sch:rule>
  </sch:pattern>
  -->

</sch:schema>
