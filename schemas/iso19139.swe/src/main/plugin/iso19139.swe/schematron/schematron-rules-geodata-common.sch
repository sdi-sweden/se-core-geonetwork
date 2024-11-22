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
  <sch:title xmlns="http://www.w3.org/2001/XMLSchema">Nationell metadataprofil 4.0 för alla metadata</sch:title>
  <sch:ns prefix="gml" uri="http://www.opengis.net/gml"/>
  <sch:ns prefix="gmd" uri="http://www.isotc211.org/2005/gmd"/>
  <sch:ns prefix="srv" uri="http://www.isotc211.org/2005/srv"/>
  <sch:ns prefix="gco" uri="http://www.isotc211.org/2005/gco"/>
  <sch:ns prefix="geonet" uri="http://www.fao.org/geonetwork"/>
  <sch:ns prefix="skos" uri="http://www.w3.org/2004/02/skos/core#"/>
  <sch:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
  <sch:ns prefix="gmx" uri="http://www.isotc211.org/2005/gmx"/>
  <!-- Common metadata rules / START -->
  <!-- ############################################ -->
  <sch:pattern fpi="[Geodata.se:101] - En titel måste anges">
    <sch:title>[Geodata.se:101] - En titel måste anges</sch:title>
    <sch:rule context="//gmd:identificationInfo[1]/*">
      <sch:let name="resourceTitle" value="normalize-space(gmd:citation/*/gmd:title/*/text())"/>
      <sch:let name="resourceTitleLength" value="string-length(gmd:citation/*/gmd:title/*/text())"/>
      <!--<sch:report test="$resourceTitle">Titel funnen:
        <sch:value-of select="$resourceTitle"/>
        <sch:value-of select="$resourceTitleLength"/>
        </sch:report>-->
      <sch:assert test="$resourceTitle and ($resourceTitleLength &lt; 300)">[Geodata.se:101] - Titel måste anges och innehålla mindre än 300 tecken</sch:assert>
    </sch:rule>
  </sch:pattern>


  <!--	<sch:pattern is-a="TypeNillablePattern" fpi="[Geodata.se:101b] - Alternativ titel får inte vara tom om den anges">
      <sch:param name="context" value="//gmd:identificationInfo//gmd:citation//gmd:alternateTitle"/>
    </sch:pattern>
  -->

  <sch:pattern fpi="[Geodata.se:102] - Sammanfattning  måste anges">
    <sch:title>[Geodata.se:102] - Sammanfattning  måste anges</sch:title>
    <sch:rule context="//gmd:identificationInfo[1]/*">
      <sch:let name="resourceAbstract" value="normalize-space(gmd:abstract/*/text())"/>
      <sch:let name="resourceAbstractLength" value="string-length(gmd:abstract/*/text())"/>
      <sch:assert test="$resourceAbstract and ($resourceAbstractLength &lt; 8000)">[Geodata.se:102] - Sammanfattning krävs och skall vara på max 4000 tecken</sch:assert>
      <!--<sch:report test="$resourceAbstract">(2.2.2) Resource abstract found: <sch:value-of	select="$resourceAbstract"/>
      </sch:report> -->
    </sch:rule>


  </sch:pattern>

  <sch:pattern fpi="[Geodata.se:103] - Typ av resurs (hierarkisk nivå)  måste anges">
    <sch:title>[Geodata.se:103] - Typ av resurs (hierarkisk nivå)  måste anges</sch:title>
    <sch:rule context="//gmd:MD_Metadata">
      <sch:let name="resourceType_present"
               value="gmd:hierarchyLevel/*/@codeListValue='dataset'
                or gmd:hierarchyLevel/*/@codeListValue='series'
                or gmd:hierarchyLevel/*/@codeListValue='service'"/>
      <sch:let name="resourceType" value="gmd:hierarchyLevel/*/@codeListValue"/>
      <!-- assertions and report -->
      <sch:assert test="$resourceType_present">[Geodata.se:103] - Resurstyp (hierarkisk nivå)	krävs </sch:assert>
      <!--<sch:report test="$resourceType_present">(2.2.3) Resource type found: <sch:value-of
          select="$resourceType"/>
      </sch:report>-->
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="[Geodata.se:104] - Identifierare för resursen  måste anges">
    <sch:title>[Geodata.se:104] - Identifierare för resursen  måste anges</sch:title>
    <sch:rule context="//gmd:MD_DataIdentification|//*[@gco:isoType='gmd:MD_DataIdentification']">
      <sch:let name="resourceIdentifier_code"
               value="normalize-space(//gmd:citation/*/gmd:identifier/gmd:MD_Identifier/gmd:code/*/text())"/>
      <sch:let name="resourceIdentifier_uri"
               value="normalize-space(//gmd:citation/*/gmd:identifier/gmd:MD_Identifier/gmd:code/gmx:Anchor/@xlink:href)"/>
      <sch:assert test="$resourceIdentifier_code or $resourceIdentifier_uri">[Geodata.se:104] - Identifierare för resursen krävs</sch:assert>
      <!--Rep	<sch:report test="$resourceIdentifier_code">ID <sch:value-of select="$resourceIdentifier_code"/> </sch:report> -->
      <!--Rep	<sch:report test="$resourceIdentifier_uri">URI <sch:value-of select="$resourceIdentifier_uri"/> </sch:report> -->
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="[Geodata.se:105] - Ämnesområde  måste anges ">
    <sch:title>[Geodata.se:105] - Ämnesområde  måste anges </sch:title>
    <sch:rule context="//gmd:MD_DataIdentification|//*[@gco:isoType='gmd:MD_DataIdentification']">
      <sch:assert test="gmd:topicCategory">[Geodata.se:105] - Ämnesområde krävs </sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="[Geodata.se:105] - Ämnesområde  måste anges">
    <sch:title>[Geodata.se:105] - Testing 'Classification of spatial data and services' elements</sch:title>
    <sch:rule context="//gmd:MD_DataIdentification|//*[@gco:isoType='gmd:MD_DataIdentification']">
      <!-- <sch:rule context="//gmd:identificationInfo[1]/*"> -->
      <sch:let name="topicCategory" value="gmd:topicCategory/*/text()"/>
      <sch:let name="topicCategoryFound"
               value="
				gmd:topicCategory/*/text()='farming' or
				gmd:topicCategory/*/text()='biota' or
				gmd:topicCategory/*/text()='boundaries' or
				gmd:topicCategory/*/text()='climatologyMeteorologyAtmosphere' or
				gmd:topicCategory/*/text()='economy' or
				gmd:topicCategory/*/text()='elevation' or
				gmd:topicCategory/*/text()='environment' or
				gmd:topicCategory/*/text()='geoscientificInformation' or
				gmd:topicCategory/*/text()='health' or
				gmd:topicCategory/*/text()='imageryBaseMapsEarthCover' or
				gmd:topicCategory/*/text()='intelligenceMilitary' or
				gmd:topicCategory/*/text()='inlandWaters' or
				gmd:topicCategory/*/text()='location' or
				gmd:topicCategory/*/text()='oceans' or
				gmd:topicCategory/*/text()='planningCadastre' or
				gmd:topicCategory/*/text()='society' or
				gmd:topicCategory/*/text()='structure' or
				gmd:topicCategory/*/text()='transportation' or
				gmd:topicCategory/*/text()='utilitiesCommunication'
				"/>
      <!-- assertions and report -->
      <sch:assert test="$topicCategoryFound">[[Geodata.se:105I] - Ämnesområde måste anges"</sch:assert>
      <!--<sch:report test="$topicCategory">(2.3.1) Topic category found: <sch:value-of
          select="$topicCategory"/>
      </sch:report>-->
    </sch:rule>
  </sch:pattern>

<!-- If a keyword from Initiativ code list is present then the keyword value must be in the codelist -->
  <sch:pattern fpi="[Geodata.se:106h] Om du har Initiativ nyckelord, vardet mäste finns i Initiativ thesaurus">
    <sch:title>[Geodata.se:106h] Om du har Initiativ nyckelord, vardet mäste finns i Initiativ thesaurus</sch:title>
    <sch:rule context="//gmd:MD_Keywords[gmd:thesaurusName/*/gmd:title/*/text() = 'Initiativ']/gmd:keyword/*/text()">

	<sch:let name="initiativ-keyword"
             value="//gmd:MD_Keywords[gmd:thesaurusName/*/gmd:title/*/text() = 'Initiativ']/gmd:keyword/*/text()"/>
    <sch:let name="initiativ-present" 
             value="//gmd:MD_Keywords[gmd:thesaurusName/*/gmd:title/*/text() = 'Initiativ']/gmd:keyword/*/text() = 'Inspire' or 
                    //gmd:MD_Keywords[gmd:thesaurusName/*/gmd:title/*/text() = 'Initiativ']/gmd:keyword/*/text() = 'Geodatasamverkan' or 
                    //gmd:MD_Keywords[gmd:thesaurusName/*/gmd:title/*/text() = 'Initiativ']/gmd:keyword/*/text() = 'HVD' or
                    //gmd:MD_Keywords[gmd:thesaurusName/*/gmd:title/*/text() = 'Initiativ']/gmd:keyword/*/text() = 'Öppna data' or
                    //gmd:MD_Keywords[gmd:thesaurusName/*/gmd:title/*/text() = 'Initiativ']/gmd:keyword/*/text() = 'Grön infrastruktur' "/>
	<sch:assert test="$initiativ-present"
      >[Geodata.se:106h] Om du har Initiativ nyckelord, varder mäste finns i Initiativ thesaurus</sch:assert>
      <sch:report test="$initiativ-present">[Geodata.se:106h] Om du har Initiativ nyckelord, vardet mäste finns i thesaurus: <sch:value-of select="$initiativ-keyword"/>
      </sch:report>
    </sch:rule>
  </sch:pattern>


  <sch:pattern fpi="[Geodata.se:106e] Typ av tjänst måste anges (discovery, view, download etc)">
    <sch:title>[Geodata.se:106e] Kontrollerar: Tjänstetyp måste anges (discovery, view, download etc)</sch:title>
    <sch:rule context="//gmd:hierarchyLevel[1]/*[@codeListValue ='service']">
      <sch:let name="serviceType" value="//srv:serviceType/*/text()"/>
      <sch:let name="serviceType_present"
               value="//srv:serviceType/*/text() = 'view'
                            or //srv:serviceType/*/text() = 'discovery'
                            or //srv:serviceType/*/text() = 'download'
                            or //srv:serviceType/*/text() = 'transformation'
                            or //srv:serviceType/*/text() = 'invoke'
                            or //srv:serviceType/*/text() = 'other'
                            or //srv:serviceType/*/text() = 'ogc:wms'
                            or //srv:serviceType/*/text() = 'ogc:wfs'
                            or //srv:serviceType/*/text() = 'ogc:wcs'"/>
      <!-- assertions and report -->
      <sch:assert test="$serviceType_present">[Geodata.se:106e] Typ av tjänst måste anges(discovery, view, download etc): <sch:value-of select="$serviceType"/>
      </sch:assert>
      <!--<sch:report test="$serviceType_present">[Geodata.se:106e] Typ av tjänst måste anges(discovery, view, download etc): <sch:value-of select="$serviceType"/>
      </sch:report>-->
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="[Geodata.se:107b] Referensdatum måste anges">
    <sch:title>[Geodata.se:107b] Referensdatum måste anges </sch:title>
    <sch:rule context="//gmd:identificationInfo">
      <sch:assert test="(//gmd:citation/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:date) "
      >[Geodata.se:107b] Referensdatum krävs</sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="[Geodata.se:108] Tillkomsthistorik  måste anges">
    <sch:title>[Geodata.se:108] Tillkomsthistorik  måste anges </sch:title>
    <sch:rule context="/*">
      <sch:let name="lineage" value="//gmd:dataQualityInfo/*/gmd:lineage/*/gmd:statement/*/text()/normalize-space(.)"/>
      <sch:let name="lineageLength" value="string-length($lineage)"/>
      <sch:assert	test="//gmd:hierarchyLevel/*/@codeListValue='service' or ($lineage and ($lineageLength &lt; 2500))"> [Geodata.se:108] Tillkomsthistorik är obligatorisk för datamängder och får ha max 2500 tecken</sch:assert>
    </sch:rule>
    <sch:rule context="/*">
      <sch:let name="lineage" value="//gmd:dataQualityInfo/*/gmd:lineage/*/gmd:statement/*/text()/normalize-space(.)"/>
      <!-- assertions and report -->
      <sch:assert test="$lineage">[Geodata.se:108] Tillkomsthistorik är obligatorisk</sch:assert>
      <!--		<sch:report test="$lineage">[Geodata.se:108] Tillkomst<sch:value-of select="$lineage"/></sch:report>-->
    </sch:rule>
  </sch:pattern>


  <!--
  <sch:pattern fpi="[Geodata.se:109a] Datakvalite - överensstämmelse måste anges">
    <sch:rule context="//gmd:dataQualityInfo/gmd:DQ_DataQuality">
      <sch:assert test="(gmd:report/gmd:DQ_DomainConsistency) or
      (gmd:report/gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:pass)  or
      (gmd:report/gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult//gmd:specification/gmd:CI_Citation/gmd:title)">[Geodata.se:109a]Datakvalite - överensstämmelse skall anges</sch:assert>
    </sch:rule>
  </sch:pattern>
  -->
  <!--
  <sch:pattern fpi="[Geodata.se:110b] Åtkomstrestriktioner måste anges">
    <sch:rule context="//gmd:identificationInfo">
      <sch:assert test="(//gmd:resourceConstraints//gmd:accessConstraints)">[Geodata.se:110b] Åtkomstrestriktioner måste anges</sch:assert>
    </sch:rule>
  </sch:pattern>
  -->
  <sch:pattern fpi="[Geodata.se:110] Information om restriktioner">
    <sch:title>[Geodata.se:110] Information om restriktioner</sch:title>

    <sch:rule context="//gmd:identificationInfo">
      <sch:let name="resourceConstraints_count" value="count(//gmd:resourceConstraints)"/>
      <sch:assert test="$resourceConstraints_count > 0 ">[Geodata.se:110c] Information om restriktioner saknas</sch:assert>
    </sch:rule>

    <sch:rule context="//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints">
      <sch:let name="legalConstraints"
               value="//gmd:MD_LegalConstraints/gmd:accessConstraints/*/@codeListValue"/>
      <sch:let name="legalConstraints_present"
               value="//gmd:MD_LegalConstraints/gmd:accessConstraints/*/@codeListValue = 'copyright' or //gmd:MD_LegalConstraints/gmd:accessConstraints/*/@codeListValue = 'patent' or //gmd:MD_LegalConstraints/gmd:accessConstraints/*/@codeListValue = 'patentPending' or //gmd:MD_LegalConstraints/gmd:accessConstraints/*/@codeListValue = 'trademark' or //gmd:MD_LegalConstraints/gmd:accessConstraints/*/@codeListValue = 'license' or //gmd:MD_LegalConstraints/gmd:accessConstraints/*/@codeListValue = 'intellectualPropertyRights' or //gmd:MD_LegalConstraints/gmd:accessConstraints/*/@codeListValue = 'restricted' or //gmd:MD_LegalConstraints/gmd:accessConstraints/*/@codeListValue = 'otherRestrictions'"/>
      <sch:let name="classification" value="//gmd:classification/*/@codeListValue"/>
      <sch:let name="classification_present"
               value="//gmd:classification/*/@codeListValue = 'unclassified' or //gmd:classification/*/@codeListValue = 'restricted' or //gmd:classification/*/@codeListValue = 'confidential' or //gmd:classification/*/@codeListValue = 'secret' or //gmd:classification/*/@codeListValue = 'topSecret'"/>
      <sch:let name="otherLegalConstraints"
               value="//gmd:MD_LegalConstraints/gmd:otherConstraints/*/text()"/>

      <sch:assert test="$legalConstraints_present">[Geodata.se:110f] Information om åtkomstrestriktioner saknas eller har fel värde <sch:value-of select="$legalConstraints"/></sch:assert>
    </sch:rule>

    <sch:rule context="//gmd:identificationInfo[1]/*">

      <sch:assert test="not(gmd:hierarchyLevel/*/@codeListValue='dataset') or count(/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints) &gt; 0">[Geodata.se:110e] [Geodata.se:110f] Användningsbegränsningar och användbarhetsbegränsingar skall anges</sch:assert>

	  <!--<sch:let name="useLimitation" value="//gmd:MD_Constraints/gmd:useLimitation/gco:CharacterString/text()"/>
      <sch:let name="useLimitation_count" value="count(//gmd:MD_Constraints/gmd:useLimitation/gco:CharacterString/text())"/>
      <sch:assert test="$useLimitation_count = 1">[Geodata.se:110g] Information om användbarhetsbegränsningar måste finnas men får bara anges en gång</sch:assert>

      <sch:let name="useLimitationLength" value="//gmd:MD_Constraints/gmd:useLimitation/gco:CharacterString/text()/string-length(.)"/>
      <sch:assert test="$useLimitation and ($useLimitationLength &lt; 2500)">[Geodata.se:110e] Information om användbarhetsbegränsningar måste finnas och vara kortare än 2500 tecken </sch:assert>
	  -->

      <sch:let name="accessConstraints" value="//gmd:resourceConstraints/*/gmd:accessConstraints/*/@codeListValue"/>
      <sch:let name="accessConstraints_present" value="//gmd:resourceConstraints/*/gmd:accessConstraints/*/@codeListValue = 'copyright' or //gmd:resourceConstraints/*/gmd:accessConstraints/*/@codeListValue = 'patent' or //gmd:resourceConstraints/*/gmd:accessConstraints/*/@codeListValue = 'patentPending' or //gmd:resourceConstraints/*/gmd:accessConstraints/*/@codeListValue = 'trademark' or //gmd:resourceConstraints/*/gmd:accessConstraints/*/@codeListValue = 'license' or //gmd:resourceConstraints/*/gmd:accessConstraints/*/@codeListValue = 'intellectualPropertyRights' or //gmd:resourceConstraints/*/gmd:accessConstraints/*/@codeListValue = 'restricted'"/>
      <sch:let name="classification_present" value="//gmd:resourceConstraints/*/gmd:classification/*/@codeListValue = 'unclassified' or //gmd:resourceConstraints/*/gmd:classification/*/@codeListValue = 'restricted' or //gmd:resourceConstraints/*/gmd:classification/*/@codeListValue = 'confidential' or //gmd:resourceConstraints/*/gmd:classification/*/@codeListValue = 'secret' or //gmd:resourceConstraints/*/gmd:classification/*/@codeListValue = 'topSecret'"/>
      <sch:let name="otherConstraints" value="//gmd:resourceConstraints/*/gmd:otherConstraints/*/text()"/>
      <sch:let name="otherConstraints_condition" value="//gmd:resourceConstraints/*/gmd:accessConstraints/*/@codeListValue = 'otherRestrictions'"/>
      <sch:let name="otherConstraintsLength" value="//gmd:resourceConstraints/*/gmd:otherConstraints/*/text()/string-length(.) &lt; 1000"/>

      <sch:let name="otherConstraints_present" value="$otherConstraints and $otherConstraints_condition and $otherConstraintsLength"/>

      <sch:assert test="$accessConstraints_present or $classification_present or $otherConstraints_present">[Geodata.se:110f] Information om åtkomstrestriktioner saknas eller har fel värde, andra begränsningar får ha max 1000 tecken</sch:assert>

    </sch:rule>
 <!--
    <sch:rule context="//gmd:identificationInfo//gmd:resourceConstraints//gmd:otherConstraints/*">
      <sch:let name="accessConstraints_value" value="../../gmd:accessConstraints//@codeListValue"/>
      <sch:assert test="$accessConstraints_value = 'otherRestrictions'">[Geodata.se:110d] Åtkomstrestriktioner måste ha värdet 'otherRestrictions' om det finns förekomster av text i 'otherConstraints'</sch:assert>
      <sch:report test="$accessConstraints_value = 'otherRestrictions'">[Geodata.se:110d](2.9.1) Limitation on public access (otherConstraints) found:
                <sch:value-of select="."/>
      </sch:report>
    </sch:rule>
-->
    <!--<sch:rule context="//gmd:identificationInfo">
      <sch:let name="useLimitation" value="//gmd:resourceConstraints/*/gmd:useLimitation//text()/normalize-space(.)"/>
      <sch:let name="useLimitation_count"
               value="count(//gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints/*/gmd:useLimitation/*/text()/normalize-space(.))"/>
      <sch:assert test="$useLimitation_count">[Geodata.se:110e] Information om användbarhetsbegränsningar saknas</sch:assert>
	</sch:rule>-->
  </sch:pattern>



  <sch:pattern fpi="[Geodata.se:112a] Resurskontakt måste anges">
    <sch:title>[Geodata.se:112a] Resurskontakt måste anges </sch:title>
    <sch:rule context="//gmd:identificationInfo[1]/*">
      <sch:assert test="(gmd:pointOfContact)">[Geodata.se:112a] Resurskontakt måste anges</sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="[Geodata.se:112b] Kontaktinformation måste anges med organisationsnamn och epostadress ">
    <sch:title>[Geodata.se:112b] Kontaktinformation måste anges med organisationsnamn och epostadress </sch:title>
    <sch:rule context="//gmd:identificationInfo[1]/*">
<!--    <sch:let name="pointOfContact-exists" value="gmd:pointOfContact" /> -->
	<sch:let name="organisationName" value="gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:organisationName" />
	<sch:let name="emailAddress" value="gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress" />
	<sch:assert
        test="$organisationName and $emailAddress"
      >[Geodata.se:112b] Kontaktinformation måste anges med organisationsnamn och epostadress</sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="[Geodata.se:112c] Kontaktinformation inom Infrastrukturen för geodata måste ha en resurskontakt som har ansvarsområdet(rollen)  ägare">
    <sch:title>[Geodata.se:112c] Kontaktinformation inom Infrastrukturen för geodata måste ha en resurskontakt som har ansvarsområdet(rollen)  ägare </sch:title>
    <sch:rule context="//gmd:identificationInfo[1]/*">
      <sch:assert
        test="((gmd:pointOfContact) and (gmd:pointOfContact/gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode[@codeListValue ='owner']) )"
      >[Geodata.se:112c] Kontaktinformation inom Infrastrukturen för geodata måste ha en resurskontakt som har ansvarsområdet(rollen) ägare</sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="Ansvarig organisation">
    <sch:title>[Geodata.se:112b] Ansvarig organisation </sch:title>
    <sch:rule context="//gmd:identificationInfo[1]/*">
      <sch:let name="organisationName" value="gmd:pointOfContact/*/gmd:organisationName/*/text()"/>
      <sch:let name="role" value="gmd:pointOfContact/*/gmd:role/*/@codeListValue"/>
      <sch:let name="role_present" value="gmd:pointOfContact/*/gmd:role/*/@codeListValue = 'resourceProvider' or
				gmd:pointOfContact/*/gmd:role/*/@codeListValue = 'custodian' or
				gmd:pointOfContact/*/gmd:role/*/@codeListValue = 'owner' or
				gmd:pointOfContact/*/gmd:role/*/@codeListValue = 'user' or
				gmd:pointOfContact/*/gmd:role/*/@codeListValue = 'distributor' or
				gmd:pointOfContact/*/gmd:role/*/@codeListValue = 'originator' or
				gmd:pointOfContact/*/gmd:role/*/@codeListValue = 'pointOfContact' or
				gmd:pointOfContact/*/gmd:role/*/@codeListValue = 'principalInvestigator' or
				gmd:pointOfContact/*/gmd:role/*/@codeListValue = 'processor' or
				gmd:pointOfContact/*/gmd:role/*/@codeListValue = 'publisher' or
				gmd:pointOfContact/*/gmd:role/*/@codeListValue = 'author'"/>
      <sch:let name="emailAddress" value="gmd:pointOfContact/*/gmd:contactInfo/*/gmd:address/*/gmd:electronicMailAddress/*/text()"/>
      <!-- assertions and report -->
      <sch:assert test="$organisationName">[Geodata.se:112b] Kontaktinformation måste anges med organisationsnamn </sch:assert>
      <!--			<sch:report test="$organisationName">(2.10.1) Organisation name (Resource) found:
              <sch:value-of select="$organisationName"/>
            </sch:report>
      -->
	  <sch:assert test="$emailAddress">[Geodata.se:112e] Kontaktinformation måste anges med epost </sch:assert>
      <sch:assert test="$role_present">[Geodata.se:112d] Ansvarsområde är angiven med felaktig roll</sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="[Geodata.se:113a] Metadatakontakt måste anges">
    <sch:title>[Geodata.se:113a] Metadatakontakt måste anges </sch:title>
    <sch:rule context="//gmd:MD_Metadata">
      <sch:assert test="(gmd:contact/gmd:CI_ResponsibleParty)">[Geodata.se:113a] Metadatakontakt måste anges</sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="[Geodata.se:113c] Metadatakontakt måste ha epostadress och organisation angiven">
    <sch:title>[Geodata.se:113c] Metadatakontakt måste ha epostadress och organisation angiven </sch:title>
    <sch:rule context="//gmd:MD_Metadata">
      <sch:assert
        test="((gmd:contact/gmd:CI_ResponsibleParty/gmd:organisationName) and (gmd:contact/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress))"
      >[Geodata.se:113c] Metadatakontakt måste ha epostadress och organisation angiven</sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="[Geodata.se:113d] Metadatakontakt måste ha rollen Kontakt(pointOfContact) angiven ">
    <sch:title>[Geodata.se:113d] Metadatakontakt måste ha rollen Kontakt(pointOfContact) angiven </sch:title>
    <sch:rule context="//gmd:MD_Metadata">
      <sch:assert
        test="gmd:contact/*/gmd:role/*/@codeListValue = 'pointOfContact'"
      >[Geodata.se:113d] Metadatakontakt måste ha rollen Kontakt(pointOfContact) angiven </sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="[Geodata.se:114] - Metadataspråk måste anges">
    <sch:title>[Geodata.se:114] - Metadataspråk måste anges </sch:title>
    <sch:rule context="//gmd:MD_Metadata|//*[@gco:isoType='gmd:MD_Metadata']">
      <sch:assert
       test="gmd:language and ((normalize-space(gmd:language/gco:CharacterString/text()) != '') or (gmd:language/gmd:LanguageCode) or (gmd:language/@gco:nilReason and contains('inapplicable missing template unknown withheld',gmd:language/@gco:nilReason)))"
      >[Geodata.se:114] Metadataspråk saknas.</sch:assert>
      <!--			<sch:assert test="gmd:language">[Geodata.se:114b] Metadataspråk saknas.</sch:assert> -->
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="[Geodata.se:116] Datum för metadata måste anges">
    <sch:title>[Geodata.se:116] Datum för metadata måste anges </sch:title>
    <sch:rule context="//gmd:MD_Metadata|//*[@gco:isoType='gmd:MD_Metadata']">
      <sch:assert test="string-length(normalize-space(gmd:dateStamp/*/text())) &gt; 0">[Geodata.se:116] Datum för metadata måste anges</sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="[Geodata.se:119]">
    <sch:title>[Geodata.se:118] och [Geodata.se:119] </sch:title>
    <sch:rule context="//gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorTransferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine/gmd:CI_OnlineResource">
      <sch:let name="resourceLocator" value="gmd:linkage/*/text()"/>
      <sch:let name="protocol" value="gmd:protocol/*/text()"/>

      <sch:let name="resourceLocatorLen" value="string-length(gmd:linkage/*/text())"/>
      <sch:let name="protocolLen" value="string-length(gmd:protocol/*/text())"/>
      <sch:let name="protocolCorrect" value="gmd:protocol/*/text() = 'HTTP:OGC:WMS' or
				gmd:protocol/*/text() = 'HTTP:OGC:WFS' or
				gmd:protocol/*/text() = 'HTTP:OGC:WCS' or
				gmd:protocol/*/text() = 'HTTP:Nedladdning' or
				gmd:protocol/*/text() = 'HTTP:Nedladdning:Atom' or
				gmd:protocol/*/text() = 'HTTP:Nedladdning:GUI' or
				gmd:protocol/*/text() = 'HTTP:Nedladdning:API' or
				gmd:protocol/*/text() = 'HTTP:OGC:API-Features' or
				gmd:protocol/*/text() = 'HTTP:OGC:API-Maps' or
				gmd:protocol/*/text() = 'HTTP:OGC:API-Coverages' or
				gmd:protocol/*/text() = 'HTTP:OGC:API-Records' or
				gmd:protocol/*/text() = 'HTTP:OGC:CSW' or				
				gmd:protocol/*/text() = 'HTTP:Information' or
				gmd:protocol/*/text() = 'HTTP:Information:Produktspecifikation'" />

      <!-- assertions and report -->
      <!--	<sch:report test="$resourceLocator">(2.2.4) Resource locator found: <sch:value-of
            select="$resourceLocator"/>,   <sch:value-of
              select="$protocol"/>, <sch:value-of
                select="$protocolCorrect"/>
          </sch:report>-->

      <sch:assert	test="not($resourceLocator) or (($resourceLocator and ($resourceLocatorLen &gt; 0)) and ($protocol and $protocolCorrect))" >
        [Geodata.se:119] Om länk til resurs anges skall även protokoll anges med korrekt värde #<sch:value-of
        select="$protocol"/># ,  <sch:value-of
        select="$resourceLocator"/>

      </sch:assert>
    </sch:rule>

    <sch:rule context="//gmd:hierarchyLevel[1]/*[@codeListValue ='service']">
      <sch:assert	test="(//gmd:transferOptions/*/gmd:onLine/*/gmd:linkage or //gmd:distributorTransferOptions/*/gmd:onLine/*/gmd:linkage)"
      >[Geodata.se:118] Tillhandahållande adress måste anges om sådan finns</sch:assert>
    </sch:rule>

  </sch:pattern>

  <!-- INSPIRE metadata rules / END -->
  <!-- Kontroller för Geodata.se -->
  <!-- Kontrollera att fileidentifier finns med-->
  <sch:pattern fpi=" [Geodata.se:123] Identifierare för metadatamängden">
    <sch:title> [Geodata.se:123] Identifierare för metadatamängden</sch:title>
    <sch:rule context="//gmd:MD_Metadata|//*[@gco:isoType='gmd:MD_Metadata']">
      <sch:assert
        test="gmd:fileIdentifier and (gmd:fileIdentifier/gco:CharacterString/normalize-space(.) != '') ">[Geodata.se:123] Identiferare för metadatamängden krävs.</sch:assert>
      <!-- the text "fileIdentifier not present" only gets emitted if the assertion fails -->
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="[Geodata.se:124] Metadatastandard måste anges">
    <sch:title>[Geodata.se:124] Metadatastandard måste anges</sch:title>
    <sch:rule context="//gmd:MD_Metadata|//*[@gco:isoType='gmd:MD_Metadata']">
      <sch:assert test="gmd:metadataStandardName/gco:CharacterString">[Geodata.se:124] Metadatastandard måste anges</sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="[Geodata.se:125] Geograpfisk utsträckning">
    <sch:title>[Geodata.se:125] Kontroll av geografisk utsträckning</sch:title>
    <sch:rule context="//gmd:identificationInfo/gmd:MD_DataIdentification">
      <!--<sch:rule context="//gmd:identificationInfo[1]/gmd:MD_DataIdentification/*">-->
      <sch:let name="west" value="//gmd:geographicElement/*/gmd:westBoundLongitude[1]/*"/>
      <sch:let name="east" value="//gmd:geographicElement/*/gmd:eastBoundLongitude[1]/*"/>
      <sch:let name="north" value="//gmd:geographicElement/*/gmd:northBoundLatitude[1]/*"/>
      <sch:let name="south" value="//gmd:geographicElement/*/gmd:southBoundLatitude[1]/*"/>

      <sch:let name="westDecimals" value="concat('',substring(substring-after($west[1], '.'), 1, 2))"/>
      <sch:let name="eastDecimals" value="concat('',substring(substring-after($east[1], '.'), 1, 2))"/>
      <sch:let name="northDecimals" value="concat('',substring(substring-after($north[1], '.'), 1, 2))"/>
      <sch:let name="southDecimals" value="concat('',substring(substring-after($south[1], '.'), 1, 2))"/>

      <!--			<sch:let name="west" value="number(//gmd:geographicElement/*/gmd:westBoundLongitude[1]/*)"/>
            <sch:let name="east" value="number(//gmd:geographicElement/*/gmd:eastBoundLongitude[1]/*)"/>
            <sch:let name="north" value="number(//gmd:geographicElement/*/gmd:northBoundLatitude[1]/*)"/>
            <sch:let name="south" value="number(//gmd:geographicElement/*/gmd:southBoundLatitude[1]/*)"/>
      -->
      <!-- assertions and report -->
      <!--    <sch:report test="$west">West: <sch:value-of select="$west[1]"/>	</sch:report>
      <sch:report test="$east">East: <sch:value-of select="$east[1]"/>	</sch:report>
      <sch:report test="$south">South: <sch:value-of select="$south[1]"/>	</sch:report>
      <sch:report test="$north">North: <sch:value-of select="$north[1]"/>	</sch:report>-->

      <!-- Check values are filled and with valid values -->
      <sch:assert test="string($west[1]) and (-180.00 &lt;= $west[1]) and ( $west[1] &lt;= 180.00)">[Geodata.se:125] Västlig koordinat saknas eller har fel värde:  <sch:value-of select="$west[1]"/></sch:assert>

      <sch:assert test="string($east[1]) and (-180.00 &lt;= $east[1]) and ($east[1] &lt;= 180.00)">[Geodata.se:125] Östlig koordinat saknas eller har fel värde</sch:assert>

      <sch:assert test="string($south[1]) and (-90.00 &lt;= $south[1]) and ($south[1] &lt;= $north)">[Geodata.se:125] Syd koordinat saknas eller har fel värde</sch:assert>

      <sch:assert test="string($north[1]) and  ($south[1] &lt;= $north[1]) and ($north[1] &lt;= 90.00)">[Geodata.se:125] Nordlig koordinat saknas eller har fel värde</sch:assert>


      <!-- Check the number of decimals equal or greater than 2 -->
<!--      <sch:assert test="not(string($west[1])) or string-length($westDecimals) >= 2">Västlig koordinat kräver 2 decimaler</sch:assert>

      <sch:assert test="not(string($east[1])) or string-length($eastDecimals) >= 2">Östlig koordinat kräver 2 decimaler</sch:assert>

      <sch:assert test="not(string($south[1])) or string-length($southDecimals) >= 2">Syd koordinat kräver 2 decimaler</sch:assert>

      <sch:assert test="not(string($north[1])) or string-length($northDecimals) >= 2">Nordlig koordinat kräver 2 decimaler</sch:assert>
-->
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="[Geodata.se:126] ">
    <sch:title>[Geodata.se:126]Om format anges skall även version för formatet anges </sch:title>

    <sch:rule context="/gmd:MD_Metadata/gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor">
 	  <sch:let name="MDFormatPresent" value="count(/gmd:MD_Metadata/gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorFormat) > 0" />
    </sch:rule>

    <sch:rule context="/gmd:MD_Metadata/gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorFormat">
      <sch:let name="MDFormat" value="normalize-space(gmd:MD_Format/gmd:name/gco:CharacterString)" />
      <sch:let name="MDFormatVers" value="normalize-space(gmd:MD_Format/gmd:version/gco:CharacterString)" />
      <sch:let name="MDFormatLen" value="string-length(normalize-space(gmd:MD_Format/gmd:name/gco:CharacterString))" />
      <sch:let name="MDFormatVersLen" value="string-length(normalize-space(gmd:MD_Format/gmd:version/gco:CharacterString))" />

      <sch:assert	test="$MDFormat and $MDFormatVers and ($MDFormatLen &gt; 1) and  ($MDFormatVersLen &gt; 0)" >
        [Geodata.se:126]Om format anges skall även version för formatet anges: <sch:value-of select="$MDFormat" />
      </sch:assert>
<!--
      <sch:report test="$MDFormat"><sch:value-of select="$MDFormat" />
        !<sch:value-of select="$MDFormatVers" />
        !<sch:value-of select="$MDFormatLen" />
        !<sch:value-of select="$MDFormatVersLen" />
        !
      </sch:report>
      <sch:report test="$MDFormatVers">
        #<sch:value-of select="$MDFormat" />
        #<sch:value-of select="$MDFormatVers" />
        #<sch:value-of select="$MDFormatLen" />
        #<sch:value-of select="$MDFormatVersLen" />
        #
      </sch:report>
-->
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="[Geodata.se:127]">
    <sch:title>[Geodata.se:127] Om en kvantitativ kvalitetsrapport anges måste den vara fullständig </sch:title>

<!--    <sch:rule context="//gmd:MD_Metadata/gmd:dataQualityInfo/*/gmd:report/*/gmd:DQ_QuantitativeResult"> -->
    <sch:rule context="//gmd:DQ_QuantitativeResult">
      <sch:let name="value" value="gmd:value/gco:Record"/>
<!--      <sch:let name="recordType" value="gmd:valueType/gco:RecordType/text()"/>
      <sch:let name="valueUnit" value="gmd:valueUnit/@xlink:title"/>
      <sch:let name="recordTypeLen" value="gmd:valueType/gco:RecordType/text()"/>
      <sch:let name="valueUnitLen" value="gmd:valueUnit/@xlink:title"/>
-->
      <sch:let name="valueLen" value="string-length(normalize-space(gmd:value/gco:Record/text()))"/>

      <!--	<sch:report test="$recordType">	<sch:value-of select="$recordType"/></sch:report>
        <sch:report test="$valueUnit">	<sch:value-of select="$valueUnit"/></sch:report>
        <sch:report test="$value">	<sch:value-of select="$value"/></sch:report>
        <sch:report test="$valueLen">	<sch:value-of select="$valueLen"/></sch:report>
        <sch:report test="$recordType and $valueUnit and $value">	</sch:report>-->

<!--  Harvested metadata doesn't get the xlink:title and xlink:href fields (something in Geonetwork removes them). This now matches the schematron rules in the old portal
      <sch:assert test="$recordType and $valueUnit and $value" >[Geodata.se:127] Om en kvantitativ kvalitetsrapport skall anges måste värde, värdeenhet och värdetyp anges Värde=<sch:value-of select="$value"/>   Värdetyp=<sch:value-of select="$recordType"/>  Värdeenhet=<sch:value-of select="$valueUnit"/>  </sch:assert>
      <sch:assert test="$recordType" >[Geodata.se:127a] Om en kvantitativ kvalitetsrapport skall anges måste värde, värdeenhet och värdetyp anges - värdetyp saknas </sch:assert>
      <sch:assert test="$valueUnit" >[Geodata.se:127b] Om en kvantitativ kvalitetsrapport skall anges måste värde, värdeenhet och värdetyp anges - värdeenhet saknas </sch:assert>
-->
      <sch:assert test="($valueLen &gt; 0)" >[Geodata.se:127c] Om en kvantitativ kvalitetsrapport skall anges måste värde, värdeenhet och värdetyp anges - värde saknas </sch:assert>

    </sch:rule>
  </sch:pattern>
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
