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

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:gmd="http://www.isotc211.org/2005/gmd"
                xmlns:gco="http://www.isotc211.org/2005/gco"
                xmlns:gmx="http://www.isotc211.org/2005/gmx"
                xmlns:srv="http://www.isotc211.org/2005/srv"
                xmlns:gml="http://www.opengis.net/gml"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:tr="java:org.fao.geonet.api.records.formatters.SchemaLocalizations"
                xmlns:gn-fn-render="http://geonetwork-opensource.org/xsl/functions/render"
                xmlns:gn-fn-metadata="http://geonetwork-opensource.org/xsl/functions/metadata"
                xmlns:gn-fn-iso19139="http://geonetwork-opensource.org/xsl/functions/profiles/iso19139"
                xmlns:saxon="http://saxon.sf.net/"
                version="2.0"
                extension-element-prefixes="saxon"
                exclude-result-prefixes="#all">
  <!-- This formatter render an ISO19139 record based on the
  editor configuration file.


  The layout is made in 2 modes:
  * render-field taking care of elements (eg. sections, label)
  * render-value taking care of element values (eg. characterString, URL)

  3 levels of priority are defined: 100, 50, none

  -->


  <!-- Load the editor configuration to be able
  to render the different views -->
  <xsl:variable name="configuration"
                select="document('../../layout/config-editor.xml')"/>

 <!-- Required for utility-fn.xsl -->
  <xsl:variable name="editorConfig"
                select="document('../../layout/config-editor.xml')"/>

  <!-- Some utility -->
  <xsl:include href="../../layout/evaluate.xsl"/>
  <xsl:include href="../../layout/utility-tpl-multilingual.xsl"/>
  <xsl:include href="../../layout/utility-fn.xsl"/>

  <!-- The core formatter XSL layout based on the editor configuration -->
  <xsl:include href="sharedFormatterDir/xslt/render-layout.xsl"/>
  <!--<xsl:include href="../../../../../data/formatter/xslt/render-layout.xsl"/>-->

  <!-- Define the metadata to be loaded for this schema plugin-->
  <xsl:variable name="metadata"
                select="/root/gmd:MD_Metadata"/>

  <xsl:variable name="langId" select="gn-fn-iso19139:getLangId($metadata, $language)"/>

  <!-- Specific schema rendering -->
  <xsl:template mode="getMetadataTitle" match="gmd:MD_Metadata">
    <xsl:for-each select="gmd:identificationInfo/*/gmd:citation/*/gmd:title">
      <xsl:call-template name="localised">
        <xsl:with-param name="langId" select="$langId"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="getMetadataAbstract" match="gmd:MD_Metadata">
    <xsl:for-each select="gmd:identificationInfo/*/gmd:abstract">
      <xsl:call-template name="localised">
        <xsl:with-param name="langId" select="$langId"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>

  <xsl:template mode="getMetadataHierarchyLevel" match="gmd:MD_Metadata">
    <xsl:value-of select="gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue"/>
  </xsl:template>

  <xsl:template mode="getMetadataHeader" match="gmd:MD_Metadata">
  </xsl:template>


  <!-- Most of the elements are ... -->
  <xsl:template mode="render-field"
                match="*[gco:Integer|gco:Decimal|
       gco:Boolean|gco:Real|gco:Measure|gco:Length|gco:Distance|
       gco:Angle|gmx:FileName|
       gco:Scale|gco:Record|gco:RecordType|gmx:MimeFileType|gmd:URL|
       gco:LocalName|gmd:PT_FreeText|gml:beginPosition|gml:endPosition|
       gco:Date|gco:DateTime|*/@codeListValue]"
                priority="50">
    <xsl:param name="fieldName" select="''" as="xs:string"/>

    <dl>
      <dt>
        <xsl:value-of select="if ($fieldName)
                                then $fieldName
                                else tr:node-label(tr:create($schema), name(), null)"/>
      </dt>
      <dd>
        <xsl:apply-templates mode="render-value" select="*|*/@codeListValue"/>
        <xsl:apply-templates mode="render-value" select="@*"/>
      </dd>
    </dl>
  </xsl:template>

  <xsl:template mode="render-field"
                match="*[gco:CharacterString]"
                priority="50">
    <xsl:param name="fieldName" select="''" as="xs:string"/>

    <dl>
      <dt>
        <xsl:value-of select="if ($fieldName)
                                then $fieldName
                                else tr:node-label(tr:create($schema), name(), null)"/>
      </dt>
      <dd>
        <xsl:apply-templates mode="render-value" select="."/>
        <xsl:apply-templates mode="render-value" select="@*"/>
      </dd>
    </dl>
  </xsl:template>

  <!-- Some elements are only containers so bypass them -->
  <xsl:template mode="render-field"
                match="*[count(gmd:*[name() != 'gmd:PT_FreeText']) = 1]"
                priority="50">

    <xsl:apply-templates mode="render-value" select="@*"/>
    <xsl:apply-templates mode="render-field" select="*"/>
  </xsl:template>


  <!-- Some major sections are boxed -->
  <xsl:template mode="render-field"
                match="*[name() = $configuration/editor/fieldsWithFieldset/name
    or @gco:isoType = $configuration/editor/fieldsWithFieldset/name]|
      gmd:report/*|
      gmd:result/*|
      gmd:extent[name(..)!='gmd:EX_TemporalExtent']|
      *[$isFlatMode = false() and gmd:* and not(gco:CharacterString) and not(gmd:URL)]">

    <div class="entry name">
      <h3>
        <xsl:value-of select="tr:node-label(tr:create($schema), name(), null)"/>
        <xsl:apply-templates mode="render-value"
                             select="@*"/>
      </h3>
      <div class="target">
        <xsl:apply-templates mode="render-field" select="*"/>
      </div>
    </div>
  </xsl:template>


  <!-- Bbox is displayed with an overview and the geom displayed on it
  and the coordinates displayed around -->
  <xsl:template mode="render-field"
                match="gmd:EX_GeographicBoundingBox[
          gmd:westBoundLongitude/gco:Decimal != '']">
    <xsl:variable name="west">
		<xsl:value-of select="xs:double(gmd:westBoundLongitude/gco:Decimal)"/>
	</xsl:variable>
	<xsl:variable name="north">
		<xsl:value-of select="xs:double(gmd:northBoundLatitude/gco:Decimal)"/>
	</xsl:variable>
	<xsl:variable name="east">
		<xsl:value-of select="xs:double(gmd:eastBoundLongitude/gco:Decimal)"/>
	</xsl:variable>
	<xsl:variable name="south">
		<xsl:value-of select="xs:double(gmd:southBoundLatitude/gco:Decimal)"/>
	</xsl:variable>

	<xsl:if test="$west != 0 and $north != 0 and $east != 0 and $south != 0">
		<xsl:copy-of select="gn-fn-render:bbox(
                            xs:double(gmd:westBoundLongitude/gco:Decimal),
                            xs:double(gmd:southBoundLatitude/gco:Decimal),
                            xs:double(gmd:eastBoundLongitude/gco:Decimal),
                            xs:double(gmd:northBoundLatitude/gco:Decimal))"/>
	</xsl:if>
	<xsl:apply-templates mode="render-field" select="gmd:westBoundLongitude"/>
	<xsl:apply-templates mode="render-field" select="gmd:eastBoundLongitude"/>
	<xsl:apply-templates mode="render-field" select="gmd:southBoundLatitude"/>
	<xsl:apply-templates mode="render-field" select="gmd:northBoundLatitude"/>
  </xsl:template>


  <!-- A contact is displayed with its role as header -->
  <xsl:template mode="render-field"
                match="*[gmd:CI_ResponsibleParty]"
                priority="100">
    <xsl:variable name="email">
      <xsl:apply-templates mode="render-value-no-breaklines"
                           select="*/gmd:contactInfo/
                                      */gmd:address/*/gmd:electronicMailAddress"/>
    </xsl:variable>

    <!-- Display name is <org name> - <individual name> (<position name> -->
    <xsl:variable name="displayName">
      <xsl:choose>
        <xsl:when
                test="normalize-space(*/gmd:organisationName) != '' and normalize-space(*/gmd:individualName) != ''">
          <!-- Org name may be multilingual -->
          <xsl:apply-templates mode="render-value-no-breaklines"
                               select="*/gmd:organisationName"/>
          -
          <xsl:value-of select="*/gmd:individualName"/>
          <xsl:if test="normalize-space(*/gmd:positionName) != ''">
            (<xsl:apply-templates mode="render-value-no-breaklines"
                                  select="*/gmd:positionName"/>)
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="*/gmd:organisationName|*/gmd:individualName"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <dl class="gn-contact">
      <dt>
        <!-- <xsl:apply-templates mode="render-value"
                             select="*/gmd:role/*/@codeListValue"/> -->
		<xsl:variable name="parentNodeNameForCI_ResponsibleParty">
			<xsl:value-of select="name(.)"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="normalize-space($parentNodeNameForCI_ResponsibleParty) = 'gmd:contact'">
				<xsl:value-of select="gn-fn-render:get-schema-strings($schemaStrings, 'metadataContactView')"/>
			</xsl:when>
			<xsl:when test="normalize-space($parentNodeNameForCI_ResponsibleParty) = 'gmd:distributorContact'">
				<xsl:value-of select="gn-fn-render:get-schema-strings($schemaStrings, 'distributorContactView')"/>
			</xsl:when>
			<xsl:otherwise>
			  <xsl:apply-templates mode="render-value" select="*/gmd:role/*/@codeListValue"/>
			</xsl:otherwise>
		</xsl:choose>
      </dt>
      <dd>
        <div class="col-md-6">
                <xsl:variable name="email">
					<xsl:value-of select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>
				</xsl:variable>
          <address>
            <strong>
              <xsl:choose>
                <xsl:when test="normalize-space($email) != ''">
                  <i class="fa fa-envelope"></i>
                  <a href="mailto:{normalize-space($email)}"><xsl:value-of select="$displayName"/></a>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="$displayName"/>
                </xsl:otherwise>
              </xsl:choose>
            </strong>
            <xsl:for-each select="*/gmd:contactInfo/*">
              <xsl:for-each select="gmd:address/*/(
                                          gmd:deliveryPoint|gmd:city|
                                          gmd:administrativeArea|gmd:postalCode|gmd:country)">
                <xsl:apply-templates mode="render-value-no-breaklines" select="."/>
              </xsl:for-each>
            </xsl:for-each>
          </address>
        </div>
        <div class="col-md-6">
          <address>
            <xsl:for-each select="*/gmd:contactInfo/*">
              <xsl:for-each select="gmd:phone/*/gmd:voice[normalize-space(.) != '']">
                <xsl:variable name="phoneNumber">
                  <xsl:apply-templates mode="render-value-no-breaklines" select="."/>
                </xsl:variable>
                <i class="fa fa-phone"></i>
                <a href="tel:{$phoneNumber}">
                  <xsl:value-of select="$phoneNumber"/>
                </a>
              </xsl:for-each>
              <xsl:for-each select="gmd:phone/*/gmd:facsimile[normalize-space(.) != '']">
                <xsl:variable name="phoneNumber">
                  <xsl:apply-templates mode="render-value-no-breaklines" select="."/>
                </xsl:variable>
                <i class="fa fa-fax"></i>
                <a href="tel:{normalize-space($phoneNumber)}">
                  <xsl:value-of select="normalize-space($phoneNumber)"/>
                </a>
              </xsl:for-each>

			  <xsl:variable name="website">
					<xsl:apply-templates mode="render-value"
                           select="gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL"/>
			  </xsl:variable>
			  <xsl:if test="$website !=''">
				-
				<a href="http://{$website}" target="_blank">
					<xsl:value-of select="normalize-space($website)"/>
				</a>
			  </xsl:if>
              <xsl:apply-templates mode="render-field"
                                   select="gmd:hoursOfService|gmd:contactInstructions"/>
              <xsl:apply-templates mode="render-field"
                                   select="gmd:onlineResource"/>

            </xsl:for-each>
          </address>
        </div>
      </dd>
    </dl>
  </xsl:template>

  <!-- A Resursetyp is displayed with its translated codeListValue -->
  <xsl:template mode="render-field"
                match="gmd:hierarchyLevel"
                priority="100">
    <dl class="gn-contact">
      <dt>
        <xsl:value-of select="gn-fn-render:get-schema-strings($schemaStrings, 'hierarchyLevel')"/>
      </dt>
      <dd>
        <xsl:apply-templates mode="render-value"
                             select="gmd:MD_ScopeCode/@codeListValue"/>

      </dd>
    </dl>
  </xsl:template>

  <!-- A maintenanceAndUpdateFrequency is displayed with its translated codeListValue -->
  <xsl:template mode="render-field"
                match="gmd:resourceMaintenance"
                priority="100">
    <xsl:param name="fieldName" select="''" as="xs:string"/>


    <dl class="gn-contact">
      <dt>
        <xsl:value-of select="if ($fieldName)
                                  then $fieldName
                                  else tr:node-label(tr:create($schema), name(), null)"/>
      </dt>
      <dd>
        <dl class="gn-contact">
          <dt>
            <xsl:value-of select="tr:node-label(tr:create($schema), 'gmd:maintenanceAndUpdateFrequency', null)"/>
          </dt>
          <dd>
            <xsl:apply-templates mode="render-value"
                                 select="gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode/@codeListValue"/>

          </dd>
        </dl>

        <dl>
          <dt>
            <xsl:value-of select="tr:node-label(tr:create($schema), 'gmd:maintenanceNote', null)"/>
          </dt>
          <dd>
            <xsl:apply-templates mode="render-value" select="gmd:MD_MaintenanceInformation/gmd:maintenanceNote"/>
          </dd>
        </dl>
      </dd>
    </dl>
  </xsl:template>

  <xsl:template mode="render-field"
                match="gmd:maintenanceAndUpdateFrequency"
                priority="100">
    <xsl:param name="fieldName" select="''" as="xs:string"/>


    <dl class="gn-contact">
      <dt>
        <xsl:value-of select="if ($fieldName)
                                  then $fieldName
                                  else tr:node-label(tr:create($schema), name(), null)"/>
      </dt>
      <dd>
        <xsl:apply-templates mode="render-value"
                             select="gmd:MD_MaintenanceFrequencyCode/@codeListValue"/>

      </dd>
    </dl>
  </xsl:template>


  <xsl:template mode="render-field"
                match="gmd:maintenanceNote"
                priority="100">
    <xsl:param name="fieldName" select="''" as="xs:string"/>

    <dl>
      <dt>
        <xsl:value-of select="if ($fieldName)
                                then $fieldName
                                else tr:node-label(tr:create($schema), name(), null)"/>
      </dt>
      <dd>
        <xsl:apply-templates mode="render-value" select="."/>
        <xsl:apply-templates mode="render-value" select="@*"/>
      </dd>
    </dl>
  </xsl:template>

  <!-- Metadata linkage -->
  <xsl:template mode="render-field"
                match="gmd:fileIdentifier"
                priority="100">
    <dl>
      <dt>
        <xsl:value-of select="tr:node-label(tr:create($schema), name(), null)"/>
      </dt>
      <dd>
        <xsl:apply-templates mode="render-value-no-breaklines" select="*"/>
        <xsl:apply-templates mode="render-value" select="@*"/>

        <a class="btn btn-link" href="xml.metadata.get?id={$metadataId}">
          <i class="fa fa-file-code-o fa-2x"></i>
          <span data-translate="">metadataInXML</span>
        </a>
      </dd>
    </dl>
  </xsl:template>

  <!-- Linkage -->
  <!-- <xsl:template mode="render-field"
                match="*[gmd:CI_OnlineResource and */gmd:linkage/gmd:URL != '']"
                priority="100">
    <dl class="gn-link"
        itemprop="distribution"
        itemscope="itemscope"
        itemtype="http://schema.org/DataDownload">
      <dt>
        <xsl:value-of select="tr:node-label(tr:create($schema), name(), null)"/>
      </dt>
      <dd>
        <xsl:variable name="linkDescription">
          <xsl:apply-templates mode="render-value"
                               select="*/gmd:description"/>
        </xsl:variable>
        <a href="{*/gmd:linkage/gmd:URL}">
          <xsl:apply-templates mode="render-value"
                               select="*/gmd:name"/>
        </a>
        <p>
          <xsl:value-of select="normalize-space($linkDescription)"/>
        </p>
      </dd>
    </dl>
  </xsl:template> -->

  <!-- Display only gmd:distributorTransferOptions -->
  <xsl:template mode="render-field"
                match="gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine[1]"
                priority="100" />

  <xsl:template mode="render-field"
                match="gmd:distributorTransferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine[1]"
                priority="100">

		<dl class="gn-link">
			<dt>
				<xsl:value-of select="gn-fn-render:get-schema-strings($schemaStrings, 'onLinkLinks')"/>
			</dt>
			<dd>
				<table class="view-metadata-table">
					<tr>
						<th class="view-metadata-table-th-1">
							<xsl:value-of select="gn-fn-render:get-schema-strings($schemaStrings, 'onLineLinkProtocol')"/>
						</th>
						<th class="view-metadata-table-th-2">
							<xsl:value-of select="gn-fn-render:get-schema-strings($schemaStrings, 'onLineLinkName')"/>
						</th>
            <th class="view-metadata-table-th-3">
              <xsl:value-of select="gn-fn-render:get-schema-strings($schemaStrings, 'onLineLinkDescription')"/>
            </th>
            <th class="view-metadata-table-th-4">
							<xsl:value-of select="gn-fn-render:get-schema-strings($schemaStrings, 'onLineLinkUrl')"/>
						</th>

					</tr>
					<xsl:for-each select="parent::node()/gmd:onLine">
						<xsl:variable name="protocol">
							<xsl:apply-templates mode="render-value-no-breaklines" select="*/gmd:protocol"/>
						</xsl:variable>
						<xsl:variable name="aliasProtocol">
							<xsl:choose>
								<xsl:when test="normalize-space($protocol) = 'HTTP:OGC:WFS'">
									<xsl:value-of select="gn-fn-render:get-schema-strings($schemaStrings, 'http_ogc_wfs')"/>
								</xsl:when>
								<xsl:when test="normalize-space($protocol) = 'HTTP:OGC:WMS'">
									<xsl:value-of select="gn-fn-render:get-schema-strings($schemaStrings, 'http_ogc_wms')"/>
								</xsl:when>
								<xsl:when test="normalize-space($protocol) = 'HTTP:Information'">
									<xsl:value-of select="gn-fn-render:get-schema-strings($schemaStrings, 'http_information')"/>
								</xsl:when>
								<xsl:when test="normalize-space($protocol) = 'HTTP:Nedladdning'">
									<xsl:value-of select="gn-fn-render:get-schema-strings($schemaStrings, 'http_nedladdning')"/>
								</xsl:when>
								<xsl:when test="normalize-space($protocol) = 'HTTP:Nedladdning:ATOM'">
									<xsl:value-of select="gn-fn-render:get-schema-strings($schemaStrings, 'http_nedladdning_atom')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$protocol"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="name">
							<xsl:apply-templates mode="render-value-no-breaklines" select="*/gmd:name"/>
            </xsl:variable>
            <xsl:variable name="description">
              <xsl:apply-templates mode="render-value" select="*/gmd:description"/>
            </xsl:variable>
						<xsl:variable name="url">
							<xsl:apply-templates mode="render-value" select="*/gmd:linkage/gmd:URL"/>
						</xsl:variable>
						<tr>
							<td class="view-metadata-table-td-1">
								<xsl:value-of select="normalize-space($aliasProtocol)"/>
							</td>
							<td class="view-metadata-table-td-2">
								<xsl:value-of select="normalize-space($name)"/>
							</td>
              <td class="view-metadata-table-td-3">
                <xsl:value-of select="normalize-space($description)"/>
              </td>
              <td class="view-metadata-table-td-4">
								<xsl:choose>
									<xsl:when test="normalize-space($protocol) = 'HTTP:Information'">
										<a href="{$url}" target="_blank">
											<xsl:value-of select="normalize-space($url)"/>
										</a>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="normalize-space($url)"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</xsl:for-each>
				</table>
			</dd>
		</dl>
  </xsl:template>

  <xsl:template mode="render-field" match="gmd:onLine[position() > 1]" priority="100"/>

  <!-- Identifier -->
  <xsl:template mode="render-field"
                match="*[(gmd:RS_Identifier or gmd:MD_Identifier) and
                  */gmd:code/gco:CharacterString != '']"
                priority="100">
    <dl class="gn-code">
      <dt>
        <xsl:value-of select="tr:node-label(tr:create($schema), name(), null)"/>
      </dt>
      <dd>

        <xsl:if test="*/gmd:codeSpace">
          <xsl:apply-templates mode="render-value"
                               select="*/gmd:codeSpace"/>
          /
        </xsl:if>
        <xsl:apply-templates mode="render-value"
                             select="*/gmd:code"/>
        <xsl:if test="*/gmd:version">
          /
          <xsl:apply-templates mode="render-value"
                               select="*/gmd:version"/>
        </xsl:if>
        <p>
          <xsl:apply-templates mode="render-field"
                               select="*/gmd:authority"/>
        </p>
      </dd>
    </dl>
  </xsl:template>

  <xsl:template mode="render-field"
                match="srv:operatesOn"
                priority="50">
    <xsl:param name="fieldName" select="''" as="xs:string"/>

    <dl>
      <dt>
        <xsl:value-of select="if ($fieldName)
                                then $fieldName
                                else tr:node-label(tr:create($schema), name(), null)"/>
      </dt>
      <dd>
        <a target="_blank" href="{@xlink:href}"><xsl:value-of select="@xlink:href"/></a>
      </dd>
    </dl>
  </xsl:template>

  <!-- Display thesaurus name and the list of keywords -->
  <xsl:template mode="render-field"
                match="gmd:descriptiveKeywords[*/gmd:thesaurusName/gmd:CI_Citation/gmd:title]"
                priority="100">
    <dl class="gn-keyword">
      <dt>
        <xsl:apply-templates mode="render-value"
                             select="*/gmd:thesaurusName/gmd:CI_Citation/gmd:title/*"/>

        <xsl:if test="*/gmd:type/*[@codeListValue != '']">
          (<xsl:apply-templates mode="render-value"
                                select="*/gmd:type/*/@codeListValue"/>)
        </xsl:if>
      </dt>
      <dd>
        <div>
          <ul>
            <li>
              <xsl:for-each select="*/gmd:keyword">
                <xsl:apply-templates mode="render-value"
                                     select="."/><xsl:if test="position() != last()">, </xsl:if>
              </xsl:for-each>
            </li>
          </ul>
        </div>
      </dd>
    </dl>
  </xsl:template>


  <xsl:template mode="render-field"
                match="gmd:descriptiveKeywords[not(*/gmd:thesaurusName/gmd:CI_Citation/gmd:title)]"
                priority="100">
    <dl class="gn-keyword">
      <dt>
        <xsl:value-of select="$schemaStrings/noThesaurusName"/>
        <xsl:if test="*/gmd:type/*[@codeListValue != '']">
          (<xsl:apply-templates mode="render-value"
                                select="*/gmd:type/*/@codeListValue"/>)
        </xsl:if>
      </dt>
      <dd>
        <div>
          <ul>
            <li>
              <xsl:for-each select="*/gmd:keyword">
                <xsl:apply-templates mode="render-value"
                                     select="."/><xsl:if test="position() != last()">, </xsl:if>
              </xsl:for-each>
            </li>
          </ul>
        </div>
      </dd>
    </dl>
  </xsl:template>

  <!-- Display all graphic overviews in one block -->
  <xsl:template mode="render-field"
                match="gmd:graphicOverview[1]"
                priority="100">
    <dl>
      <dt>
        <xsl:value-of select="tr:node-label(tr:create($schema), name(), null)"/>
      </dt>
      <dd>
        <ul>
          <xsl:for-each select="parent::node()/gmd:graphicOverview">
            <xsl:variable name="label">
              <xsl:apply-templates mode="localised"
                                   select="gmd:MD_BrowseGraphic/gmd:fileDescription"/>
            </xsl:variable>
            <li>
              <img src="{gmd:MD_BrowseGraphic/gmd:fileName/*}"
                   alt="{$label}"
                   class="img-thumbnail"/>
            </li>
            <li><xsl:value-of select="$label" /></li>
          </xsl:for-each>
        </ul>
      </dd>
    </dl>
  </xsl:template>
  <xsl:template mode="render-field"
                match="gmd:graphicOverview[position() > 1]"
                priority="100"/>


  <xsl:template mode="render-field"
                match="gmd:distributionFormat[1]"
                priority="100">
    <dl class="gn-format">
      <dt>
        <xsl:value-of select="tr:node-label(tr:create($schema), name(), null)"/>
      </dt>
      <dd>
        <ul>
          <xsl:for-each select="parent::node()/gmd:distributionFormat">
            <li>
              <xsl:apply-templates mode="render-value"
                                   select="*/gmd:name"/>
              (<xsl:apply-templates mode="render-value"
                                    select="*/gmd:version"/>)
              <p>
                <xsl:apply-templates mode="render-field"
                                     select="*/(gmd:amendmentNumber|gmd:specification|
                              gmd:fileDecompressionTechnique|gmd:formatDistributor)"/>
              </p>
            </li>
          </xsl:for-each>
        </ul>
      </dd>
    </dl>
  </xsl:template>


  <xsl:template mode="render-field"
                match="gmd:distributionFormat[position() > 1]"
                priority="100"/>

  <!-- Date -->
  <xsl:template mode="render-field"
                match="gmd:date"
                priority="100">
    <dl class="gn-date">
      <dt>
        <xsl:value-of select="tr:node-label(tr:create($schema), name(), null)"/>
        <xsl:if test="*/gmd:dateType/*[@codeListValue != '']">
          (<xsl:apply-templates mode="render-value"
                                select="*/gmd:dateType/*/@codeListValue"/>)
        </xsl:if>
      </dt>
      <dd>
        <xsl:apply-templates mode="render-value"
                             select="*/gmd:date/*"/>
      </dd>
    </dl>
  </xsl:template>


  <!-- Enumeration -->
  <xsl:template mode="render-field"
                match="gmd:topicCategory[1]|gmd:obligation[1]|gmd:pointInPixel[1]"
                priority="100">
    <dl class="gn-date">
      <dt>
        <xsl:value-of select="tr:node-label(tr:create($schema), name(), null)"/>
      </dt>
      <dd>
        <ul>
          <xsl:for-each select="parent::node()/(gmd:topicCategory|gmd:obligation|gmd:pointInPixel)">
            <xsl:apply-templates mode="render-value" select="*"/>
			<xsl:if test="position()!=last()">,</xsl:if>
          </xsl:for-each>
        </ul>
      </dd>
    </dl>
  </xsl:template>
  <xsl:template mode="render-field"
                match="gmd:topicCategory[position() > 1]|
                        gmd:obligation[position() > 1]|
                        gmd:pointInPixel[position() > 1]"
                priority="100"/>

  <!-- A Resurskontakt is displayed with its role=owner -->
  <xsl:template mode="render-field"
                match="gmd:pointOfContact"
                priority="100">
	<xsl:param name="tabName" select="''" as="xs:string"/>
	<xsl:variable name="role" select="gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue"/>
  <xsl:if test="($role='owner' and $tabName='introduction') or ($tabName != 'introduction')">
    <dl class="gn-contact">
      <dt>
        <xsl:value-of select="gn-fn-render:get-schema-strings($schemaStrings, 'pointOfContact')"/> (<xsl:apply-templates mode="render-value" select="gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue"/>)
      </dt>
      <dd>
        <dl class="gn-contact">
          <xsl:variable name="orgName">
            <xsl:value-of select="gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString"/>
          </xsl:variable>
          <xsl:variable name="email">
            <xsl:value-of select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>
          </xsl:variable>
          <address>
            <strong>
              <xsl:value-of select="$orgName"/>,
              <xsl:if test="string(gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:voice/gco:CharacterString)">
                <i class="fa fa-phone"></i> <xsl:value-of select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:voice/gco:CharacterString"/>,
              </xsl:if>
              <i class="fa fa-envelope"></i>
              <a href="mailto:{normalize-space($email)}">
                <xsl:value-of select="$email"/>
              </a>
            </strong>
          </address>

				<!-- <table border="1" style="width:100%" bordercolor="#D3D3D3">
					<tr>
						<th style="padding-left:15px">
							<xsl:value-of select="gn-fn-render:get-schema-strings($schemaStrings, 'organisationName')"/>
						</th>
						<td style="padding-left:15px">
							<xsl:value-of select="gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString"/>
						</td>
					</tr>
					<tr>
						<th style="padding-left:15px">
							<xsl:value-of select="gn-fn-render:get-schema-strings($schemaStrings, 'roleLabel')"/>
						</th>
						<td style="padding-left:15px">
							<xsl:apply-templates mode="render-value"
								 select="gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue"/>
						</td>
					</tr>
					<tr>
						<th style="padding-left:15px">
							<xsl:value-of select="gn-fn-render:get-schema-strings($schemaStrings, 'electronicMailAddress')"/>
						</th>
						<td style="padding-left:15px">
							<xsl:value-of select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>
						</td>
					</tr>
				</table> -->
			</dl>
		  </dd>
		</dl>

	</xsl:if>
  </xsl:template>

  <!-- Link to other metadata records -->
  <xsl:template mode="render-field"
                match="*[@uuidref]"
                priority="100">
    <xsl:variable name="nodeName" select="name()"/>

    <!-- Only render the first element of this kind and render a list of
    following siblings. -->
    <xsl:variable name="isFirstOfItsKind"
                  select="count(preceding-sibling::node()[name() = $nodeName]) = 0"/>
    <xsl:if test="$isFirstOfItsKind">
      <dl class="gn-md-associated-resources">
        <dt>
          <xsl:value-of select="tr:node-label(tr:create($schema), name(), null)"/>
        </dt>
        <dd>
          <ul>
            <xsl:for-each select="parent::node()/*[name() = $nodeName]">
              <li>
                <a href="#/metadata/{@uuidref}" target="_blank">
                  <i class="fa fa-link"></i>
                  <xsl:value-of select="gn-fn-render:getMetadataTitle(@uuidref, $language)"/>
                </a>
              </li>
            </xsl:for-each>
          </ul>
        </dd>
      </dl>
    </xsl:if>
  </xsl:template>

  <xsl:template mode="render-field" match="gmd:LanguageCode">
    <dl>
      <dt>
        <xsl:value-of select="tr:node-label(tr:create($schema), name(..), null)"/>
      </dt>
      <dd>
        <xsl:apply-templates mode="render-value" select="."/>
      </dd>
    </dl>
  </xsl:template>

 <!-- Elements to avoid render -->
  <xsl:template mode="render-field" match="gmd:PT_Locale" priority="100"/>

  <!-- Traverse the tree -->
  <xsl:template mode="render-field"
                match="*">
    <xsl:apply-templates mode="render-field"/>
  </xsl:template>


  <!-- ########################## -->
  <!-- Render values for text ... -->
   <xsl:template mode="render-value"
                match="*[gco:CharacterString]">

     <xsl:variable name="txt">
       <xsl:apply-templates mode="localised" select=".">
         <xsl:with-param name="langId" select="$langId"/>
       </xsl:apply-templates>
     </xsl:variable>

     <span>
       <xsl:call-template name="addLineBreaksAndHyperlinks">
         <xsl:with-param name="txt" select="$txt"/>
       </xsl:call-template>
     </span>
  </xsl:template>

  <xsl:template mode="render-value-no-breaklines"
                match="*[gco:CharacterString]">

    <xsl:variable name="txtNonNormalized">
      <xsl:apply-templates mode="localised" select=".">
        <xsl:with-param name="langId" select="$langId"/>
      </xsl:apply-templates>
    </xsl:variable>

    <xsl:variable name="txt" select="normalize-space($txtNonNormalized)" />
    <span>
      <xsl:value-of select="$txt" />
    </span>
  </xsl:template>


  <xsl:template mode="render-value"
                match="gco:Integer|gco:Decimal|
       gco:Boolean|gco:Real|gco:Measure|gco:Length|gco:Distance|gco:Angle|gmx:FileName|
       gco:Scale|gco:Record|gco:RecordType|gmx:MimeFileType|gmd:URL|
       gco:LocalName|gml:beginPosition|gml:endPosition">

    <xsl:choose>
      <xsl:when test="contains(., 'http')">
        <!-- Replace hyperlink in text by an hyperlink -->
        <xsl:variable name="textWithLinks"
                      select="replace(., '([a-z][\w-]+:/{1,3}[^\s()&gt;&lt;]+[^\s`!()\[\]{};:'&apos;&quot;.,&gt;&lt;?«»“”‘’])',
                                    '&lt;a href=''$1''&gt;$1&lt;/a&gt;')"/>

        <xsl:if test="$textWithLinks != ''">
          <xsl:copy-of select="saxon:parse(
                          concat('&lt;p&gt;',
                          replace($textWithLinks, '&amp;', '&amp;amp;'),
                          '&lt;/p&gt;'))"/>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="normalize-space(.)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ... URL -->
  <xsl:template mode="render-value"
                match="gmd:URL">
    <a href="{.}">
      <xsl:value-of select="."/>
    </a>
  </xsl:template>

  <!-- ... Dates - formatting is made on the client side by the directive  -->
  <xsl:template mode="render-value"
                match="gco:Date[matches(., '[0-9]{4}')]">
    <span data-gn-humanize-time="{.}" data-format="YYYY"></span>
  </xsl:template>

  <xsl:template mode="render-value"
                match="gco:Date[matches(., '[0-9]{4}-[0-9]{2}')]">
    <span data-gn-humanize-time="{.}" data-format="MMM YYYY"></span>
  </xsl:template>

  <xsl:template mode="render-value"
                match="gco:Date[matches(., '[0-9]{4}-[0-9]{2}-[0-9]{2}')]">
    <span data-gn-humanize-time="{.}" data-format="YYYY-MM-DD"></span>
  </xsl:template>

  <xsl:template mode="render-value"
                match="gco:DateTime[matches(., '[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}')]">
    <span data-gn-humanize-time="{.}" data-format="YYYY-MM-DD hh:mm"></span>
  </xsl:template>

  <xsl:template mode="render-value"
                match="gco:Date|gco:DateTime">
    <span data-gn-humanize-time="{.}" data-format="YYYY-MM-DD"></span>
  </xsl:template>

  <xsl:template mode="render-value"
                match="gmd:language/gco:CharacterString">
    <span data-translate="">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>

  <!-- ... Codelists -->
  <xsl:template mode="render-value"
                match="@codeListValue">
    <xsl:variable name="id" select="."/>
    <xsl:variable name="codelistTranslation"
                  select="tr:codelist-value-label(
                            tr:create($schema),
                            parent::node()/local-name(), $id)"/>
    <xsl:choose>
      <xsl:when test="$codelistTranslation != ''">

        <xsl:variable name="codelistDesc"
                      select="tr:codelist-value-desc(
                            tr:create($schema),
                            parent::node()/local-name(), $id)"/>
        <span title="{$codelistDesc}">
          <xsl:value-of select="$codelistTranslation"/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$id"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Enumeration -->
  <xsl:template mode="render-value"
                match="gmd:MD_TopicCategoryCode|
                        gmd:MD_ObligationCode|
                        gmd:MD_PixelOrientationCode">
    <xsl:variable name="id" select="."/>
    <xsl:variable name="codelistTranslation"
                  select="tr:codelist-value-label(
                            tr:create($schema),
                            local-name(), $id)"/>
    <xsl:choose>
      <xsl:when test="$codelistTranslation != ''">

        <xsl:variable name="codelistDesc"
                      select="tr:codelist-value-desc(
                            tr:create($schema),
                            local-name(), $id)"/>
        <span title="{$codelistDesc}">
          <xsl:value-of select="$codelistTranslation"/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$id"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template mode="render-value"
                match="@gco:nilReason[. = 'withheld']"
                priority="100">
    <i class="fa fa-lock text-warning" title="{{{{'withheld' | translate}}}}"></i>
  </xsl:template>
  <xsl:template mode="render-value"
                match="@*"/>

  <xsl:template mode="render-value" match="gmd:LanguageCode">
		<xsl:choose>
			<xsl:when test="@codeListValue = 'aar'">Afar</xsl:when>
			<xsl:when test="@codeListValue = 'abk'">Abchazien</xsl:when>
			<xsl:when test="@codeListValue = 'afr'">Afrikaans</xsl:when>
			<xsl:when test="@codeListValue = 'amh'">Amhariska</xsl:when>
			<xsl:when test="@codeListValue = 'aao'">Arabiska</xsl:when>
			<xsl:when test="@codeListValue = 'asm'">Assamesiska</xsl:when>
			<xsl:when test="@codeListValue = 'ayc'">Aymara</xsl:when>
			<xsl:when test="@codeListValue = 'azb'">Azerbajdzjanska</xsl:when>
			<xsl:when test="@codeListValue = 'bak'">Basjkiriska</xsl:when>
			<xsl:when test="@codeListValue = 'bel'">Vitryska</xsl:when>
			<xsl:when test="@codeListValue = 'bqn'">Bulgariska</xsl:when>
			<xsl:when test="@codeListValue = 'bh'">Bihari</xsl:when>
			<xsl:when test="@codeListValue = 'bis'">Bislama</xsl:when>
			<xsl:when test="@codeListValue = 'ben'">Bengali, Bangla</xsl:when>
			<xsl:when test="@codeListValue = 'adx'">Tibetanska</xsl:when>
			<xsl:when test="@codeListValue = 'bre'">Breton</xsl:when>
			<xsl:when test="@codeListValue = 'cat'">Katalanska</xsl:when>
			<xsl:when test="@codeListValue = 'cos'">Korsikanska</xsl:when>
			<xsl:when test="@codeListValue = 'ces'">Tjeckien</xsl:when>
			<xsl:when test="@codeListValue = 'cym'">Walesiska</xsl:when>
			<xsl:when test="@codeListValue = 'dan'">Danska</xsl:when>
			<xsl:when test="@codeListValue = 'deu'">Tyska</xsl:when>
			<xsl:when test="@codeListValue = 'dz'">Bhutanesiska</xsl:when>
			<xsl:when test="@codeListValue = 'cpg'">Grekiska</xsl:when>
			<xsl:when test="@codeListValue = 'en'">Engelska</xsl:when>
			<xsl:when test="@codeListValue = 'eng'">Engelska</xsl:when>
			<xsl:when test="@codeListValue = 'epo'">Esperanto</xsl:when>
			<xsl:when test="@codeListValue = 'spa'">Spanska</xsl:when>
			<xsl:when test="@codeListValue = 'ekk'">Estniska</xsl:when>
			<xsl:when test="@codeListValue = 'eus'">Baskiska</xsl:when>
			<xsl:when test="@codeListValue = 'psc'">Persiska</xsl:when>
			<xsl:when test="@codeListValue = 'fin'">Finska</xsl:when>
			<xsl:when test="@codeListValue = 'fij'">Fiji</xsl:when>
			<xsl:when test="@codeListValue = 'fao'">Färöiska</xsl:when>
			<xsl:when test="@codeListValue = 'acf'">Franska</xsl:when>
			<xsl:when test="@codeListValue = 'frr'">Frisiska</xsl:when>
			<xsl:when test="@codeListValue = 'gle'">Irländska</xsl:when>
			<xsl:when test="@codeListValue = 'gla'">Skotsk gaeliska</xsl:when>
			<xsl:when test="@codeListValue = 'glg'">Galiciska</xsl:when>
			<xsl:when test="@codeListValue = 'gug'">Guarani</xsl:when>
			<xsl:when test="@codeListValue = 'guj'">Gujarati</xsl:when>
			<xsl:when test="@codeListValue = 'hau'">Hausa</xsl:when>
			<xsl:when test="@codeListValue = 'hca'">Hindi</xsl:when>
			<xsl:when test="@codeListValue = 'hrv'">Kroatiska</xsl:when>
			<xsl:when test="@codeListValue = 'hsh'">Ungerska</xsl:when>
			<xsl:when test="@codeListValue = 'aen'">Armeniska</xsl:when>
			<xsl:when test="@codeListValue = 'ia'">Interlingua</xsl:when>
			<xsl:when test="@codeListValue = 'ie'">Interlingua</xsl:when>
			<xsl:when test="@codeListValue = 'esi'">Inupiak</xsl:when>
			<xsl:when test="@codeListValue = 'bdl'">Indonesiska</xsl:when>
			<xsl:when test="@codeListValue = 'icl'">Isländska</xsl:when>
			<xsl:when test="@codeListValue = 'ise'">Italienska</xsl:when>
			<xsl:when test="@codeListValue = 'hbo'">Hebreiska</xsl:when>
			<xsl:when test="@codeListValue = 'jpn'">Japanska</xsl:when>
			<xsl:when test="@codeListValue = 'ydd'">Jiddisch</xsl:when>
			<xsl:when test="@codeListValue = 'jas'">Javanesiska</xsl:when>
			<xsl:when test="@codeListValue = 'jge'">Georgiska</xsl:when>
			<xsl:when test="@codeListValue = 'kaz'">Kazakiska</xsl:when>
			<xsl:when test="@codeListValue = 'kal'">Grönländska</xsl:when>
			<xsl:when test="@codeListValue = 'khm'">Kambodjanska</xsl:when>
			<xsl:when test="@codeListValue = 'kan'">Kannada</xsl:when>
			<xsl:when test="@codeListValue = 'kor'">Koreanska</xsl:when>
			<xsl:when test="@codeListValue = 'kas'">Kashmir</xsl:when>
			<xsl:when test="@codeListValue = 'ckb'">Kurdiska</xsl:when>
			<xsl:when test="@codeListValue = 'kir'">Kirgisiska</xsl:when>
			<xsl:when test="@codeListValue = 'lat'">Latin</xsl:when>
			<xsl:when test="@codeListValue = 'lin'">Lingala</xsl:when>
			<xsl:when test="@codeListValue = 'lo'">Laotiska</xsl:when>
			<xsl:when test="@codeListValue = 'lit'">Litauiska</xsl:when>
			<xsl:when test="@codeListValue = 'lav'">Lettiska, Lettiska</xsl:when>
			<xsl:when test="@codeListValue = 'bhr'">Madagaskars</xsl:when>
			<xsl:when test="@codeListValue = 'mri'">Maori</xsl:when>
			<xsl:when test="@codeListValue = 'mkd'">Makedonska</xsl:when>
			<xsl:when test="@codeListValue = 'mal'">Malayalam</xsl:when>
			<xsl:when test="@codeListValue = 'khk'">Mongoliska</xsl:when>
			<xsl:when test="@codeListValue = 'ron'">Moldaviska</xsl:when>
			<xsl:when test="@codeListValue = 'mar'">Marathi</xsl:when>
			<xsl:when test="@codeListValue = 'abs'">Malay</xsl:when>
			<xsl:when test="@codeListValue = 'mdl'">Maltesiska</xsl:when>
			<xsl:when test="@codeListValue = 'mya'">Burmesiska</xsl:when>
			<xsl:when test="@codeListValue = 'nau'">Nauru</xsl:when>
			<xsl:when test="@codeListValue = 'kxl'">Nepalesiska</xsl:when>
			<xsl:when test="@codeListValue = 'brc'">Nederländska</xsl:when>
			<xsl:when test="@codeListValue = 'nor'">Norska</xsl:when>
			<xsl:when test="@codeListValue = 'oci'">Occitanska</xsl:when>
			<xsl:when test="@codeListValue = 'gaz'">(Afan) Oromo</xsl:when>
			<xsl:when test="@codeListValue = 'ori'">Oriya</xsl:when>
			<xsl:when test="@codeListValue = 'pnb'">Punjabi</xsl:when>
			<xsl:when test="@codeListValue = 'pol'">Polska</xsl:when>
			<xsl:when test="@codeListValue = 'pbt'">Pashto, Pushto</xsl:when>
			<xsl:when test="@codeListValue = 'por'">Portugisiska</xsl:when>
			<xsl:when test="@codeListValue = 'cqu'">Quechua</xsl:when>
			<xsl:when test="@codeListValue = 'lld'">Rhaeto-Romance</xsl:when>
			<xsl:when test="@codeListValue = 'run'">Kirundi</xsl:when>
			<xsl:when test="@codeListValue = 'rms'">Rumänska</xsl:when>
			<xsl:when test="@codeListValue = 'prg'">Ryska</xsl:when>
			<xsl:when test="@codeListValue = 'kin'">Kinyarwanda</xsl:when>
			<xsl:when test="@codeListValue = 'san'">Sanskrit</xsl:when>
			<xsl:when test="@codeListValue = 'sbn'">Sindhi</xsl:when>
			<xsl:when test="@codeListValue = 'sag'">Sangho</xsl:when>
			<xsl:when test="@codeListValue = 'hbs'">Serbokroatiska</xsl:when>
			<xsl:when test="@codeListValue = 'sin'">Singalesiska</xsl:when>
			<xsl:when test="@codeListValue = 'slk'">Slovakiska</xsl:when>
			<xsl:when test="@codeListValue = 'slv'">Slovenska</xsl:when>
			<xsl:when test="@codeListValue = 'smo'">Samoanska</xsl:when>
			<xsl:when test="@codeListValue = 'sna'">Shona</xsl:when>
			<xsl:when test="@codeListValue = 'som'">Somali</xsl:when>
			<xsl:when test="@codeListValue = 'aae'">Albanska</xsl:when>
			<xsl:when test="@codeListValue = 'rsb'">Serbiska</xsl:when>
			<xsl:when test="@codeListValue = 'ssw'">Siswati</xsl:when>
			<xsl:when test="@codeListValue = 'sot'">Sesotho</xsl:when>
			<xsl:when test="@codeListValue = 'sun'">Sundanesiska</xsl:when>
			<xsl:when test="@codeListValue = 'swe'">Svenska</xsl:when>
			<xsl:when test="@codeListValue = 'ccl'">Swahili</xsl:when>
			<xsl:when test="@codeListValue = 'tam'">Tamil</xsl:when>
			<xsl:when test="@codeListValue = 'tel'">Telugu</xsl:when>
			<xsl:when test="@codeListValue = 'abh'">Tadzjikiska</xsl:when>
			<xsl:when test="@codeListValue = 'nod'">Thai</xsl:when>
			<xsl:when test="@codeListValue = 'ti'">Tigrinja</xsl:when>
			<xsl:when test="@codeListValue = 'tuk'">Turkmeniska</xsl:when>
			<xsl:when test="@codeListValue = 'tgl'">Tagalog</xsl:when>
			<xsl:when test="@codeListValue = 'tn'">Setswana</xsl:when>
			<xsl:when test="@codeListValue = 'rar'">Tonga</xsl:when>
			<xsl:when test="@codeListValue = 'bgx'">Turkiska</xsl:when>
			<xsl:when test="@codeListValue = 'tso'">Tsonga</xsl:when>
			<xsl:when test="@codeListValue = 'crh'">Tatariska</xsl:when>
			<xsl:when test="@codeListValue = 'tw'">TWI</xsl:when>
			<xsl:when test="@codeListValue = 'ukl'">Ukrainska</xsl:when>
			<xsl:when test="@codeListValue = 'bxn'">Urdu</xsl:when>
			<xsl:when test="@codeListValue = 'auz'">Uzbekiska</xsl:when>
			<xsl:when test="@codeListValue = 'vie'">Vietnamesiska</xsl:when>
			<xsl:when test="@codeListValue = 'vol'">Volapuk</xsl:when>
			<xsl:when test="@codeListValue = 'wof'">Wolof</xsl:when>
			<xsl:when test="@codeListValue = 'xho'">Xhosa</xsl:when>
			<xsl:when test="@codeListValue = 'yor'">Yoruba</xsl:when>
			<xsl:when test="@codeListValue = 'cdo'">Kinesiska</xsl:when>
			<xsl:when test="@codeListValue = 'zul'">Zulu</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@codeListValue"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
