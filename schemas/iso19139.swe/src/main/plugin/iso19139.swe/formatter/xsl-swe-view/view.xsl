<?xml version="1.0"?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:gml="http://www.opengis.net/gml" 
	xmlns:gco="http://www.isotc211.org/2005/gco" 
	xmlns:gmx="http://www.isotc211.org/2005/gmx"
	xmlns:gmd="http://www.isotc211.org/2005/gmd" 
	xmlns:gts="http://www.isotc211.org/2005/gts" 
	xmlns:GSE="http://www.geodata.se/gse" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:saxon="http://saxon.sf.net/"
    extension-element-prefixes="saxon"
	xmlns:gn-fn-render="http://geonetwork-opensource.org/xsl/functions/render"
	xmlns:srv="http://www.isotc211.org/2005/srv" 
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns="http://www.w3.org/1999/xhtml">
	
	<xsl:import href="render-functions.xsl"/>
	<xsl:output omit-xml-declaration="yes" method="html" indent="yes" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
	<xsl:param name="language" select="'Swedish'"/>
	<xsl:variable name="resourceUrl" select="/root/resourceUrl" />
	<xsl:template match="/">
		<html prefix="dct: http://purl.org/dc/terms/
			rdf: http://www.w3.org/1999/02/22-rdf-syntax-ns#
			dcat: http://www.w3.org/ns/dcat#
			foaf: http://xmlns.com/foaf/0.1/">
			<head>
				<meta http-equiv="X-UA-Compatible" content="IE=edge" />
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<link id="link1" rel="stylesheet" type="text/css" href="{$resourceUrl}metadataResponse/Style2/styles.css"/>
				<link id="link2" rel="stylesheet" type="text/css" href="{$resourceUrl}metadataResponse/Style2/TreeFromXMLUsingXSLT.css"/>
				<link id="link3" rel="stylesheet" type="text/css" href="{$resourceUrl}metadataResponse/Style2/font-awesome/css/custom-font-awesome.css"/>
				<style id="custom-font-awesome-id">
					@font-face {
					  font-family: 'FontAwesome';
					  src: url(<xsl:value-of select="concat('&quot;', $resourceUrl, 'metadataResponse/Style2/font-awesome/fonts/fontawesome-webfont.eot', '&quot;')" disable-output-escaping="yes" />);
					  src: url(<xsl:value-of select="concat('&quot;', $resourceUrl, 'metadataResponse/Style2/font-awesome/fonts/fontawesome-webfont.eot', '&quot;')" disable-output-escaping="yes" />) format('embedded-opentype'),
						   url(<xsl:value-of select="concat('&quot;', $resourceUrl, 'metadataResponse/Style2/font-awesome/fonts/fontawesome-webfont.woff2', '&quot;')" disable-output-escaping="yes" />) format('woff2'), 
						   url(<xsl:value-of select="concat('&quot;', $resourceUrl, 'metadataResponse/Style2/font-awesome/fonts/fontawesome-webfont.woff', '&quot;')" disable-output-escaping="yes" />) format('woff'), 
						   url(<xsl:value-of select="concat('&quot;', $resourceUrl, 'metadataResponse/Style2/font-awesome/fonts/fontawesome-webfont.ttf', '&quot;')" disable-output-escaping="yes" />) format('truetype'), 
						   url(<xsl:value-of select="concat('&quot;', $resourceUrl, 'metadataResponse/Style2/font-awesome/fonts/fontawesome-webfont.svg', '&quot;')" disable-output-escaping="yes" />) format('svg');
					  font-weight: normal;
					  font-style: normal;
					}
				</style>
				<script type="text/javascript" src="{$resourceUrl}metadataResponse/Style2/tabs.js"><![CDATA[.]]></script>
				<script type="text/javascript" src="{$resourceUrl}metadataResponse/Style2/metagis.js"><![CDATA[.]]></script>
				<script type="text/javascript" src="{$resourceUrl}metadataResponse/Style2/AnchorPosition.js"><![CDATA[.]]></script>
				<script type="text/javascript" src="{$resourceUrl}metadataResponse/Style2/PopupWindow.js"><![CDATA[.]]></script>
				<script type="text/javascript" src="{$resourceUrl}metadataResponse/Style2/TreeJS.js"><![CDATA[.]]></script>
				<script type="text/javascript">
					var fromInBuiltStyleSheet=false;
					if(fromInBuiltStyleSheet!==false) {
						window.onload = printBtnClickEventFromInBuiltStyleSheet;
					}
				</script>
				<title>
					<xsl:value-of select="//gmd:MD_Metadata/gmd:identificationInfo//gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString[text()]"/>
				</title>
			</head>
			<body oncontextmenu="return true" vocab="http://schema.org/" typeof="WebPage">
				<span itemscope="itemScope" itemtype="http://schema.org/WebPage" typeof="dcat:Dataset">
				<!-- <button type="button" onclick="printBtnClickEvent()" style="float: right;">Skriv ut</button> -->
				<a style="float:right;cursor:pointer;text-decoration:underline;" onClick="printBtnClickEvent()">
					<img src="{$resourceUrl}metadataResponse/Style2/images/print.jpg" alt="Skriv ut"/>
				</a>				
					<span class="title" itemprop="name" property="dct:title">					
					<xsl:value-of select="//gmd:MD_Metadata/gmd:identificationInfo//gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString[text()]"/>
				</span>
				<br/>
					<div id="metadataTabberDiv" class="tabber" style="width:99%;">
					<div class="tabbertab">
						<h2>Översikt</h2>
						<xsl:apply-templates select="//gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString[text()] | //gmd:MD_Metadata/gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString[text()]"/>
					</div>					
					<div class="tabbertab">
						<h2>Information om metadata</h2>
						<xsl:apply-templates select="//gmd:MD_Metadata"/>
					</div>
					<div class="tabbertab">
						<h2>Information om data</h2>
						<xsl:apply-templates select="//gmd:MD_Metadata/gmd:identificationInfo"/>
						<xsl:apply-templates select="//gmd:MD_Metadata/gmd:referenceSystemInfo" />
						<!--change by Ashlesh [/metadata/dataIdInfo] -->
					</div>									
					<div class="tabbertab">
						<h2>Distribution</h2>
						<xsl:apply-templates select="//gmd:MD_Metadata/gmd:distributionInfo"/>
						<!--change by Ashlesh [/metadata/distInfo] -->
					</div>
					<div class="tabbertab">
						<h2>Kvalitet</h2>
						<xsl:apply-templates select="//gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality"/>
						<!--change by Ashlesh -->
					</div>
					<div class="tabbertab">
						<h2>Restriktioner</h2>
						<xsl:apply-templates select="//gmd:MD_Metadata/gmd:identificationInfo" mode="Restriktioner"/>
					</div>					
					<div id="allMetadataTab" class="tabbertab">
						<h2>Alla metadata</h2>						
						<br/>
						<xsl:apply-templates select="//gmd:MD_Metadata/gmd:identificationInfo">
							<xsl:with-param name="showHeader" select="'true'"/>
						</xsl:apply-templates>
						<xsl:apply-templates select="//gmd:MD_Metadata/gmd:referenceSystemInfo"/> <!-- No header for referense system info. It is a part of identificationinfo -->
						<br/>
						<xsl:apply-templates select="//gmd:MD_Metadata/gmd:distributionInfo">
							<xsl:with-param name="showHeader" select="'true'"/>
						</xsl:apply-templates>
						<br/>
						<xsl:apply-templates select="//gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality">
							<xsl:with-param name="showHeader" select="'true'"/>
						</xsl:apply-templates>
						<br/>
						<xsl:apply-templates select="//gmd:MD_Metadata/gmd:identificationInfo" mode="Restriktioner">
							<xsl:with-param name="showHeader" select="'true'"/>
						</xsl:apply-templates>
						<br/>
						<xsl:apply-templates select="//gmd:MD_Metadata">
							<xsl:with-param name="showHeader" select="'true'"/>
						</xsl:apply-templates>
					</div>
				</div>
				</span>
			</body>
		</html>
	</xsl:template>
	<!--Template för Översiktssida-->
	<xsl:template match="gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString[text()] | gmd:MD_Metadata/gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString[text()]">
		<a name="Metadata_summary"><![CDATA[ ]]></a>
		<!--STH  -->
		<div>
			<a style="cursor:pointer;text-decoration:underline;" onClick="mdContactFormTitleClick()">
				<img src="{$resourceUrl}metadataResponse/Style2/images/tycktill.jpg" alt="Tyck till"></img>
			</a>
			<br/>
			<span id="msgSuccessErrorBox"/>
		</div>
		<div id="metadataContactDiv" style="display:none; width:95%; border-top:2px solid #ABABAB">
			<form id="metadataContactForm" name="metadataContactForm" style="padding:0px 0 0 50px;" method="post" onsubmit="return mdContactFormValidation()">
				<p>Här kan du ge synpunkter på data och metadata. Fält märkta med * är obligatoriska uppgifter.</p>
				<table border="0">
					<tr>
						<td>Namn *</td>
						<td>
							<input name="name" type="text" size="35"/>
						</td>
					</tr>
					<tr>
						<td>E-post *</td>
						<td>
							<input name="email" type="text" size="35"/>
						</td>
					</tr>
					<tr>
						<td>Organisation</td>
						<td>
							<input name="org" type="text" size="35"/>
						</td>
					</tr>
					<tr>
						<td>Kommentar *</td>
						<td>
							<textarea name="comments" cols="38" rows="5">&#160;</textarea>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td>
							<input style="float:left" type="submit" name="Submit" value="Skicka"/>
							<div style="display:none; float:right" id="msgSendingTag">Message Sending
                                <img align="absmiddle" src="{$resourceUrl}metadataResponse/Style2/images/loading-balls.gif" alt="Tyck til"/>
							</div>
						</td>
					</tr>
				</table>
				<input type="hidden" name="metadataTitle">
					<xsl:attribute name="value"><xsl:value-of select="//gmd:MD_Metadata/gmd:identificationInfo//gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString[text()]"/></xsl:attribute>
				</input>
				<input type="hidden" name="metadataToAddress">
					<xsl:attribute name="value"><xsl:for-each select="//gmd:MD_Metadata/gmd:contact/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString"><xsl:value-of select="text()"/>; </xsl:for-each></xsl:attribute>
				</input>
			</form>
		</div>
		<br/>
		<table class="mytabtable" >
			<!-- <tr>
				<td colspan="3" class="sectionheader">Översiktlig sammanställning</td>
			</tr> -->
			<!-- <tr>
				<td class="Level-1-element">Titel:</td>
				<td colspan="2">
					<span itemprop="name" property="dct:title">
						<xsl:value-of select="."/>
					</span>
				</td>
			</tr>
			<tr>
				<td class="Level-1-element">Alternativ Titel:</td>
				<td colspan="2">
					<xsl:for-each select="//gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:alternateTitle">
						<xsl:value-of select="gco:CharacterString/text()"/>
						<xsl:if test="position()!=last()">,</xsl:if>
					</xsl:for-each>
				</td>
			</tr> -->
			<tr width="33%" align="left" valign="upper">
				<xsl:for-each select="//gmd:MD_Metadata/gmd:hierarchyLevel">
					<tr>
						<xsl:if test="gmd:MD_ScopeCode[@Sync = 'TRUE']">
							<span class="s"><![CDATA[ ]]></span>
						</xsl:if>
						<td class="Level-1-element">Resurstyp</td>
						<td colspan="2">
							<xsl:apply-templates select="gmd:MD_ScopeCode"/>
						</td>
					</tr>
				</xsl:for-each>
				<tr>
					<td class="Level-1-element">Datum för metadata</td>
					<td colspan="2">
						<xsl:apply-templates mode="render-value" select="//gmd:MD_Metadata/gmd:dateStamp/gco:Date"/>
						<xsl:apply-templates mode="render-value" select="//gmd:MD_Metadata/gmd:dateStamp/gco:DateTime"/>
					</td>
				</tr>
				<!-- <tr>
                    <td class="Level-1-element">Händelsedatum :</td>
                    <td colspan="2">
                        </td>
                </tr> -->
				<!--<xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:date"/>
                <xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation/gmd:date"/>-->
				<!--                <th width="33%" align="left" valign="upper"> -->
				<xsl:apply-templates select="//gmd:MD_Metadata//gmd:abstract"/>
				<!--                </th> -->
				
				<xsl:if test="//gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:topicCategory | //gmd:MD_Metadata/gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:topicCategory">
					<tr>
						<td class="Level-1-element">Ämnesområden</td>
						<td colspan="2">
							<!--                            <xsl:for-each select="/gmd:MD_Metadata[gmd:identificationInfo/gmd:MD_DataIdentification/gmd:topicCategory]"> -->
							<xsl:for-each select="//gmd:MD_Metadata/gmd:identificationInfo//gmd:topicCategory/gmd:MD_TopicCategoryCode">
								<!--                                        <xsl:value-of select="gmd:MD_TopicCategoryCode/text()"/> -->
								<xsl:choose>
									<xsl:when test="text() = 'farming'">Areela näringar</xsl:when>
									<xsl:when test="text() = 'biota'">Biologi och ekologi</xsl:when>
									<xsl:when test="text() = 'boundaries'">Administrativa gränser</xsl:when>
									<xsl:when test="text() = 'climatologyMeteorologyAtmosphere'">Atmosfär, klimatologi och meteorologi</xsl:when>
									<xsl:when test="text() = 'economy'">Ekonomi</xsl:when>
									<xsl:when test="text() = 'elevation'">Höjddata</xsl:when>
									<xsl:when test="text() = 'environment'">Miljö</xsl:when>
									<xsl:when test="text() = 'geoscientificInformation'">Geovetenskap</xsl:when>
									<xsl:when test="text() = 'health'">Hälsa</xsl:when>
									<xsl:when test="text() = 'imageryBaseMapsEarthCover'">Arealtäckande bilder ocxh baskartor</xsl:when>
									<xsl:when test="text() = 'intelligenceMilitary'">Försvar</xsl:when>
									<xsl:when test="text() = 'inlandWaters'">Insjövatten</xsl:when>
									<xsl:when test="text() = 'location'">Positionering</xsl:when>
									<xsl:when test="text() = 'oceans'">Kust och hav</xsl:when>
									<xsl:when test="text() = 'planningCadastre'">Fastigheter och fysisk planering</xsl:when>
									<xsl:when test="text() = 'society'">Samhälle och kultur</xsl:when>
									<xsl:when test="text() = 'structure'">Byggnader och konstruktioner</xsl:when>
									<xsl:when test="text() = 'transportation'">Transporter</xsl:when>
									<xsl:when test="text() = 'utilitiesCommunication'">Tekniska försörjningssystem</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="text()"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:if test="position()!=last()">,</xsl:if>
							</xsl:for-each>
							<!--                            </xsl:for-each> -->
						</td>
					</tr>
				</xsl:if>
				
				<xsl:apply-templates mode="Overview" select="//gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact | //gmd:MD_Metadata/gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:pointOfContact"/>
				<xsl:apply-templates mode="maxDate" select="//gmd:MD_Metadata/gmd:identificationInfo/*/gmd:citation/gmd:CI_Citation/gmd:date"/>
				<!-- Online Links -->
				<xsl:apply-templates mode="online" select="//gmd:MD_Metadata/gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorTransferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine">
					<xsl:with-param name="overViewTab" select="'true'"/>
				</xsl:apply-templates>
	
				<!--Not found element as name gmd:status-->
				<!--End Date : 04-11-10 -->
				<!-- Exempelbild and Bildtext -->						
				<!-- <xsl:for-each select="//gmd:MD_Metadata/gmd:identificationInfo//gmd:graphicOverview">
					<tr>
						<td class="Level-1-element">Exempelbild:</td>
						<td colspan="2">
							<img ID="thumbnail" align="absmiddle" style="border:2 outset #ffffff; position:relative">
								<xsl:attribute name="src">
									<xsl:value-of select="gmd:MD_BrowseGraphic/gmd:fileName/gco:CharacterString"/>
								</xsl:attribute>
							</img>
						</td>
					</tr>
					<tr>
						<td class="Level-1-element">Bildtext:</td>
						<td colspan="2">
							<xsl:value-of select="gmd:MD_BrowseGraphic/gmd:fileDescription/gco:CharacterString"/>
						</td>
					</tr>
				</xsl:for-each> -->
			</tr>
			<!-- <xsl:for-each select="//gmd:MD_Metadata/gmd:identificationInfo"> -->
				<!--Comment Date: 12-11-10-->
				<!--<xsl:apply-templates select = "gmd:MD_DataIdentification"/>-->
				<!-- gmd:MD_Format -->
			<!-- </xsl:for-each> -->
			<!--<xsl:for-each select="/gmd:MD_Metadata/gmd:identificationInfo//gmd:graphicOverview/gmd:MD_BrowseGraphic/gmd:fileName/gco:CharacterString[text()]">
                <tr>
                    <td colspan="3">
                        <img ID="thumbnail" align="absmiddle" style="border:2 outset #ffffff; position:relative">
                            <xsl:attribute name="src"><xsl:value-of select="."/></xsl:attribute>
                        </img>
                    </td>
                </tr>
            </xsl:for-each>-->
		</table>
		<!--STH slut -->
	</xsl:template>
	<!--comment date : 03-11-10-->
	<xsl:template match="gmd:MD_Metadata/gmd:metadataStandardName">
        
    </xsl:template>

	<xsl:template match="gmd:MD_Metadata">
		<xsl:param name="showHeader"/>
		<a name="Metadata_Information"><![CDATA[ ]]></a>
		<table class="mytabtable" >
			<tbody>
				<xsl:if test="$showHeader = 'true'">
					<tr>
						<td colspan="2" class="sectionheader">Information om metadata</td>
					</tr>
				</xsl:if>
				<xsl:for-each select="gmd:language">
					<tr>
						<td class="Level-1-element">Språk i metadata</td>
						<xsl:apply-templates select="gmd:LanguageCode"/>
					</tr>
				</xsl:for-each>
				<xsl:for-each select="gmd:characterSet">
					<tr>
						<td class="Level-1-element">Teckenuppsättning i metadata:</td>
						<td>
							<xsl:apply-templates select="gmd:MD_CharacterSetCode"/>
						</td>
					</tr>
				</xsl:for-each>
				<xsl:for-each select="gmd:dateStamp">
					<tr>
						<td class="Level-1-element">
							<xsl:if test="@Sync = 'TRUE'">
								<span class="s"><![CDATA[ ]]></span>
							</xsl:if>
                            Datum för metadata
                        </td>
						<td>
							<xsl:apply-templates mode="render-value" select="gco:Date"/>
							<xsl:apply-templates mode="render-value" select="gco:DateTime"/>
						</td>
					</tr>
				</xsl:for-each>
				<xsl:apply-templates select="gmd:metadataMaintenance/gmd:MD_MaintenanceInformation"/>
				<xsl:for-each select="mdConst">
					<tr>
						<td colspan="2" class="Level-1-header">Begränsningar för Metadata:</td>
					</tr>
					<!--<xsl:apply-templates select = "Consts"/>
                    <xsl:apply-templates select = "LegConsts"/>
                    <xsl:apply-templates select = "SecConsts"/>-->
					<xsl:apply-templates select="gmd:MD_Constraints"/>
					<xsl:apply-templates select="gmd:MD_LegalConstraints"/>
					<!--<xsl:apply-templates select = "gmd:MD_SecurityConstraints"/>-->
					<xsl:apply-templates select="gmd:MD_SecurityConstraints/gmd:classification"/>
				</xsl:for-each>
				<xsl:for-each select="//gmd:MD_Metadata/gmd:hierarchyLevel">
					<tr>
						<xsl:if test="gmd:MD_ScopeCode[@Sync = 'TRUE']">
							<span class="s"><![CDATA[ ]]></span>
						</xsl:if>
						<td class="Level-1-element">Resurstyp</td>
						<td>
							<xsl:apply-templates select="gmd:MD_ScopeCode"/>
						</td>
					</tr>
				</xsl:for-each>
				<xsl:for-each select="gmd:hierarchyLevelName">
					<tr>
						<td class="Level-1-element">
							<xsl:if test="@Sync = 'TRUE'">
								<span class="s"><![CDATA[ ]]></span>
							</xsl:if>
                            Beskrivning av omfattningen av metadata:
                        </td>
						<td>
							<xsl:value-of select="//gmd:MD_Metadata/gmd:hierarchyLevelName/gco:CharacterString/text()"/>
						</td>
					</tr>
				</xsl:for-each>
				<xsl:for-each select="gmd:metadataStandardName">
					<tr>
						<td class="Level-1-element">Metadatastandard</td>
						<td>
							<xsl:value-of select="//gmd:MD_Metadata/gmd:metadataStandardName/gco:CharacterString/text()"/>
						</td>
					</tr>
				</xsl:for-each>
				<xsl:for-each select="gmd:metadataStandardVersion">
					<tr>
						<td class="Level-1-element">Version av metadatastandard</td>
						<td>
							<xsl:value-of select="."/>
						</td>
					</tr>
				</xsl:for-each>
				<xsl:for-each select="gmd:fileIdentifier">
					<tr>
						<td class="Level-1-element">
							<xsl:if test="@Sync = 'TRUE'">
								<span class="s"><![CDATA[ ]]></span>
							</xsl:if>
                            Identifierare för metadatamängden
                        </td>
						<td>
							<xsl:value-of select="//gmd:MD_Metadata/gmd:fileIdentifier/gco:CharacterString/text()"/>
						</td>
					</tr>
				</xsl:for-each>
				<xsl:for-each select="gmd:parentIdentifier">
					<tr>
						<td class="Level-1-element">Identifierare för förälders metadatapost:</td>
						<td>
							<xsl:value-of select="//gmd:MD_Metadata/gmd:parentIdentifier/gco:CharacterString/text()"/>
						</td>
					</tr>
				</xsl:for-each>
				<xsl:apply-templates mode="contact" select="//gmd:MD_Metadata/gmd:contact"/>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template match="gmd:LanguageCode">
		<td property="dct:language" itemprop="inLanguage">
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
		</td>
	</xsl:template>
	<xsl:template match="gmd:MD_CharacterSetCode">
		<xsl:choose>
			<xsl:when test="@value = '001'">ucs2 - 16 bit Universal Character Set</xsl:when>
			<xsl:when test="@value = '002'">ucs4 - 32 bit Universal Character Set</xsl:when>
			<xsl:when test="@value = '003'">utf7 - 7 bit UCS Transfer Format</xsl:when>
			<xsl:when test="@value = '004'">utf8 - 8 bit UCS Transfer Format</xsl:when>
			<xsl:when test="@value = '005'">utf16 - 16 bit UCS Transfer Format</xsl:when>
			<xsl:when test="@value = '006'">8859part1 - Latin-1, Western European</xsl:when>
			<xsl:when test="@value = '007'">8859part2 - Latin-2, Central European</xsl:when>
			<xsl:when test="@value = '008'">8859part3 - Latin-3, South European</xsl:when>
			<xsl:when test="@value = '009'">8859part4 - Latin-4, North European</xsl:when>
			<xsl:when test="@value = '010'">8859part5 - Cyrillic</xsl:when>
			<xsl:when test="@value = '011'">8859part6 - Arabic</xsl:when>
			<xsl:when test="@value = '012'">8859part7 - Greek</xsl:when>
			<xsl:when test="@value = '013'">8859part8 - Hebrew</xsl:when>
			<xsl:when test="@value = '014'">8859part9 - Latin-5, Turkish</xsl:when>
			<xsl:when test="@value = '015'">8859part11 - Thai</xsl:when>
			<xsl:when test="@value = '016'">8859part14 - Latin-8</xsl:when>
			<xsl:when test="@value = '017'">8859part15 - Latin-9</xsl:when>
			<xsl:when test="@value = '018'">jis - Japanese for electronic transmission</xsl:when>
			<xsl:when test="@value = '019'">shiftJIS - Japanese for MS-DOS</xsl:when>
			<xsl:when test="@value = '020'">eucJP - Japanese for UNIX</xsl:when>
			<xsl:when test="@value = '021'">U.S. ASCII</xsl:when>
			<xsl:when test="@value = '022'">ebcdic - IBM mainframe</xsl:when>
			<xsl:when test="@value = '023'">eucKR - Korean</xsl:when>
			<xsl:when test="@value = '024'">big5 - Taiwanese</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@value"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="gmd:MD_ScopeCode">
		<xsl:choose>
			<xsl:when test="@codeListValue = '001'">attribut</xsl:when>
			<xsl:when test="@codeListValue = '002'">attributtyp</xsl:when>
			<xsl:when test="@codeListValue = '003'">samling hardware</xsl:when>
			<xsl:when test="@codeListValue = '004'">samling session</xsl:when>
			<xsl:when test="@codeListValue = 'dataset'">Datamängd</xsl:when>
			<xsl:when test="@codeListValue = 'series'">Serie</xsl:when>
			<xsl:when test="@codeListValue = '007'">ej geografiska data</xsl:when>
			<xsl:when test="@codeListValue = '008'">dimensions grupp</xsl:when>
			<xsl:when test="@codeListValue = '009'">objekt</xsl:when>
			<xsl:when test="@codeListValue = '010'">objekttyp</xsl:when>
			<xsl:when test="@codeListValue = '011'">property type</xsl:when>
			<xsl:when test="@codeListValue = '012'">fält session</xsl:when>
			<xsl:when test="@codeListValue = 'software'">Programvara</xsl:when>
			<xsl:when test="@codeListValue = 'service'">Tjänst</xsl:when>
			<xsl:when test="@codeListValue = '015'">modell</xsl:when>
			<xsl:when test="@codeListValue = '101'">Mxd-dokument</xsl:when>
			<xsl:when test="@codeListValue = '102'">ArcIMS-tjänst</xsl:when>
			<xsl:when test="@codeListValue = '103'">Dokument</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@codeListValue"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="*/gmd:resourceMaintenance | gmd:MD_DataIdentification/gmd:MD_MaintenanceInformation ">
		<!-- <xsl:choose>
			<xsl:when test="gmd:MD_MaintenanceInformation">
				<tr>
					<td colspan="2" class="Level-1-Header">Underhåll av resurs:</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td class="Level-1-element">Underhåll:</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose> -->
		<xsl:for-each select="dateNext">
			<tr>
				<td class="Level-1-element">Datum för nästa uppdatering:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<!--<xsl:for-each select = "maintFreq">-->
		<!-- <xsl:for-each select="gmd:MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency">
			<tr>
				<td class="Level-2-element">Underhållsfrekvens:</td>
				<td>
					<xsl:for-each select="gmd:MD_MaintenanceFrequencyCode">
						<xsl:choose>
							<xsl:when test="@codeListValue = 'continual'">kontinuerlig</xsl:when>
							<xsl:when test="@codeListValue = 'daily'">Daglig</xsl:when>
							<xsl:when test="@codeListValue = 'weekly'">veckovis</xsl:when>
							<xsl:when test="@codeListValue = 'fortnightly'">var 14:e dag</xsl:when>
							<xsl:when test="@codeListValue = 'monthly'">Månatligen</xsl:when>
							<xsl:when test="@codeListValue = 'quarterly'">kvartalsvis</xsl:when>
							<xsl:when test="@codeListValue = 'biannually'">Halvårsvis</xsl:when>
							<xsl:when test="@codeListValue = 'annually'">Årligen</xsl:when>
							<xsl:when test="@codeListValue = 'asNeeded'">vid behov</xsl:when>
							<xsl:when test="@codeListValue = 'irregular'">oregelbundet</xsl:when>
							<xsl:when test="@codeListValue = 'notPlanned'">ej planerat</xsl:when>
							<xsl:when test="@codeListValue = 'unknown'">okänt</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@codeListValue"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:for-each> -->
		<xsl:apply-templates select="usrDefFreq"/>
		<xsl:for-each select="maintScp">
			<tr>
				<td class="Level-2-element">Omfattning av underhåll:</td>
				<xsl:apply-templates select="ScopeCd"/>
			</tr>
		</xsl:for-each>
		<xsl:apply-templates select="upScpDesc"/>
		<xsl:for-each select="gmd:MD_MaintenanceInformation/gmd:maintenanceNote/gco:CharacterString[text()]">
			<tr>
				<!--<td class = "Level-1-element">Andra krav på underhåll:</td>-->
				<td class="Level-1-element">Anmärkning</td>
				<td>
					<div id="maintenanceNote">
						<xsl:variable name="preId" select="generate-id()"/>					
						<pre>
							<xsl:attribute name="id">pre<xsl:value-of select="$preId"/><xsl:value-of select="position()"/></xsl:attribute>
							<xsl:attribute name="property"><xsl:value-of select="'dct:description'"/></xsl:attribute>
							<xsl:attribute name="itemprop"><xsl:value-of select="'description'"/></xsl:attribute>
							<xsl:value-of select="." disable-output-escaping="yes"/>
						</pre>
						<script type="text/javascript">fix2('pre<xsl:value-of select="$preId"/>
							<xsl:value-of select="position()"/>');
							</script>
					</div>
					<script type="text/javascript">setLinkClickable('maintenanceNote');</script>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="usrDefFreq">
		<tr>
			<td class="Level-1-Header">Tidsperiod mellan uppdateringar:</td>
		</tr>
		<xsl:for-each select="designator">
			<tr>
				<td class="Level-1-element">Time period designator:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="years">
			<tr>
				<td class="Level-1-element">År:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="months">
			<tr>
				<td class="Level-1-element">Månader:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="dagar">
			<tr>
				<td class="Level-1-element">Days:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="timeIndicator">
			<tr>
				<td class="Level-1-element">Time indicator:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="timmar">
			<tr>
				<td class="Level-1-element">Hours:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="minuter">
			<tr>
				<td class="Level-1-element">Minutes:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="sekunder">
			<tr>
				<td class="Level-1-element">Seconds:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--Scope Description Information (B.2.5.1 MD_ScopeDescription - line149) -->
	<xsl:template match="scpLvlDesc | upScpDesc">
		<xsl:if test="text()='0'">
			<tr>
				<td class="Level-1-element">Beskrivning av omfattning:</td>
			</tr>
		</xsl:if>
		<xsl:for-each select="attribSet">
			<tr>
				<td class="Level-1-element">Attribut(typ):</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="featSet">
			<tr>
				<td class="Level-1-element">Objekt(typ):</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="featIntSet">
			<tr>
				<td class="Level-1-element">Objekt:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="attribIntSet">
			<tr>
				<td class="Level-1-element">Attributvärden:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="datasetSet">
			<tr>
				<td class="Level-1-element">Datamängd:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="other">
			<tr>
				<td class="Level-1-element">Andra:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="gmd:MD_Constraints">
		<xsl:for-each select="gmd:useLimitation">
			<tr>
				<td class="Level-1-element">Användbarhetsbegränsningar</td>
				<td>
					<xsl:value-of select="*/text()"/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--Legal Constraint Information (B.2.3 MD_LegalConstraints - line69) -->
	<!--MICO Här har jag tagit bort värdelistor och gett möjlighet till fritext-->
	<!--<xsl:template match = "LegConsts">-->
	<xsl:template match="gmd:resourceConstraints/gmd:MD_LegalConstraints">
		<xsl:variable name="preId" select="generate-id()"/>
		<xsl:for-each select="gmd:otherConstraints">
		 	<tr>
			<!--	<td class="Level-1-element">Andra restriktioner</td>
				<td>
					<div id="otherConst">
						<xsl:value-of select="gco:CharacterString"/>
					</div>
				</td> -->
				<td  class="Level-1-element">
			          <xsl:choose>
			            <xsl:when test="count(../gmd:accessConstraints) > 0 and gmx:Anchor and contains(gmx:Anchor/@xlink:href, 'LimitationsOnPublicAcces')">
			              Begränsningar i offentlig åtkomst
			            </xsl:when>
			
			            <xsl:when test="count(../gmd:accessConstraints) > 0 and gmx:Anchor and not(contains(gmx:Anchor/@xlink:href, 'LimitationsOnPublicAcces'))">
			              Åtkomstrestriktioner
			            </xsl:when>
			
			            <xsl:when test="count(../gmd:useConstraints) > 0 and gmx:Anchor">
			              Nyttjanderestriktioner
			            </xsl:when>
			
			            <xsl:otherwise>
			              Andra restriktioner
			            </xsl:otherwise>
			
			          </xsl:choose>
				</td>
                <td>
			          <xsl:value-of select="gco:CharacterString|gmx:Anchor"/>
			
			          <xsl:if test="gmx:Anchor">
			            <xsl:variable name="anchorHref" select="gmx:Anchor/@xlink:href" />
			
			            <xsl:choose>
			              <xsl:when test="count(../gmd:accessConstraints) > 0 and contains(gmx:Anchor/@xlink:href, 'LimitationsOnPublicAcces')">
 			                (<xsl:value-of select="$anchorHref" /> - <xsl:value-of select="gmx:Anchor/text()"/>)
			              </xsl:when>
			
			              <xsl:when test="count(../gmd:accessConstraints) > 0 and not(contains(gmx:Anchor/@xlink:href, 'LimitationsOnPublicAcces'))">
			                (<xsl:value-of select="$anchorHref" /> - <xsl:value-of select="gmx:Anchor/text()"/>)
			              </xsl:when>
			
			              <xsl:when test="count(../gmd:useConstraints) > 0">
			                (<xsl:value-of select="$anchorHref" /> 
						     <!-- need to figure out how to translate the gmx:Anchor attribute to Swedish -->
						    )
			              </xsl:when>
			
			              <xsl:otherwise>
			                <xsl:value-of select="$anchorHref"/>
			              </xsl:otherwise>
			
			            </xsl:choose>
			          </xsl:if>                
 
                </td>				
			</tr> 
		</xsl:for-each>
		<!-- <xsl:if test="gmd:accessConstraints">
			<tr>
				<td class="Level-1-element">Åtkomst begränsningar</td>
				<td>
					<xsl:for-each select="gmd:accessConstraints">
						<xsl:value-of select="text()"/>
						<xsl:apply-templates select="gmd:MD_RestrictionCode"/>
						<xsl:if test="position()!=last()">,</xsl:if>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:if> -->
		<!-- <xsl:if test="gmd:useConstraints">
			<tr>
				<td class="Level-1-element">Nyttjanderestriktioner:</td>
				<td>
					<xsl:for-each select="gmd:useConstraints">
						<xsl:value-of select="text()"/>
						<xsl:apply-templates select="gmd:MD_RestrictionCode"/>
						<xsl:if test="position()!=last()">,</xsl:if>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:if> -->
		<!-- <xsl:for-each select="gmd:useLimitation/gco:CharacterString">
			<tr>
				<td class="Level-1-element">Begränsningar i användning</td>
				<td>
					<div id="useLimitation">
						<xsl:value-of select="text()"/>
					</div>
					<script type="text/javascript">setLinkClickable('useLimitation');</script>
				</td>
			</tr>
		</xsl:for-each> -->
	</xsl:template>
	<!--Restrictions code list (B.5.24 MD_RestrictionCode) -->
	<!--<xsl:template match = "RestrictCd">-->
	<xsl:template match="gmd:MD_RestrictionCode">
		<!--<td>-->
		<xsl:choose>
			<xsl:when test="@codeListValue = 'copyright'">Upphovsrätt</xsl:when>
			<xsl:when test="@codeListValue = 'patent'">Patent</xsl:when>
			<xsl:when test="@codeListValue = 'patentPending'">Avvaktar patent</xsl:when>
			<xsl:when test="@codeListValue = 'trademark'">Varumärke</xsl:when>
			<xsl:when test="@codeListValue = 'license'">Licens</xsl:when>
			<xsl:when test="@codeListValue = 'intellectualPropertyRights'">Immaterialrätt</xsl:when>
			<xsl:when test="@codeListValue = 'restricted'">Begränsad</xsl:when>
			<xsl:when test="@codeListValue = 'otherRestrictions'">Andra begränsningar</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@codeListValue"/>
			</xsl:otherwise>
		</xsl:choose>
		<!--</td>-->
	</xsl:template>
	<!--Security Constraint Information (B.2.3 MD_SecurityConstraints - line73) -->
	<xsl:template match="gmd:MD_SecurityConstraints/gmd:classification">
		<tr>
			<!--<td class = "Level-1-Header">Security constraints:</td>-->
			<td colspan="2" class="Level-1-Header">Skyddsklass:</td>
		</tr>
		<tr>
			<td class="Level-2-element">Klassificering:</td>
			<td>
				<xsl:for-each select="gmd:MD_ClassificationCode">
					<xsl:choose>
						<xsl:when test="@codeListValue = 'unclassified'">ej klassificerad</xsl:when>
						<xsl:when test="@codeListValue = '002'">begränsad (endast för tjänstebruk)</xsl:when>
						<xsl:when test="@codeListValue = '003'">konfidentiell</xsl:when>
						<xsl:when test="@codeListValue = '004'">hemlig (dold)</xsl:when>
						<xsl:when test="@codeListValue = '005'">hemligstämplad</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="@codeListValue"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</td>
		</tr>
		<!--*-->
		<!--<xsl:for-each select = "class">         
    <td>
                    <xsl:for-each select = "gmd:MD_ClassificationCode">
                        <xsl:choose>
                            <xsl:when test = "@codeListValue = 'unclassified'">ej klassificerad</xsl:when>
                            <xsl:when test = "@codeListValue = '002'">begränsad (endast för tjänstebruk)</xsl:when>
                            <xsl:when test = "@codeListValue = '003'">konfidentiell</xsl:when>
                            <xsl:when test = "@codeListValue = '004'">hemlig (dold)</xsl:when>
                            <xsl:when test = "@codeListValue = '005'">hemligstämplad</xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select = "@codeListValue"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </td>
            </tr>
        </xsl:for-each>-->
		<!--*-->
		<xsl:for-each select="../gmd:classificationSystem">
			<tr>
				<td class="Level-2-element">
          Skyddsklassningssystem:
        </td>
				<td>
					<xsl:value-of select="gco:CharacterString"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="../gmd:userNote">
			<tr>
				<td class="Level-2-element">
          Kommentar:
        </td>
				<td>
					<xsl:value-of select="gco:CharacterString"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="../gmd:handlingDescription">
			<tr>
				<td class="Level-2-element">
          Kompletterande beskrivning::
        </td>
				<td>
					<xsl:value-of select="gco:CharacterString"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="classSys">
			<tr>
				<td class="Level-2-element">Klassificeringsssytem:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="userNote">
			<tr>
				<td class="Level-2-element">Rättsliga begränsningar:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="handDesc">
			<tr>
				<td class="Level-2-element">Ytterligare begränsningar:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="useLimit">
			<tr>
				<td class="Level-2-element">Begränsningar i användning:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--RESOURCE IDENTIFICATION -->
	<!--Resource Identification Information (B.2.2 MD_Identification - line23, including MD_DataIdentification - line36) -->
	<!--DTD doesn't account for data and service subclasses of MD_Identification -->
	<xsl:template match="gmd:MD_Metadata/gmd:identificationInfo">
		<xsl:param name="showHeader"/>
		<xsl:variable name="preId" select="generate-id()"/>
		<a>
			<xsl:attribute name="name"><xsl:value-of select="generate-id()"/></xsl:attribute>
		</a>
		<table id="dataInfo" class="mytabtable" >
			<tbody>
				<xsl:if test="$showHeader = 'true'">
					<tr>
						<td colspan="2" class="sectionheader">Information om data</td>
					</tr>
				</xsl:if>
				<xsl:apply-templates select="gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation | srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation"/>
				<!-- <xsl:apply-templates select="gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty | srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty"/> -->
				<!--<xsl:apply-templates select = "gmd:MD_DataIdentification/gmd:pointOfContact"/>-->
				<!-- <tr>
					<td colspan="2" class="Level-1-EmptyRow">-</td>
				</tr> -->
				<!-- <tr>
					<td colspan="2" class="Level-0-Header">Beskrivning av resurs:</td>
				</tr> -->
				<xsl:apply-templates select="gmd:MD_DataIdentification/gmd:abstract | srv:SV_ServiceIdentification/gmd:abstract "/>
				<xsl:apply-templates mode="Overview" select="//gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact | //gmd:MD_Metadata/gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:pointOfContact"/>
				<xsl:apply-templates select="//gmd:MD_Metadata/gmd:identificationInfo/*/gmd:resourceMaintenance | gmd:MD_DataIdentification/gmd:MD_MaintenanceInformation "/>
				<xsl:apply-templates select="gmd:MD_DataIdentification/gmd:purpose"/>
				<xsl:if test="../gmd:abstract | idAbsENG">					
					<tr>
						<td class="Level-1-element">Sammanfattning:</td>
						<td colspan="2">										
							<pre>
								<xsl:attribute name="id">pre
                  <xsl:value-of select="$preId"/><xsl:value-of select="position()"/></xsl:attribute>
								<xsl:attribute name="property">
									<xsl:value-of select="'dct:description'"/>
								</xsl:attribute>
								<xsl:attribute name="itemprop">
									<xsl:value-of select="'description'"/>
								</xsl:attribute>
								<xsl:choose>
									<!--Swedish Language -->
									<xsl:when test="$language = 'Swedish'">
										<xsl:value-of select="gco:CharacterString/text()" disable-output-escaping="yes"/>
									</xsl:when>
									<!--English Language -->
									<xsl:when test="$language = 'English'">
										<xsl:value-of select="idAbsENG"/>
									</xsl:when>
								</xsl:choose>
							</pre>
							
							<script type="text/javascript">
                fix2('pre
                <xsl:value-of select="$preId"/>
								<xsl:value-of select="position()"/>
                ');
              </script>
							<script type="text/javascript">setLinkClickable('abstractDiv');</script>
						</td>
					</tr>
					
					<!--</xsl:for-each>-->
				</xsl:if>
				
				<xsl:apply-templates select="gmd:MD_DataIdentification/gmd:graphicOverview |  srv:SV_ServiceIdentification/gmd:graphicOverview"/>
				
				<xsl:apply-templates select="gmd:MD_DataIdentification/gmd:descriptiveKeywords | srv:SV_ServiceIdentification/gmd:descriptiveKeywords "/>
				
				<xsl:for-each select="gmd:MD_DataIdentification/gmd:resourceConstraints | srv:SV_ServiceIdentification/gmd:resourceConstraints">
					<xsl:apply-templates select="gmd:MD_Constraints"/>
					<xsl:apply-templates select="gmd:MD_LegalConstraints"/>
					<!-- <xsl:apply-templates select="gmd:MD_SecurityConstraints/gmd:classification"/> -->
				</xsl:for-each>
				
				<xsl:for-each select="srv:SV_ServiceIdentification/srv:serviceType/gco:LocalName">
					<tr>
						<td class="Level-1-element">TYP AV TJÄNST</td>
						<td>
							<xsl:choose>
								<xsl:when test="text() = 'view'">Visning</xsl:when>
								<xsl:when test="text() = 'download'">Nedladdningstjänst</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="."/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
				</xsl:for-each>
				
				<xsl:apply-templates select="gmd:MD_DataIdentification/gmd:spatialResolution/gmd:MD_Resolution/gmd:equivalentScale/gmd:MD_RepresentativeFraction/gmd:denominator"/>
				
				<xsl:apply-templates select="gmd:MD_DataIdentification/gmd:spatialResolution/gmd:MD_Resolution/gmd:distance"/>
				
				<xsl:if test="idPurp | idPurpENG ">
					<tr>
						<td class="Level-1-element">Syfte:</td>
						<td>
							<pre>
								<xsl:attribute name="id">
                                    pre
                                    <xsl:value-of select="$preId"/><xsl:value-of select="position()"/></xsl:attribute>
								<xsl:choose>
									<!--Swedish Language -->
									<xsl:when test="$language = 'Swedish'">
										<xsl:value-of select="idPurp"/>
									</xsl:when>
									<!--English Language -->
									<xsl:when test="$language = 'English'">
										<xsl:value-of select="idPurpENG"/>
									</xsl:when>
								</xsl:choose>
							</pre>
							<script type="text/javascript">
                                fix('pre
                                <xsl:value-of select="$preId"/>
								<xsl:value-of select="position()"/>
                                ');
                            </script>
						</td>
					</tr>
					<!--</xsl:for-each>-->
				</xsl:if>
				<xsl:for-each select="gmd:MD_DataIdentification/gmd:language">
					<tr>
						<td class="Level-1-element">Språk i metadata</td>
						<xsl:apply-templates select="gmd:LanguageCode"/>
					</tr>
				</xsl:for-each>
				
				<xsl:if test="gmd:MD_DataIdentification/gmd:topicCategory | srv:SV_ServiceIdentification/gmd:topicCategory">
					<tr>
						<td class="Level-1-element">Ämnesområden</td>
						<td colspan="2">
							<xsl:for-each select="//gmd:MD_Metadata/gmd:identificationInfo//gmd:topicCategory/gmd:MD_TopicCategoryCode">
								<xsl:choose>
									<xsl:when test="text() = 'farming'">Areela näringar</xsl:when>
									<xsl:when test="text() = 'biota'">Biologi och ekologi</xsl:when>
									<xsl:when test="text() = 'boundaries'">Administrativa gränser</xsl:when>
									<xsl:when test="text() = 'climatologyMeteorologyAtmosphere'">Atmosfär, klimatologi och meteorologi</xsl:when>
									<xsl:when test="text() = 'economy'">Ekonomi</xsl:when>
									<xsl:when test="text() = 'elevation'">Höjddata</xsl:when>
									<xsl:when test="text() = 'environment'">Miljö</xsl:when>
									<xsl:when test="text() = 'geoscientificInformation'">Geovetenskap</xsl:when>
									<xsl:when test="text() = 'health'">Hälsa</xsl:when>
									<xsl:when test="text() = 'imageryBaseMapsEarthCover'">Arealtäckande bilder ocxh baskartor</xsl:when>
									<xsl:when test="text() = 'intelligenceMilitary'">Försvar</xsl:when>
									<xsl:when test="text() = 'inlandWaters'">Insjövatten</xsl:when>
									<xsl:when test="text() = 'location'">Positionering</xsl:when>
									<xsl:when test="text() = 'oceans'">Kust och hav</xsl:when>
									<xsl:when test="text() = 'planningCadastre'">Fastigheter och fysisk planering</xsl:when>
									<xsl:when test="text() = 'society'">Samhälle och kultur</xsl:when>
									<xsl:when test="text() = 'structure'">Byggnader och konstruktioner</xsl:when>
									<xsl:when test="text() = 'transportation'">Transporter</xsl:when>
									<xsl:when test="text() = 'utilitiesCommunication'">Tekniska försörjningssystem</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="text()"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:if test="position()!=last()">,</xsl:if>
							</xsl:for-each>
						</td>
					</tr>
				</xsl:if>
				
				<xsl:apply-templates select="gmd:MD_DataIdentification/gmd:extent  | srv:SV_ServiceIdentification/srv:extent"/>
								
				<!--Date : 01-11-10-->
				<!--completed-->
				<xsl:for-each select="dataChar">
					<tr>
						<td colspan="3" class="Level-1-element">Teckenuppsättning i data:</td>
						<xsl:apply-templates select="CharSetCd"/>
					</tr>
				</xsl:for-each>
				<xsl:for-each select="serType">
					<tr>
						<td class="Level-1-element">Typ av tjänst:</td>
						<td colspan="2">
							<xsl:choose>
								<xsl:when test="text() = 'view'">Visningstjänst</xsl:when>
								<xsl:when test="text() = 'download'">Nedladdningstjänst</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="."/>
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
				</xsl:for-each>
				<xsl:for-each select="typeProps">
					<tr>
						<td class="Level-1-element">Egenskaper för tjänst:</td>
						<td colspan="2">
							<xsl:value-of select="."/>
						</td>
					</tr>
				</xsl:for-each>
				<!-- <xsl:for-each select="//gmd:MD_Metadata/gmd:identificationInfo//gmd:status">
					<tr>
						<td class="Level-1-element">Status:</td>
						<td colspan="2">
							<xsl:for-each select="gmd:MD_ProgressCode">
								<xsl:choose>
									<xsl:when test="@codeListValue = 'completed'">Slutförd</xsl:when>
									<xsl:when test="@codeListValue = 'historicalArchive'">Historiskt arkiv</xsl:when>
									<xsl:when test="@codeListValue = 'obsolete'">Inte längre i bruk</xsl:when>
									<xsl:when test="@codeListValue = 'onGoing'">Pågående</xsl:when>
									<xsl:when test="@codeListValue = 'planned'">Planerad</xsl:when>
									<xsl:when test="@codeListValue = 'required'">Behövd</xsl:when>
									<xsl:when test="@codeListValue = 'underDevelopment'">Under framställning</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="@value"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</td>
					</tr>
				</xsl:for-each> -->
				
				<xsl:apply-templates select="idSpecUse"/>
				<!--added : 01-11-10-->
				<!-- <xsl:if test="srv:SV_ServiceIdentification/srv:serviceType/gco:LocalName or srv:SV_ServiceIdentification/srv:operatesOn">
					<tr>
						<td class="Level-0-Header" colspan="2">Information on tjänst:</td>
					</tr>
				</xsl:if> -->
				
				<xsl:for-each select="srv:SV_ServiceIdentification/srv:operatesOn">
					<tr>
						<xsl:variable name="urlLink" select="@xlink:href"/>
						<xsl:variable name="newURL">
							<xsl:call-template name="replace-string">
								<xsl:with-param name="text" select="$urlLink"/>
								<xsl:with-param name="replace" select="'&amp;'"/>
								<xsl:with-param name="with" select="'!!!'"/>
							</xsl:call-template>
						</xsl:variable>
						<td class="Level-2-element">Sammankopplad resurs:</td>
						<td>
							<a xmlns="http://www.w3.org/1999/xhtml" href="{concat('https://www.geodata.se/GeodataExplorer/GetMetaDataURL?url=',$newURL)}">
								<xsl:value-of select="@xlink:href"/>
							</a>
						</td>
					</tr>
				</xsl:for-each>
				<!-- <tr>
					<td colspan="2" class="Level-0-Header">Rumslig representation:</td>
				</tr> -->
				<!-- <xsl:for-each select="gmd:MD_DataIdentification/gmd:spatialRepresentationType">
					<tr>
						<td class="Level-1-element">Rumslig representation:</td>
						<td>
							<xsl:for-each select="gmd:MD_SpatialRepresentationTypeCode">
								<xsl:choose>
									<xsl:when test="@codeListValue = 'vector'">vektor</xsl:when>
									<xsl:when test="@codeListValue = 'raster'">raster</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="@value"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</td>
					</tr>
				</xsl:for-each> -->
				<xsl:apply-templates select="gmd:MD_Format"/>
				<!--<xsl:for-each select = "envirDesc">-->
				<xsl:for-each select="gmd:MD_DataIdentification/gmd:resourceFormat/gmd:MD_Format/gmd:name">
					<tr>
						<td class="Level-2-element">
							<xsl:if test="@Sync = 'TRUE'">
								<span class="s"><![CDATA[ ]]></span>
							</xsl:if>
              Formatnamn:
            </td>
						<td>
							<xsl:value-of select="gco:CharacterString/text()"/>
						</td>
					</tr>
				</xsl:for-each>
				<xsl:for-each select="gmd:MD_DataIdentification/gmd:resourceFormat/gmd:MD_Format/gmd:version">
					<tr>
						<td class="Level-2-element">Format version:</td>
						<td>
							<xsl:value-of select="gco:CharacterString/text()"/>
						</td>
					</tr>
				</xsl:for-each>
				<xsl:for-each select="*/gmd:environmentDescription">
					<tr>
						<!--<xsl:if test="@Sync = 'TRUE']">
                        <FONT color="#006400">*</FONT>
                        </xsl:if>-->
						<td class="Level-1-element">SYSTEMMILJÖ</td>
						<td>
							<xsl:value-of select="gco:CharacterString"/>
						</td>
					</tr>
				</xsl:for-each>
				<!--<xsl:apply-templates select = "gmd:MD_DataIdentification/dataScale"/>-->
				
				<xsl:apply-templates select="geoBox"/>
				<xsl:apply-templates select="geoDesc"/>

				<!--<xsl:for-each select = "suppInfo">-->
				<xsl:for-each select="gmd:MD_DataIdentification/gmd:supplementalInformation">
					<tr>
						<td class="Level-1-element">Övrig information:</td>
						<td>
							<xsl:value-of select="gco:CharacterString"/>
							<!--<pre>
                                <xsl:attribute name = "id">
                                    pre
                                    <xsl:value-of select = "$preId"/>
                                    <xsl:value-of select = "position()"/>
                                </xsl:attribute>
                                <xsl:value-of select = "."/>
                            </pre>
                            <script type = "text/javascript">
                                fix('pre
                                <xsl:value-of select = "$preId"/>
                                <xsl:value-of select = "position()"/>
                                ');
                            </script>-->
						</td>
					</tr>
				</xsl:for-each>
				<xsl:for-each select="idCredit">
					<tr>
						<td class="Level-1-element">Hedrande:</td>
						<td>
							<pre>
								<xsl:attribute name="id">
                                    pre
                                    <xsl:value-of select="$preId"/><xsl:value-of select="position()"/></xsl:attribute>
								<xsl:value-of select="."/>
							</pre>
							<script type="text/javascript">
                                fix('pre
                                <xsl:value-of select="$preId"/>
								<xsl:value-of select="position()"/>
                                ');
                            </script>
						</td>
					</tr>
				</xsl:for-each>
				<!--<xsl:apply-templates select = "idPoC"/>-->
				<!-- <xsl:apply-templates select="gmd:MD_DataIdentification/gmd:pointOfContact | srv:SV_ServiceIdentification/gmd:pointOfContact"/> -->
				<!-- <tr>
					<td colspan="2" class="Level-1-EmptyRow">-</td>
				</tr> -->
				
				<xsl:if test="//gmd:MD_Metadata/gmd:identificationInfo//gmd:aggregationInfo">
					<tr>
						<td colspan="2" class="Level-0-Header">Relaterade resurser:</td>
					</tr>
					<tr>
						<th colspan="2">
							<table class="MYTABLE" border="1" bordercolor="#6495ED">
								<tbody>
									<tr bgcolor="#EEEEEE">
										<td>Relaterad resurs:</td>
										<td>Alternativt namn</td>
										<td>Har relation</td>
									</tr>
									<xsl:for-each select="//gmd:MD_Metadata/gmd:identificationInfo//gmd:aggregationInfo">
										<tr>
											<td class="subtabledata">
												<!--<xsl:value-of select="AggrDSName/citId/identCode[text()]">
                                            <a href="javascript:ShowMetadata(this)"> -->
												<a>
													<xsl:attribute name="href">
														javascript:ShowMetadata('
														<xsl:value-of select="gmd:MD_AggregateInformation/gmd:aggregateDataSetName/gmd:CI_Citation/gmd:identifier/gmd:RS_Identifier/gmd:code/gco:CharacterString"/>
														');
													</xsl:attribute>
													<xsl:value-of select="gmd:MD_AggregateInformation/gmd:aggregateDataSetName/gmd:CI_Citation/gmd:title/gco:CharacterString[text()]"/>
												</a>
											</td>
											<td class="subtabledata">
												<xsl:value-of select="gmd:MD_AggregateInformation/gmd:aggregateDataSetName/gmd:CI_Citation/gmd:identifier/gmd:RS_Identifier/gmd:code/gco:CharacterString"/>
											</td>
											<td class="subtabledata">
												<xsl:for-each select="gmd:MD_AggregateInformation/gmd:associationType/gmd:DS_AssociationTypeCode">
													<xsl:choose>
														<xsl:when test="@codeListValue = 'crossReference'">Korsreferens</xsl:when>
														<xsl:when test="@codeListValue = 'largerWorkCitation'">Del av mer omfattande arbete</xsl:when>
														<xsl:when test="@codeListValue = 'partOfSeamlessDatabase'">Del av sömlös databas</xsl:when>
														<xsl:when test="@codeListValue = 'containsResource'">Består av resurs</xsl:when>
														<!--<xsl:when test="@codeListValue = '0991'">Föregående version till aktuell datamängd</xsl:when>
                                                        <xsl:when test="@codeListValue = '0992'">Efterkommande version till aktuell datamängd</xsl:when>
                                                        <xsl:when test="@value = '0993'">Är huvuddatabas (utgår)</xsl:when>
                                                        <xsl:when test="@value = '0995'">Är sökbart inom aktuell tjänst</xsl:when>
                                                        <xsl:when test="@value = '0996'">Är lager i aktuellt kartdokument</xsl:when>
                                                        <xsl:when test="@value = '0997'">Är en deldatabas till aktuell datamängd</xsl:when>
                                                        <xsl:when test="@value = '0998'">Är lager i aktuell tjänst</xsl:when>  -->
														<xsl:otherwise>
															<xsl:value-of select="@codeListValue"/>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:for-each>
											</td>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
						</th>
					</tr>
				</xsl:if>
			</tbody>
		</table>
	</xsl:template>
	<!-- Restrictions #222 -->
	<xsl:template match="gmd:MD_Metadata/gmd:identificationInfo" mode="Restriktioner">
		<xsl:param name="showHeader"/>
		<a>
			<xsl:attribute name="name"><xsl:value-of select="generate-id()"/></xsl:attribute>
		</a>
		<table id="resConst" class="mytabtable" >
			<xsl:if test="$showHeader = 'true'">
				<tr>
					<td colspan="2" class="sectionheader">Restriktioner</td>
				</tr>
			</xsl:if>
			<xsl:for-each select="gmd:MD_DataIdentification/gmd:resourceConstraints | srv:SV_ServiceIdentification/gmd:resourceConstraints">
				<xsl:apply-templates select="gmd:MD_Constraints"/>
				<xsl:apply-templates select="gmd:MD_LegalConstraints"/>
				<!-- <xsl:apply-templates select="gmd:MD_SecurityConstraints/gmd:classification"/> -->
			</xsl:for-each>
		</table>
	</xsl:template>
	<!-- #238 -->
	<xsl:template match="gmd:pointOfContact" mode="Overview">
		<xsl:variable name="role" select="gmd:CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue"/>
		<xsl:if test="$role='owner'">
				<xsl:variable name="orgName">
					<xsl:value-of select="gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString"/>
				</xsl:variable>
				<xsl:variable name="email">
					<xsl:value-of select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>
				</xsl:variable>
			<tr>
				<td class="Level-1-element">Resurskontakt</td>
				<td colspan="2" class="address">
					<xsl:value-of select="$orgName"/>,
					<i class="fa fa-envelope"></i>
					<a class="bold" href="mailto:{normalize-space($email)}">
						<xsl:value-of select="$email"/>
					</a>
				</td>
			</tr>
		</xsl:if>
	</xsl:template>
	<xsl:template match="gmd:distributorContact" mode="distributorContact">
			<xsl:variable name="displayName">
		  <xsl:choose>
			<xsl:when
					test="normalize-space(*/gmd:organisationName) != '' and normalize-space(*/gmd:individualName) != ''">
			  <!-- Org name may be multilingual -->
			  <xsl:apply-templates mode="render-value"
								   select="*/gmd:organisationName"/>
			  -
			  <xsl:value-of select="*/gmd:individualName"/>
			  <xsl:if test="normalize-space(*/gmd:positionName) != ''">
				(<xsl:apply-templates mode="render-value"
									  select="*/gmd:positionName"/>)
			  </xsl:if>
			</xsl:when>
			<xsl:otherwise>
			  <xsl:value-of select="*/gmd:organisationName|*/gmd:individualName"/>
			</xsl:otherwise>
		  </xsl:choose>
		</xsl:variable>
		<xsl:variable name="email">
			<xsl:value-of select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>
		</xsl:variable>
		<xsl:variable name="phoneNumber">
			<xsl:apply-templates mode="render-value" select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:voice"/>
		</xsl:variable>
		<xsl:variable name="faxNumber">
			<xsl:apply-templates mode="render-value" select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:facsimile"/>
		</xsl:variable>
		<xsl:variable name="website">
			<xsl:apply-templates mode="render-value" select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL"/>
		</xsl:variable>
		<tr>
			<td class="Level-1-element">Distributionskontakt</td>
			<td colspan="2" class="address">
				<xsl:if test="normalize-space($displayName) !=''">
					<i class="fa fa-envelope"></i>
					<a class="bold" href="mailto:{normalize-space($email)}"><xsl:value-of select="$displayName"/></a>
				</xsl:if>
				<xsl:for-each select="gmd:CI_ResponsibleParty/gmd:contactInfo/*">
					<xsl:for-each select="gmd:address/*/(
                                          gmd:deliveryPoint|gmd:city|
                                          gmd:administrativeArea|gmd:postalCode|gmd:country)">
						<span class="nonbold"><xsl:apply-templates mode="render-value" select="."/></span>
					</xsl:for-each>
				</xsl:for-each>
				<br/><br/>
				<xsl:if test="normalize-space($phoneNumber) !=''">
					<i class="fa fa-phone"></i>
					<a class="nonbold" href="tel:{normalize-space($phoneNumber)}"><xsl:value-of select="$phoneNumber"/></a>
				</xsl:if>
				<xsl:if test="normalize-space($faxNumber) !=''">
					<i class="fa fa-fax"></i>
					<a class="nonbold" href="tel:{normalize-space($phoneNumber)}"><xsl:value-of select="$faxNumber"/></a>
				</xsl:if>
				<xsl:if test="normalize-space($website) !=''">
					-
					<a class="nonbold" href="http://{$website}" target="_blank">
					<xsl:value-of select="normalize-space($website)"/>
					</a>
			  </xsl:if>	
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="gmd:contact" mode="contact">
		<xsl:variable name="displayName">
		  <xsl:choose>
			<xsl:when
					test="normalize-space(*/gmd:organisationName) != '' and normalize-space(*/gmd:individualName) != ''">
			  <!-- Org name may be multilingual -->
			  <xsl:apply-templates mode="render-value"
								   select="*/gmd:organisationName"/>
			  -
			  <xsl:value-of select="*/gmd:individualName"/>
			  <xsl:if test="normalize-space(*/gmd:positionName) != ''">
				(<xsl:apply-templates mode="render-value"
									  select="*/gmd:positionName"/>)
			  </xsl:if>
			</xsl:when>
			<xsl:otherwise>
			  <xsl:value-of select="*/gmd:organisationName|*/gmd:individualName"/>
			</xsl:otherwise>
		  </xsl:choose>
		</xsl:variable>
		<xsl:variable name="email">
			<xsl:value-of select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>
		</xsl:variable>
		<xsl:variable name="phoneNumber">
			<xsl:apply-templates mode="render-value" select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:voice"/>
		</xsl:variable>
		<xsl:variable name="faxNumber">
			<xsl:apply-templates mode="render-value" select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/gmd:CI_Telephone/gmd:facsimile"/>
		</xsl:variable>
		<xsl:variable name="website">
					<xsl:apply-templates mode="render-value" select="gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL"/>
		</xsl:variable>
		<tr>
			<td class="Level-1-element">Metadatakontakt</td>
			<td colspan="2" class="address">
				<xsl:if test="normalize-space($displayName) !=''">
					<i class="fa fa-envelope"></i>
					<a class="bold" href="mailto:{normalize-space($email)}"><xsl:value-of select="$displayName"/></a>
				</xsl:if>
				<xsl:for-each select="gmd:CI_ResponsibleParty/gmd:contactInfo/*">
					<xsl:for-each select="gmd:address/*/(
                                          gmd:deliveryPoint|gmd:city|
                                          gmd:administrativeArea|gmd:postalCode|gmd:country)">
						<span class="nonbold"><xsl:apply-templates mode="render-value" select="."/></span>
					</xsl:for-each>
				</xsl:for-each>
				<br/><br/>
				<xsl:if test="normalize-space($phoneNumber) !=''">
					<i class="fa fa-phone"></i>
					<a class="nonbold" href="tel:{normalize-space($phoneNumber)}"><xsl:value-of select="$phoneNumber"/></a>
				</xsl:if>
				<xsl:if test="normalize-space($faxNumber) !=''">
					<i class="fa fa-fax"></i>
					<a class="nonbold" href="tel:{normalize-space($phoneNumber)}"><xsl:value-of select="$faxNumber"/></a>
				</xsl:if>
				<xsl:if test="normalize-space($website) !=''">
					-
					<a class="nonbold" href="http://{$website}" target="_blank">
					<xsl:value-of select="normalize-space($website)"/>
					</a>
			  </xsl:if>	
			</td>
		</tr>
	</xsl:template>
	<!--Keyword Information (B.2.2.2 MD_Keywords - line52)-->
	<xsl:template match="gmd:MD_DataIdentification/gmd:descriptiveKeywords[*/gmd:thesaurusName/gmd:CI_Citation/gmd:title] | 
				srv:SV_ServiceIdentification/gmd:descriptiveKeywords[*/gmd:thesaurusName/gmd:CI_Citation/gmd:title]">
		<tr>
			<td class="Level-1-element">
					<xsl:value-of select="gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString[text()]"/>
					<xsl:if test="*/gmd:type/*[@codeListValue != '']">
						<xsl:variable name="mdKeywordTypeCode">
							<xsl:value-of select="*/gmd:type/*/@codeListValue" />
						</xsl:variable>
						<xsl:apply-templates mode="mdKeywordTypeCode" select="*/gmd:type/*/@codeListValue" />
					</xsl:if>
			</td>
			<td>
				<xsl:value-of select="*/gmd:keyword/*"/>
			</td>
		</tr>
	  </xsl:template>
	<xsl:template mode="mdKeywordTypeCode" match="*/gmd:type/*/@codeListValue">
		<xsl:choose>
			<xsl:when test=". = 'discipline' "> ( Disciplin )</xsl:when>
			<xsl:when test=". = 'place' "> ( Plats )</xsl:when>
			<xsl:when test=". = 'stratum' "> ( Lager )</xsl:when>
			<xsl:when test=". = 'temporal' "> ( Tidsperiod )</xsl:when>
			<xsl:when test=". = 'theme' "> ( Tema )</xsl:when>
			<xsl:otherwise> ( <xsl:value-of select="." /> )</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- <xsl:template match="gmd:MD_DataIdentification/gmd:descriptiveKeywords | srv:SV_ServiceIdentification/gmd:descriptiveKeywords">
		<tr>
			<td class="Level-1-element">
					<xsl:value-of select="gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString[text()]"/>
			</td>
			<xsl:if test="gmd:MD_Keywords/gmd:keyword/gco:CharacterString[text()]">
				<td itemprop="keywords" property="dcat:keyword">
					<xsl:for-each select="gmd:MD_Keywords/gmd:keyword/gco:CharacterString[text()]">
						<xsl:if test="text()=0">

						</xsl:if>
						<xsl:value-of select="text()"/>
						<xsl:if test="position()!=last()">,</xsl:if>
					</xsl:for-each>
				</td>
			</xsl:if>
		</tr>
	</xsl:template> -->
	<xsl:template match="gmd:graphicOverview[1]">
		<tr>
			<td class="Level-1-element">Exempelbild</td>
			<td colspan="2">
				<ul style="list-style-type: none;padding-left:2px;">
				  <xsl:for-each select="parent::node()/gmd:graphicOverview">
					<xsl:variable name="label">
					  <xsl:value-of select="gmd:MD_BrowseGraphic/gmd:fileDescription"/>
					</xsl:variable>
					<li style="display:block;">
					  <img src="{gmd:MD_BrowseGraphic/gmd:fileName/*}"
						   alt="{$label}"
						   class="img-thumbnail"/>
					</li>
					<li>{$label}</li>
				  </xsl:for-each>
				</ul>
			</td>
		</tr>
  </xsl:template>
  <xsl:template match="gmd:graphicOverview[position() > 1]"/>
	<!--Browse Graphic Information (B.2.2.1 MD_BrowGraph - line48) -->
	<!-- <xsl:template match="gmd:graphicOverview/gmd:MD_BrowseGraphic">
		<tr>
			<td colspan="2" class="Level-1-Header">Exempelbild:</td>
		</tr>
		<xsl:for-each select="gmd:fileName">
			<tr>
				<td class="Level-2-element">Sökväg:</td>
				<td>
					<xsl:value-of select="gco:CharacterString"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:fileType">
			<tr>
				<td class="Level-2-element">Bildformat:</td>
				<td>
					<xsl:value-of select="gco:CharacterString"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:fileDescription">
			<tr>
				<td class="Level-2-element">Bildtext:</td>
				<td>
					<xsl:value-of select="gco:CharacterString"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:fileName">
			<tr>
				<td colspan="2">
					<IMG ID="thumbnail" ALIGN="absmiddle" style="border:'2 outset #ffffff'; position:relative">
						<xsl:attribute name="SRC"><xsl:value-of select="gco:CharacterString"/></xsl:attribute>
					</IMG>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template> -->
	<!--Usage Information (B.2.2.5 MD_Usage - line62) -->
	<xsl:template match="idSpecUse">
		<tr>
			<td colspan="2" class="Level-1-Header">Hur resursen används:</td>
		</tr>
		<xsl:for-each select="usageDate">
			<tr>
				<td class="Level-2-element">Datum och tid för användning:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="specUsage">
			<tr>
				<td class="Level-2-element">Beskrivning:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="usrDetLim">
			<tr>
				<td class="Level-2-element">Användningsrestriktioner:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:apply-templates select="usrCntInfo"/>
		<!--</DD> -->
	</xsl:template>

	<xsl:template match="gmd:spatialResolution/gmd:MD_Resolution/gmd:equivalentScale/gmd:MD_RepresentativeFraction/gmd:denominator | gmd:equivalentScale/gmd:MD_RepresentativeFraction/gmd:denominator">
		<tr>
			<xsl:choose>
				<xsl:when test="../gmd:denominator">
					<td class="Level-1-element">Skalfaktor</td>
				</xsl:when>
				<xsl:when test="../srcScale">
					<td class="Level-1-element">Upplösning på källdata:</td>
				</xsl:when>
				<xsl:otherwise>
					<td class="Level-1-element">Upplösning:</td>
				</xsl:otherwise>
			</xsl:choose>
			<td>
				<xsl:value-of select="gco:Integer"/>
			</td>
		</tr>
		<xsl:for-each select="scaleDist">
			<tr>
				<td colspan="2" class="Level-1-Header">Avstånd mellan punkter:</td>
			</tr>
			<!--value will be shown regardless of the subelement Integer, Real, or Decimal -->
			<xsl:for-each select="value">
				<tr>
					<td class="Level-2-element">precision av spatiala data:</td>
					<td>
						<xsl:value-of select="."/>
					</td>
				</tr>
			</xsl:for-each>
			<xsl:apply-templates select="uom"/>
		</xsl:for-each>
		<!--</DL>
        </DD>-->
		<!--</DD> -->
	</xsl:template>
	
	<xsl:template match="gmd:MD_DataIdentification/gmd:spatialResolution/gmd:MD_Resolution/gmd:distance">
		<tr>
			<td class="Level-1-element">Avstånd</td>
			<td>
				<xsl:value-of select="gco:Distance"/><!-- <xsl:value-of select="gco:Distance/@uom"/> -->
			</td>
		</tr>
	</xsl:template>
	
	<!--Representative Fraction Information (B.2.2.3 MD_RepresentativeFraction - line56) -->
	<xsl:template match="equScale">
		<FONT color="#0000AA">
			<B>Datamängden skala:</B>
		</FONT>
		<xsl:for-each select="rfDenom">
			<FONT color="#0000AA">
				<B>Nämnare i skala:</B>
			</FONT>
            -->
            <xsl:value-of select="."/>
		</xsl:for-each>
		<xsl:for-each select="Scale">
			<tr>
				<td class="Level-1-element">Fraction is derived from scale:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--Units of Measurement Types (from ISO 19103 information in 19115 DTD) -->
	<xsl:template match="uom">
		<xsl:choose>
			<xsl:when test="UomArea">
				<tr>
					<td class="Level-1-element">Units of measure, area:</td>
				</tr>
			</xsl:when>
			<xsl:when test="UomLength">
				<tr>
					<td class="Level-1-element">Units of measure, length:</td>
				</tr>
			</xsl:when>
			<xsl:when test="UomVolume">
				<tr>
					<td class="Level-1-element">Units of measure, volume:</td>
				</tr>
			</xsl:when>
			<xsl:when test="UomScale">
				<tr>
					<td class="Level-1-element">Units of measure, scale:</td>
				</tr>
			</xsl:when>
			<xsl:when test="UomTime">
				<tr>
					<td class="Level-1-element">Units of measure, time:</td>
				</tr>
			</xsl:when>
			<xsl:when test="UomVelocity">
				<tr>
					<td class="Level-1-element">Units of measure, velocity:</td>
				</tr>
			</xsl:when>
			<xsl:when test="UomAngle">
				<tr>
					<td class="Level-1-element">Units of measure, angle:</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td class="Level-1-element">Units of measure:</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="node()"/>
	</xsl:template>
	<!--Units of Measurement (from ISO 19103 information in 19115 DTD) -->
	<xsl:template match="UomArea | UomTime | UomLength | UomVolume | UomVelocity |   UomAngle | UomScale | gmd:unitOfMeasure | axisUnits | falENUnits | valUnit">
		<xsl:for-each select="gmd:unitOfMeasureName">
			<tr>
				<td class="Level-2-element">Units:</td>
				<td>
					<xsl:value-of select="gco:CharacterString/text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="conversionToISOstandardUnit">
			<tr>
				<td class="Level-2-element">Conversion to metric:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--SPATIAL REpreSENTATION -->
	<!--Spatial Representation Information (B.2.6  MD_SpatialRepresentation - line156) -->
	<xsl:template match="metadata/spatRepInfo">
		<a>
			<xsl:attribute name="name"><xsl:value-of select="generate-id()"/></xsl:attribute>
		</a>
		<table class="mytabtable" border="1" bordercolor="#D3D3D3">
			<tbody>
				<xsl:choose>
					<xsl:when test="GridSpatRep">
						<tr>
							<td colspan="2" class="sectionheader">Referenssystem - Grid:</td>
						</tr>
					</xsl:when>
					<xsl:when test="Georect">
						<tr>
							<td colspan="2" class="sectionheader">Referenssystem - Georektifierat Grid:</td>
						</tr>
					</xsl:when>
					<xsl:when test="Georef">
						<tr>
							<td colspan="2" class="sectionheader">Referenssystem - Georeferererad Grid:</td>
						</tr>
					</xsl:when>
					<xsl:when test="VectSpatRep">
						<tr>
							<td colspan="2" class="sectionheader">Referenssystem - Vektor:</td>
						</tr>
					</xsl:when>
					<xsl:otherwise>
						<tr>
							<td colspan="2" class="sectionheader">Referenssystem:</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates/>
				<!--<A HREF="#Top">Back to Top</A>-->
			</tbody>
		</table>
	</xsl:template>
	<!--Grid Information (B.2.6  MD_GridSpatialRepresentation - line157, MD_Georectified - line162, and MD_Georeferenceable - line170) -->
	<xsl:template match="GridSpatRep | Georect | Georef">
		<xsl:for-each select="numDims">
			<tr>
				<td class="Level-1-element">Antal dimensioner:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:apply-templates select="axDimProps"/>
		<xsl:for-each select="cellGeo">
			<tr>
				<!--<xsl:if test="CellGeoCd/@Sync = 'TRUE']">
                <FONT color="#006400">*</FONT>
                </xsl:if>-->
				<td class="Level-1-element">Cellgeometri:</td>
				<td>
					<xsl:for-each select="CellGeoCd">
						<xsl:choose>
							<xsl:when test="@value = '001'">punkt</xsl:when>
							<xsl:when test="@value = '002'">yta</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@value"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="ptInPixel">
			<tr>
				<td class="Level-1-element">Point in pixel:</td>
				<td>
					<xsl:for-each select="PixOrientCd">
						<xsl:choose>
							<xsl:when test="@value = '001'">center</xsl:when>
							<xsl:when test="@value = '002'">lower left</xsl:when>
							<xsl:when test="@value = '003'">lower right</xsl:when>
							<xsl:when test="@value = '004'">upper right</xsl:when>
							<xsl:when test="@value = '005'">upper left</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@value"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="tranParaAv">
			<tr>
				<!--<xsl:if test="@Sync = 'TRUE']">
                <FONT color="#006400">*</FONT>
                </xsl:if>-->
				<td class="Level-1-element">Tillgängliga transformationsparametrar:</td>
				<td>
					<xsl:choose>
						<xsl:when test="text() = '1'">Ja</xsl:when>
						<xsl:when test="text() = '0'">Nej</xsl:when>
						<xsl:when test="text() = 'true'">Ja</xsl:when>
						<xsl:when test="text() = 'false'">Nej</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="text()"/>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="transDimDesc">
			<tr>
				<td class="Level-1-element">Transformation beskrivning:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="transDimMap">
			<tr>
				<td class="Level-1-element">Tranformation dimension mapping:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="chkPtAv">
			<tr>
				<td class="Level-1-element">Kontrollpunkter är tillgängliga:</td>
				<td>
					<xsl:choose>
						<xsl:when test="text() = '1'">Ja</xsl:when>
						<xsl:when test="text() = '0'">Nej</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="text()"/>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="chkPtDesc">
			<tr>
				<td class="Level-1-element">Beskrivning av kontrollpunkter:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="cornerPts">
			<tr>
				<td colspan="2" class="Level-1-Header">Hörnpunkter:</td>
			</tr>
			<xsl:for-each select="coordinates">
				<tr>
					<td class="Level-2-element">Coordinates:</td>
					<td>
						<xsl:value-of select="text()"/>
					</td>
				</tr>
			</xsl:for-each>
			<xsl:if test="MdCoRefSys">
				<tr>
					<td colspan="2" class="Level-1-Header">Coordinate system for points:</td>
				</tr>
				<xsl:apply-templates select="MdCoRefSys"/>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="centerPt">
			<tr>
				<td colspan="2" class="Level-1-Header">Center point:</td>
			</tr>
			<xsl:for-each select="coordinates">
				<tr>
					<td class="Level-2-element">Coordinates:</td>
					<td>
						<xsl:value-of select="text()"/>
					</td>
				</tr>
			</xsl:for-each>
			<xsl:if test="MdCoRefSys">
				<tr>
					<td colspan="2" class="Level-1-Header">Point's coordinate system:</td>
				</tr>
				<xsl:apply-templates select="MdCoRefSys"/>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="ctrlPtAv">
			<tr>
				<td class="Level-1-element">Control points are available:</td>
				<td>
					<xsl:choose>
						<xsl:when test="text() = '1'">Ja</xsl:when>
						<xsl:when test="text() = '0'">Nej</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="text()"/>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="orieParaAv">
			<tr>
				<td class="Level-1-element">Orientation parameters are available:</td>
				<td>
					<xsl:choose>
						<xsl:when test="text() = '1'">Ja</xsl:when>
						<xsl:when test="text() = '0'">Nej</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="text()"/>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="orieParaDs">
			<tr>
				<td class="Level-1-element">Orientation parameter description:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="georefPars">
			<tr>
				<td class="Level-1-element">eoreferencing parameters:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:apply-templates select="paraCit"/>
	</xsl:template>
	<!--Dimension Information (B.2.6.1 MD_Dimension - line179) -->
	<xsl:template match="axDimProps">
		<tr>
			<td colspan="2" class="Level-1-Header">Axlarnas egenskaper:</td>
		</tr>
		<xsl:for-each select="Dimen">
			<!--<DT>
            <FONT color="#0000AA">
            <B>Dimension:</B>
            </FONT>
            </DT>-->
			<!--<DD>
            <DL>-->
			<xsl:for-each select="dimName">
				<tr>
					<!--<xsl:if test="DimNameTypCd/@Sync = 'TRUE']">
                    <FONT color="#006400">*</FONT>
                    </xsl:if>-->
					<td class="Level-2-element">Dimension:</td>
					<td>
						<xsl:for-each select="DimNameTypCd">
							<xsl:choose>
								<xsl:when test="@value = '001'">rad (y-axel)</xsl:when>
								<xsl:when test="@value = '002'">column (x-axel)</xsl:when>
								<xsl:when test="@value = '003'">vertical (z-axis)</xsl:when>
								<xsl:when test="@value = '004'">track (along direction of motion)</xsl:when>
								<xsl:when test="@value = '005'">cross track (perpendicular to direction of motion)</xsl:when>
								<xsl:when test="@value = '006'">scal line of sensor</xsl:when>
								<xsl:when test="@value = '007'">sample (element along scan line)</xsl:when>
								<xsl:when test="@value = '008'">time duration</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="@value"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</td>
				</tr>
			</xsl:for-each>
			<xsl:for-each select="dimSize">
				<tr>
					<!--<xsl:if test="@Sync = 'TRUE']">
                    <FONT color="#006400">*</FONT>
                    </xsl:if>-->
					<td class="Level-2-element">Antal pixlar:</td>
					<td>
						<xsl:value-of select="text()"/>
					</td>
				</tr>
			</xsl:for-each>
			<xsl:for-each select="dimResol">
				<tr>
					<!--<xsl:if test="@Sync = 'TRUE']">
                    <FONT color="#006400">*</FONT>
                    </xsl:if>-->
					<td class="Level-2-element">Upplösning:</td>
					<td>
						<xsl:value-of select="."/>
					</td>
				</tr>
			</xsl:for-each>
			<!--</DL>
            </DD>-->
		</xsl:for-each>
	</xsl:template>
	<!--Vector Information (B.2.6  MD_VectorSpatialRepresentation - line176) -->
	<xsl:template match="VectSpatRep">
		<xsl:for-each select="topLvl">
			<tr>
				<!--<xsl:if test="TopoLevCd/@Sync = 'TRUE']">
                <FONT color="#006400">*</FONT>
                </xsl:if>-->
				<td class="Level-1-element">Topologi:</td>
				<td>
					<xsl:for-each select="TopoLevCd">
						<xsl:choose>
							<xsl:when test="@value = '001'">endast geometri</xsl:when>
							<xsl:when test="@value = '002'">topologi 1D</xsl:when>
							<xsl:when test="@value = '003'">planar graph</xsl:when>
							<xsl:when test="@value = '004'">full planar graph</xsl:when>
							<xsl:when test="@value = '005'">surface graph</xsl:when>
							<xsl:when test="@value = '006'">full surface graph</xsl:when>
							<xsl:when test="@value = '007'">topoloi 3D</xsl:when>
							<xsl:when test="@value = '008'">full topologi 3D</xsl:when>
							<xsl:when test="@value = '009'">abstract</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@value"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:apply-templates select="geometObjs"/>
	</xsl:template>
	<!--Geometric Object Information (B.2.6.2 MD_GeometricObjects - line183) -->
	<xsl:template match="geometObjs">
		<!--<DD>
        <DT>
        <FONT color="#0000AA">
        <B>Geometriskt objekt:</B>
        </FONT>
        </DT>
        <DD>
        <DL> -->
		<xsl:for-each select="@Name">
			<tr>
				<!--<FONT color="#006400">*</FONT>-->
				<td class="Level-1-element">Namn:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="geoObjTyp">
			<tr>
				<!--<xsl:if test="GeoObjTypCd/@Sync = 'TRUE']">
                <FONT color="#006400">*</FONT>
                </xsl:if>-->
				<td class="Level-1-element">Typ:</td>
				<td>
					<xsl:for-each select="GeoObjTypCd">
						<xsl:choose>
							<xsl:when test="@value = '001'">komplex</xsl:when>
							<xsl:when test="@value = '002'">composites</xsl:when>
							<xsl:when test="@value = '003'">curve</xsl:when>
							<xsl:when test="@value = '004'">punkt</xsl:when>
							<xsl:when test="@value = '005'">solid</xsl:when>
							<xsl:when test="@value = '006'">yta</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@value"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="geoObjCnt">
			<tr>
				<!--<xsl:if test="@Sync = 'TRUE']">
                <FONT color="#006400">*</FONT>
                </xsl:if>-->
				<td class="Level-1-element">Antal objekt:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--Identifier Information (B.2.7.2 MD_Identifier - line205) -->
	<!--start from here : 03-11-10 end-->
	<xsl:template match="gmd:geographicIdentifier | gmd:referenceSystemIdentifier | projection | ellipsoid | datum | refSysName | MdIdent | RS_Identifier | datumID ">
		<xsl:apply-templates select="gmd:MD_Identifier/gmd:code"/>
		<xsl:for-each select="gmd:MD_Identifier/gmd:code/gco:CharacterString">
			<tr>
				<td class="Level-1-element">Identifierare för geografiskt område</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:RS_Identifier/gmd:code/gco:CharacterString">
			<tr>
				<td class="Level-1-element">Rumsligt referenssystem</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--CONTENT INFORMATION -->
	<!--Content Information (B.2.8 MD_ContentInformation - line232) -->
	<xsl:template match="gmd:MD_Metadata/gmd:contentInfo">
		<a>
			<xsl:attribute name="NAME"><xsl:value-of select="generate-id()"/></xsl:attribute>
		</a>
		<table class="mytabtable" border="1" bordercolor="#D3D3D3">
			<tbody>
				<xsl:choose>
					<xsl:when test="gmd:contentInfo">
						<tr style="color: #0000AA; font-size: 12pt;">
							<!--<B>Content Information:</B> -->
						</tr>
					</xsl:when>
					<xsl:when test="gmd:MD_FeatureCatalogueDescription">
						<td colspan="2" class="sectionheader">Innehåll</td>
						<!--FC_FeatureCatalog-->
						<!--<xsl:apply-templates select = "gmd:MD_FeatureCatalogueDescription/gmd:includedWithDataset"/>-->
						<xsl:apply-templates select="gmd:MD_FeatureCatalogueDescription/FC_FeatureCatalog/FC_FeatureCatalog"/>
					</xsl:when>
					<xsl:when test="CovDesc">
						<tr>
							<td colspan="2" class="sectionheader">Content Information - Coverage Description:</td>
						</tr>
					</xsl:when>
					<xsl:when test="ImgDesc">
						<tr>
							<td colspan="2" class="sectionheader">Content Information - Image Description:</td>
						</tr>
					</xsl:when>
					<xsl:otherwise>
						<tr>
							<td colspan="2" class="sectionheader">Content Information:</td>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates/>
			</tbody>
		</table>
		<a href="#Top">Back to Top</a>
	</xsl:template>
	<!--Content Information (B.2.8 MD_ContentInformation ABSTRACT - line232) -->
	<xsl:template match="ContInfo">
		<tr>
			<td class="Level-1-element">Content Description:</td>
			<td>
				<xsl:value-of select="text()"/>
			</td>
		</tr>
	</xsl:template>
	<!--Feature Catalogue Description (B.2.8 MD_FeatureCatalogueDescription - line233) -->
	<xsl:template match="FetCatDesc">
		<xsl:for-each select="catLang">
			<tr>
				<td class="Level-1-element">Feature catalogue's language:</td>
				<xsl:apply-templates select="languageCode"/>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="incWithDS">
			<tr>
				<td class="Level-1-element">Catalogue accompanies the dataset:</td>
				<td>
					<xsl:choose>
						<xsl:when test="text() = '1'">Ja</xsl:when>
						<xsl:when test="text() = '0'">Nej</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="."/>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="compCode">
			<tr>
				<td class="Level-1-element">Catalogue complies with ISO 19110:</td>
				<td>
					<xsl:choose>
						<xsl:when test="text() = '1'">Ja</xsl:when>
						<xsl:when test="text() = '0'">Nej</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="."/>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="catFetTyps">
			<tr>
				<td class="Level-1-element">Feature types in the dataset:</td>
			</tr>
			<xsl:apply-templates/>
		</xsl:for-each>
		<xsl:apply-templates select="catCitation"/>
	</xsl:template>
	<!--Coverage Description (B.2.8 MD_CoverageDescription - line239) -->
	<xsl:template match="CovDesc">
		<xsl:for-each select="contentTyp">
			<tr>
				<td class="Level-1-element">Type of information:</td>
				<td>
					<xsl:for-each select="ContentTypCd">
						<xsl:choose>
							<xsl:when test="@value = '001'">image</xsl:when>
							<xsl:when test="@value = '002'">thematic classification</xsl:when>
							<xsl:when test="@value = '003'">physical measurement</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@value"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="attDesc">
			<tr>
				<td class="Level-1-element">Attribute described by cell values:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:apply-templates select="covDim"/>
	</xsl:template>
	<!--Range dimension Information (B.2.8.1 MD_RangeDimension - line256) -->
	<xsl:template match="covDim">
		<xsl:choose>
			<xsl:when test="RangeDim">
				<tr>
					<td colspan="2" class="Level-1-Header">Range of cell values:</td>
				</tr>
			</xsl:when>
			<xsl:when test="Band">
				<tr>
					<td colspan="2" class="Level-1-Header">Band information:</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td colspan="2" class="Level-1-Header">Cell value information:</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:for-each select="*/dimDescrp">
			<tr>
				<td class="Level-2-element">Minimum and maximum values:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:if test="*/seqID">
			<tr>
				<td class="Level-2-element">Band identifier:</td>
			</tr>
			<xsl:apply-templates select="*/seqID"/>
		</xsl:if>
		<xsl:for-each select="Band">
			<xsl:for-each select="maxVal">
				<tr>
					<td class="Level-1-element">Longest wavelength:</td>
					<td>
						<xsl:value-of select="text()"/>
					</td>
				</tr>
			</xsl:for-each>
			<xsl:for-each select="minVal">
				<tr>
					<td class="Level-1-element">Shortest wavelength:</td>
					<td>
						<xsl:value-of select="."/>
					</td>
				</tr>
			</xsl:for-each>
			<xsl:for-each select="pkResp">
				<tr>
					<td class="Level-1-element">Peak response wavelength:</td>
					<td>
						<xsl:value-of select="."/>
					</td>
				</tr>
			</xsl:for-each>
			<xsl:if test="valUnit">
				<tr>
					<td colspan="2" class="Level-1-Header">Wavelength units:</td>
				</tr>
				<xsl:apply-templates select="valUnit"/>
			</xsl:if>
			<xsl:for-each select="bitsPerVal">
				<tr>
					<td class="Level-1-element">Number of bits per value:</td>
					<td>
						<xsl:value-of select="."/>
					</td>
				</tr>
			</xsl:for-each>
			<xsl:for-each select="toneGrad">
				<tr>
					<td class="Level-1-element">Number of discrete values:</td>
					<td>
						<xsl:value-of select="."/>
					</td>
				</tr>
			</xsl:for-each>
			<xsl:for-each select="sclFac">
				<tr>
					<td class="Level-1-element">Scale factor applied to values:</td>
					<td>
						<xsl:value-of select="."/>
					</td>
				</tr>
			</xsl:for-each>
			<xsl:for-each select="offset">
				<tr>
					<td class="Level-1-element">Offset of values from zero:</td>
					<td>
						<xsl:value-of select="."/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	<!--Member Names (from ISO 19103 information in 19115 DTD) -->
	<!--Local Name and Scoped Name -->
	<xsl:template match="LocalName | ScopedName">
		<xsl:for-each select="scope">
			<tr>
				<td class="Level-2-element">Scope:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--Type Name -->
	<xsl:template match="TypeName">
		<xsl:for-each select="scope">
			<tr>
				<td class="Level-2-element">Scope:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="aName">
			<tr>
				<td class="Level-2-element">Name:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--Member Name -->
	<xsl:template match="MemberName | seqID">
		<xsl:for-each select="scope">
			<tr>
				<td class="Level-2-element">Scope:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="aName">
			<tr>
				<td class="Level-2-element">Name:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="attributeType">
			<tr>
				<td colspan="2" class="Level-1-Header">Attribute type:</td>
			</tr>
			<xsl:for-each select="scope">
				<tr>
					<td class="Level-2-element">Scope:</td>
					<td>
						<xsl:value-of select="text()"/>
					</td>
				</tr>
			</xsl:for-each>
			<xsl:for-each select="aName">
				<tr>
					<td class="Level-2-element">Name:</td>
					<td>
						<xsl:value-of select="text()"/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	<!--Image Description (B.2.8 MD_ImageDescription - line243) -->
	<xsl:template match="ImgDesc">
		<xsl:for-each select="illElevAng">
			<tr>
				<td class="Level-1-element">Illumination elevation angle:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="illAziAng">
			<tr>
				<td class="Level-1-element">Illumination azimuth angle:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="imagCond">
			<tr>
				<td class="Level-1-element">Imaging condition:</td>
				<td>
					<xsl:for-each select="ImgCondCd">
						<xsl:choose>
							<xsl:when test="@value = '001'">blurred image</xsl:when>
							<xsl:when test="@value = '002'">cloud</xsl:when>
							<xsl:when test="@value = '003'">degrading obliquity</xsl:when>
							<xsl:when test="@value = '004'">fog</xsl:when>
							<xsl:when test="@value = '005'">heavy smoke or dust</xsl:when>
							<xsl:when test="@value = '006'">night</xsl:when>
							<xsl:when test="@value = '007'">rain</xsl:when>
							<xsl:when test="@value = '008'">semi-darkness</xsl:when>
							<xsl:when test="@value = '009'">shadow</xsl:when>
							<xsl:when test="@value = '010'">snow</xsl:when>
							<xsl:when test="@value = '011'">terrain masking</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@value"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="cloudCovPer">
			<tr>
				<td class="Level-1-element">Percent cloud cover:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="imagQuCode">
			<tr>
				<td class="Level-1-element">Image quality code:</td>
			</tr>
			<xsl:apply-templates/>
		</xsl:for-each>
		<xsl:for-each select="prcTypCde">
			<tr>
				<td class="Level-1-element">Processing level code:</td>
			</tr>
			<xsl:apply-templates/>
		</xsl:for-each>
		<xsl:for-each select="cmpGenQuan">
			<tr>
				<td class="Level-1-element">Number of lossy compression cycles:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="trianInd">
			<tr>
				<td class="Level-1-element">Triangulation has been performed:</td>
				<td>
					<xsl:choose>
						<xsl:when test="text() = '1'">Ja</xsl:when>
						<xsl:when test="text() = '0'">Nej</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="text()"/>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="radCalDatAv">
			<tr>
				<td class="Level-1-element">Radiometric calibration is available:</td>
				<td>
					<xsl:choose>
						<xsl:when test="text() = '1'">Ja</xsl:when>
						<xsl:when test="text() = '0'">Nej</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="text()"/>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="camCalInAv">
			<tr>
				<td class="Level-1-element">Camera calibration is available:</td>
				<td>
					<xsl:choose>
						<xsl:when test="text() = '1'">Yes</xsl:when>
						<xsl:when test="text() = '0'">No</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="text()"/>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="filmDistInAv">
			<tr>
				<td class="Level-1-element">Film distortion information is available:</td>
				<td>
					<xsl:choose>
						<xsl:when test="text() = '1'">Yes</xsl:when>
						<xsl:when test="text() = '0'">No</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="text()"/>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="lensDistInAv">
			<tr>
				<td class="Level-1-element">Lens distortion information is available:</td>
				<td>
					<xsl:choose>
						<xsl:when test="text() = '1'">Yes</xsl:when>
						<xsl:when test="text() = '0'">No</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="text()"/>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--REFERENCE SYSTEM -->
	<!--Reference System Information (B.2.7 MD_ReferenceSystem - line186) -->
	<xsl:template match="gmd:MD_Metadata/gmd:referenceSystemInfo">
		<table id="referenceSystemInfo" class="mytabtable" >
			<tbody>
				<xsl:apply-templates select="gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier"/>
			</tbody>
		</table>
	</xsl:template>
	<!--Reference System Information (B.2.7 MD_ReferenceSystem - line186) -->
	<xsl:template match="gmd:MD_ReferenceSystem">
		<xsl:if test="gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:code/gco:CharacterString[text()]">
			<!--<DT>-->
			<tr>
				<td colspan="2" class="Level-1-Header">Referenssystem:</td>
			</tr>
			<xsl:apply-templates select="gmd:referenceSystemIdentifier"/>
			<!-- refSysID -->
			<!--</DT>-->
		</xsl:if>
	</xsl:template>
	<!--Metadata for Coordinate Systems (B.2.7 MD_CRS - line189) -->
	<xsl:template match="MdCoRefSys">
		<xsl:if test="refSysID">
			<tr>
				<td class="Level-1-element">Reference system identifier:</td>
				<xsl:apply-templates select="refSysID"/>
			</tr>
		</xsl:if>
		<xsl:if test="projection">
			<tr>
				<td>Projection identifier:</td>
			</tr>
			<xsl:apply-templates select="projection"/>
		</xsl:if>
		<xsl:if test="ellipsoid">
			<tr>
				<td>Ellipsoid identifier:</td>
			</tr>
			<xsl:apply-templates select="ellipsoid"/>
		</xsl:if>
		<xsl:if test="datum">
			<tr>
				<td>Datum identifier:</td>
			</tr>
			<xsl:apply-templates select="datum"/>
		</xsl:if>
		<xsl:apply-templates select="projParas"/>
		<xsl:apply-templates select="ellParas"/>
	</xsl:template>
	<!--Projection Parameter Information (B.2.7.5 MD_ProjectionParameters - line215) -->
	<xsl:template match="projParas">
		<tr>
			<td colspan="2" class="Level-1-Header">Projection parameters:</td>
		</tr>
		<xsl:for-each select="zone">
			<tr>
				<td class="Level-2-element">Zone number:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="stanParal">
			<tr>
				<td class="Level-2-element">Standard parallel:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="longCntMer">
			<tr>
				<td class="Level-2-element">Longitude of central meridian:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="latProjOri">
			<tr>
				<td class="Level-2-element">Latitude of projection origin:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="sclFacEqu">
			<tr>
				<td class="Level-2-element">Scale factor at equator:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="hgtProsPt">
			<tr>
				<td class="Level-2-element">Height of prospective point above surface:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="longProjCnt">
			<tr>
				<td class="Level-2-element">Longitude of projection center:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="latProjCnt">
			<tr>
				<td class="Level-2-element">Latitude of projection center:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="sclFacCnt">
			<tr>
				<td class="Level-2-element">Scale factor at center line:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="stVrLongPl">
			<tr>
				<td class="Level-2-element">Straight vertical longitude from pole:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="sclFacPrOr">
			<tr>
				<td class="Level-2-element">Scale factor at projection origin:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:apply-templates select="obLnAziPars"/>
		<xsl:apply-templates select="obLnPtPars"/>
		<xsl:for-each select="falEastng">
			<tr>
				<td class="Level-1-element">False easting:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="falNorthng">
			<tr>
				<td class="Level-1-element">False northing:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:if test="falENUnits">
			<tr>
				<td colspan="2" class="Level-1-Header">False easting northing units:</td>
			</tr>
			<xsl:apply-templates select="falENUnits"/>
		</xsl:if>
	</xsl:template>
	<!--Oblique Line Azimuth Information (B.2.7.3 MD_ObliqueLineAzimuth - line210) -->
	<xsl:template match="obLnAziPars">
		<tr>
			<td colspan="2" class="Level-1-Header">Oblique line azimuth parameter:</td>
		</tr>
		<xsl:for-each select="aziAngle">
			<tr>
				<td class="Level-2-element">Azimuth angle:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="aziPtLong">
			<tr>
				<td class="Level-2-element">Azimuth measure point longitude:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--Oblique Line Point Information (B.2.7.4 MD_ObliqueLinePoint - line212) -->
	<xsl:template match="obLnPtPars">
		<tr>
			<td colspan="2" class="Level-1-Header">Oblique line point parameter:</td>
		</tr>
		<xsl:for-each select="obLineLat">
			<tr>
				<td class="Level-2-element">Oblique line latitude:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="obLineLong">
			<tr>
				<td class="Level-2-element">Oblique line longitude:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--Ellipsoid Parameter Information (B.2.7.1 MD_EllipsoidParameters - line201) -->
	<xsl:template match="ellParas">
		<tr>
			<td colspan="2" class="Level-1-Header">Ellipsoid parameters:</td>
		</tr>
		<xsl:for-each select="semiMajAx">
			<tr>
				<td class="Level-2-element">Semi-major axis:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:if test="axisUnits">
			<tr>
				<td colspan="2" class="Level-1-Header">Axis units:</td>
			</tr>
			<xsl:apply-templates select="axisUnits"/>
		</xsl:if>
		<xsl:for-each select="denFlatRat">
			<tr>
				<td class="Level-2-element">Denominator of flattening ratio:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--DATA QUALITY -->
	<!--Data Quality Information  (B.2.4 DQ_DataQuality - line78) -->
	<xsl:template match="gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality">
		<xsl:param name="showHeader"/>
		<xsl:variable name="preId" select="generate-id()"/>
		<a>
			<xsl:attribute name="name"><xsl:value-of select="generate-id()"/></xsl:attribute>
		</a>
		<table class="mytabtable" border="1" bordercolor="#D3D3D3">
			<xsl:if test="$showHeader = 'true'">
				<tr>
					<td colspan="2" class="sectionheader">Kvalitet</td>
				</tr>
			</xsl:if>
			<!-- <xsl:apply-templates select="gmd:scope/gmd:DQ_Scope"/> -->
			<!--<xsl:for-each select = "dqReport"> need to check with this elements gmd:report-->
			<xsl:for-each select="gmd:report">
				<xsl:apply-templates select="node()"/>
			</xsl:for-each>
			
			<xsl:apply-templates select="gmd:lineage/gmd:LI_Lineage"/>
		</table>
	</xsl:template>
	<!--Scope Information (B.2.4.4 DQ_Scope - line138)-->
	<xsl:template match="gmd:scope/gmd:DQ_Scope">
		<!-- <tr>
			<td colspan="2" class="Level-1-Header">Omfattning:</td>
		</tr> -->
		<xsl:for-each select="gmd:level">
			<tr>
				<td class="Level-2-element">Hierarkisk nivå på data:</td>
				<td>
					<!--                    
                    <xsl:for-each select="gmd:MD_ScopeCode">
                        <xsl:apply-templates select="@codeListValue"/>
                    </xsl:for-each>
-->
					<xsl:apply-templates select="gmd:MD_ScopeCode"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:apply-templates select="scpLvlDesc"/>
		<xsl:apply-templates select="gmd:extent | srv:extent"/>
	</xsl:template>
	<!--Lineage Information (B.2.4.1 LI_Lineage - line82) -->
	<xsl:template match="gmd:lineage/gmd:LI_Lineage">
		<xsl:variable name="preId" select="generate-id()"/>
		<xsl:if test="gmd:statement/gco:CharacterString[text()]">
			<xsl:for-each select="gmd:statement">
				<tr>
					<td class="Level-1-element">Tillkomsthistorik</td>
					<td>
						<div class="pre">
							<xsl:attribute name="id">pre<xsl:value-of select="$preId"/><xsl:value-of select="position()"/></xsl:attribute>
							<xsl:value-of select="gco:CharacterString/text()"/>
						</div>
						<script type="text/javascript">setLinkClickable('pre<xsl:value-of select="$preId"/>
							<xsl:value-of select="position()"/>');</script>
						<!--<script type = "text/javascript">
                            fix('pre
                            <xsl:value-of select = "$preId"/>
                            <xsl:value-of select = "position()"/>
                            ');
                        </script>-->
					</td>
				</tr>
			</xsl:for-each>
		</xsl:if>
		<xsl:apply-templates select="gmd:processStep"/>
		<xsl:apply-templates select="dataSource"/>
	</xsl:template>
	<!--<xsl:template match = "gmd:dataQualityInfo/gmd:DQ_DataQuality">
        <xsl:apply-templates select = "gmd:report/gmd:DQ_DomainConsistency"/>
    </xsl:template>-->
	<!--Source Information (B.2.4.1.2 LI_Source - line92) -->
	<xsl:template match="dataSource | stepSrc">
		<xsl:if test="srcDesc[text()]">
			<tr>
				<td class="Level-1-element">Källdata:</td>
				<xsl:for-each select="srcDesc">
					<td>
						<xsl:value-of select="text()"/>
					</td>
				</xsl:for-each>
			</tr>
		</xsl:if>
		<!--<xsl:apply-templates select = "srcScale"/>-->
		<xsl:apply-templates select="gmd:MD_DataIdentification/gmd:spatialResolution/gmd:MD_Resolution/gmd:equivalentScale/gmd:MD_RepresentativeFraction/gmd:denominator"/>
		<xsl:apply-templates select="srcCitatn"/>
		<xsl:for-each select="srcRefSys">
			<tr>
				<td class="Level-1-element">Source reference system:</td>
			</tr>
			<xsl:apply-templates select="RefSystem"/>
			<xsl:apply-templates select="MdCoRefSys"/>
		</xsl:for-each>
		<xsl:apply-templates select="srcExt"/>
		<xsl:if test="not (../stepSrc)">
			<xsl:apply-templates select="srcStep"/>
		</xsl:if>
		<xsl:apply-templates select="gmd:processStep"/>
		<xsl:if test="dataSource/srcDesc[text()]">
			<xsl:apply-templates select="dataSource"/>
		</xsl:if>
	</xsl:template>
	<!--Process Step Information (B.2.4.1.1 LI_ProcessStep - line86) -->
	<xsl:template match="gmd:processStep | srcStep">
		<xsl:if test="gmd:LI_ProcessStep/gmd:description/gco:CharacterString[text()]">
			<tr>
				<td colspan="2" class="Level-1-Header">Bearbetningssteg:</td>
			</tr>
			<xsl:for-each select="gmd:LI_ProcessStep/gmd:dateTime">
				<tr>
					<td class="Level-2-element">Bearbetningsdatum:</td>
					<td>
						<xsl:value-of select="gco:DateTime/text()"/>
					</td>
				</tr>
			</xsl:for-each>
			<xsl:for-each select="gmd:LI_ProcessStep/gmd:description">
				<tr>
					<td class="Level-2-element">Bearbetningsteg:</td>
					<td>
						<xsl:value-of select="gco:CharacterString/text()"/>
					</td>
				</tr>
			</xsl:for-each>
			<xsl:for-each select="gmd:LI_ProcessStep/gmd:rationale">
				<tr>
					<td class="Level-2-element">Syfte med bearbetningsprocess:</td>
					<td>
						<xsl:value-of select="gco:CharacterString/text()"/>
					</td>
				</tr>
			</xsl:for-each>
			<xsl:apply-templates select="gmd:LI_ProcessStep/gmd:processor"/>
			<xsl:apply-templates select="stepSrc"/>
			<xsl:for-each select="../gmd:source/gmd:LI_Source">
				<tr>
					<td class="Level-1-element">
            Källdata:
          </td>
					<xsl:for-each select="gmd:description">
						<td>
							<xsl:value-of select="gco:CharacterString"/>
						</td>
					</xsl:for-each>
				</tr>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>
	<!--Data Quality Element Information (B.2.4.2 DQ_Element - line99) -->
	<!--    <xsl:template match = "DQComplete | DQCompComm | DQCompOm | DQLogConsis | DQConcConsis | DQDomConsis | DQFormConsis | DQTopConsis | DQPosAcc | DQAbsExtPosAcc |        DQGridDataPosAcc | DQRelIntPosAcc | DQTempAcc | DQAccTimeMeas | DQTempConsis | DQTempValid | DQThemAcc | DQThemClassCor | DQNonQuanAttAcc | DQQuanAttAcc"> -->
	<xsl:template match="gmd:DQ_Completeness | gmd:DQ_CompletenessCommission | gmd:DQ_CompletenessOmission | DQ_LogicalConsistency | gmd:DQ_ConceptualConsistency | gmd:DQ_DomainConsistency | gmd:DQ_FormatConsistency | gmd:DQ_TopologicalConsistency | gmd:DQ_PositionalAccuracy | gmd:DQ_AbsoluteExternalPositionalAccuracy |        DQGridDataPosAcc | gmd:DQ_RelativeInternalPositionalAccuracy | DQTempAcc | gmd:DQ_AccuracyOfATimeMeasurement | gmd:DQ_TemporalConsistency | gmd:DQ_TemporalValidity | gmd:DQ_ThematicAccuracy | gmd:DQ_ThematicClassificationCorrectness | gmd:DQ_NonQuantitativeAttributeAccuracy | gmd:DQ_QuantitativeAttributeAccuracy|gmd:DQ_UsabilityElement">
		<xsl:for-each select="gmd:nameOfMeasure">
			<tr>
				<td class="Level-1-element">Måttbenämning</td>
				<td>
					<xsl:value-of select="gco:CharacterString/text()"/>
				</td>
			</tr>
		</xsl:for-each>		
		<xsl:for-each select="gmd:result">
			<xsl:apply-templates select="../gmd:result/gmd:DQ_ConformanceResult"/>
			<xsl:apply-templates select="../gmd:result/gmd:DQ_QuantitativeResult"/>
		</xsl:for-each>
	</xsl:template>
	<!--Conformance Result Information (B.2.4.3 DQ_ConformanceResult - line129) -->
	<xsl:template match="gmd:result/gmd:DQ_ConformanceResult">
		<!-- <tr>
			<td colspan="2" class="Level-2-Header">Resultat av överensstämmelsetester:</td>
		</tr> -->
		<xsl:apply-templates select="gmd:specification/gmd:CI_Citation"/>
		<xsl:for-each select="gmd:explanation/gco:CharacterString">
			<tr>
				<td class="Level-1-element">Beskrivning</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:pass/gco:Boolean">
			<tr>
				<!--<td class = "Level-2-element">Test passed:</td>-->
				<td class="Level-1-element">Överensstämmelse</td>
				<td>
					<xsl:choose>
						<xsl:when test="normalize-space(text()) = '1'">true</xsl:when>
						<xsl:when test="normalize-space(text())= '0'">false</xsl:when>
						<xsl:when test="normalize-space(text()) = 'true'">true</xsl:when>
						<xsl:when test="normalize-space(text()) = 'false'">false</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="text()"/>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="gmd:DQ_QuantitativeResult">
		<!-- <tr>
			<td colspan="2" class="Level-2-Header">Resultat från kvalitetskontroll:</td>
		</tr> -->
		<xsl:for-each select="gmd:valueType/gco:RecordType">
			<tr>
				<td class="Level-1-element">Värdetyp</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:value/gco:Record">
			<tr>
				<td class="Level-1-element">Value</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="gmd:MD_Metadata/gmd:distributionInfo">
		<xsl:param name="showHeader"/>
		<a>
			<xsl:attribute name="NAME"><xsl:value-of select="generate-id()"/></xsl:attribute>
		</a>
		<table class="mytabtable" border="1" bordercolor="#D3D3D3">
			<tbody>
				<xsl:if test="$showHeader = 'true'">
					<tr>
						<td colspan="2" class="sectionheader">Distribution</td>
					</tr>
				</xsl:if>
				<xsl:apply-templates select="gmd:MD_Distribution/gmd:distributor"/>
				<!--distributor"/> -->
				<xsl:apply-templates select="distFormat"/>
				<xsl:if test="gmd:MD_Distribution/gmd:transferOptions">
					<!-- <tr>
						<td colspan="2" class="sectionheader">OBS: nedanstående Online länkar motsvarar krav från Inspire <br/> dvs, länkar anges utan att det finns en koppling till specifika distributörer</td>
					</tr> -->
					<xsl:apply-templates select="gmd:MD_Distribution/gmd:transferOptions"/>
				</xsl:if>
			</tbody>
		</table>
	</xsl:template>
	<!--Distributor Information (B.2.10.2 MD_Distributor - line279) -->
	<xsl:template match="gmd:MD_Distribution/gmd:distributor | formatDist">
		<!-- <tr>
			<td colspan="2" class="Level-1-Header">Distributör:</td>
		</tr> -->
		<xsl:apply-templates mode="distributorContact" select="gmd:MD_Distributor/gmd:distributorContact"/>
		<xsl:if test="not ((../../dsFormat) or (../../gmd:distributorFormat) or (../../distFormat))">
			<xsl:apply-templates mode="distributorFormat" select="gmd:MD_Distributor/gmd:distributorFormat"/>
		</xsl:if>
		<!--<xsl:apply-templates select = "distorOrdPrc"/>-->
		<xsl:apply-templates select="gmd:MD_Distributor/gmd:distributionOrderProcess/gmd:MD_StandardOrderProcess"/>
		<xsl:apply-templates select="distorTran"/>
		<xsl:apply-templates mode="online" select=" gmd:MD_Distributor/gmd:distributorTransferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine"/>
	</xsl:template>
	<xsl:template mode="distributorFormat" match="gmd:MD_Distributor/gmd:distributorFormat[1]">
		<tr>
			<td class="Level-1-element">Format</td>
			<td colspan="2">
			  <xsl:for-each select="parent::node()/gmd:distributorFormat">
				<xsl:value-of select="*/gmd:name/gco:CharacterString/text()"/>
				(<xsl:value-of select="*/gmd:version/gco:CharacterString/text()"/>)
				<xsl:if test="position()!=last()">,</xsl:if>
			  </xsl:for-each>
			</td>
		</tr>
	</xsl:template>
	<xsl:template mode="distributorFormat" match="gmd:distributorFormat[position() > 1]"/>
	
	<!--Format Information (B.2.10.3 MD_Format - line284) -->
	<xsl:template match="gmd:MD_Format | gmd:MD_Distributor/gmd:distributorFormat | distFormat ">
		<xsl:for-each select="gmd:MD_Format/gmd:name">
			<tr>
				<td class="Level-2-element">
					<xsl:if test="@Sync = 'TRUE'">
						<span class="s"><![CDATA[ ]]></span>
					</xsl:if>
                    Formatnamn:
                </td>
				<td>
					<xsl:value-of select="gco:CharacterString/text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:MD_Format/gmd:version">
			<tr>
				<td class="Level-2-element">Format version:</td>
				<td>
					<xsl:value-of select="gco:CharacterString/text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="formatAmdNum">
			<tr>
				<td class="Level-2-element">Format amendment number:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="formatSpec">
			<tr>
				<td class="Level-2-element">Format specification:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="fileDecmTech">
			<tr>
				<td class="Level-2-element">File decompression technique:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:if test="not ((../../distributor) or (../../formatDist))">
			<xsl:apply-templates select="formatDist"/>
		</xsl:if>
	</xsl:template>
	<!--Standard Order Process Information (B.2.10.5 MD_StandardOrderProcess - line298) -->
	<!--<xsl:template match = "distorOrdPrc">-->
	<xsl:template match="gmd:MD_Distributor/gmd:distributionOrderProcess/gmd:MD_StandardOrderProcess">
		<tr>
			<!--Ordering process:-->
			<td class="Level-1-Header">Beställning:</td>
		</tr>
		<xsl:for-each select="gmd:fees">
			<tr>
				<!--Terms and fees:-->
				<td class="Level-2-element">Avgifter:</td>
				<td>
					<xsl:value-of select="gco:CharacterString"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:turnaround">
			<tr>
				<!--Terms and fees:-->
				<td class="Level-2-element">Leveranstid:</td>
				<td>
					<xsl:value-of select="gco:CharacterString"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:orderingInstructions">
			<tr>
				<!--Terms and fees:-->
				<td class="Level-2-element">Anvisningar:</td>
				<td>
					<xsl:value-of select="gco:CharacterString"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="planAvDtTm">
			<tr>
				<td class="Level-2-element">Date of availability:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="ordTurn">
			<tr>
				<td class="Level-2-element">Turnaround time:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="ordInstr">
			<tr>
				<td class="Level-2-element">Instructions:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--Digital Transfer Options Information (B.2.10.1 MD_DigitalTransferOptions - line274) -->
	<!--<xsl:template match = "distorTran | distTranOps">-->
	<xsl:template match="distorTran | gmd:MD_Distribution/gmd:transferOptions">
		<!-- <tr>
			<td colspan="2" class="Level-1-Header">Onlinekälla:</td>
		</tr> -->
		<xsl:for-each select="unitsODist">
			<tr>
				<td class="Level-2-element">Antal enheter:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:apply-templates mode="online" select="gmd:MD_DigitalTransferOptions/gmd:onLine"/>
		<xsl:apply-templates select="gmd:MD_DigitalTransferOptions/gmd:offLine"/>
		<xsl:apply-templates select="offLineMed"/>
	</xsl:template>
	<!--Medium Information (B.2.10.4 MD_Medium - line291) -->
	<!--<xsl:template match = "offLineMed">-->
	<xsl:template match="gmd:MD_DigitalTransferOptions/gmd:offLine">
		<tr>
			<td colspan="2" class="Level-1-Header">Distributionsmedia:</td>
		</tr>
		<xsl:for-each select="gmd:MD_Medium">
			<xsl:for-each select="gmd:name">
				<tr>
					<td class="Level-2-element">Namn på media:</td>
					<td>
						<xsl:for-each select="gmd:MD_MediumNameCode">
							<xsl:choose>
								<xsl:when test="@codeListValue = '001'">CD-ROM</xsl:when>
								<xsl:when test="@codeListValue = '002'">DVD</xsl:when>
								<xsl:when test="@codeListValue = '003'">DVD-ROM</xsl:when>
								<xsl:when test="@codeListValue = '004'">3.5 inch floppy disk</xsl:when>
								<xsl:when test="@codeListValue = '005'">5.25 inch floppy disk</xsl:when>
								<xsl:when test="@codeListValue = '006'">7 track tape</xsl:when>
								<xsl:when test="@codeListValue = '007'">9 track tape</xsl:when>
								<xsl:when test="@codeListValue = '008'">3480 cartridge</xsl:when>
								<xsl:when test="@codeListValue = '009'">3490 cartridge</xsl:when>
								<xsl:when test="@codeListValue = '010'">3580 cartridge</xsl:when>
								<xsl:when test="@codeListValue = '011'">4mm cartridge tape</xsl:when>
								<xsl:when test="@codeListValue = '012'">8mm cartridge tape</xsl:when>
								<xsl:when test="@codeListValue = '013'">0.25 inch cartridge tape</xsl:when>
								<xsl:when test="@codeListValue = '014'">digital linear tape</xsl:when>
								<xsl:when test="@codeListValue = '015'">uppkopplad länk</xsl:when>
								<xsl:when test="@codeListValue = '016'">satellite link</xsl:when>
								<xsl:when test="@codeListValue = '017'">telephone link</xsl:when>
								<xsl:when test="@codeListValue = '018'">hardcopy</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="@codeListValue"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:for-each select="gmd:MD_Medium/gmd:mediumNote">
			<tr>
				<td class="Level-2-element">Antal media:</td>
				<td>
					<xsl:value-of select="gco:CharacterString"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="medFormat">
			<tr>
				<td class="Level-2-element">How the medium is written:</td>
				<td>
					<xsl:for-each select="MedFormCd">
						<xsl:choose>
							<xsl:when test="@value = '001'">cpio</xsl:when>
							<xsl:when test="@value = '002'">tar</xsl:when>
							<xsl:when test="@value = '003'">high sierra file system</xsl:when>
							<xsl:when test="@value = '004'">iso9660 (CD-ROM)</xsl:when>
							<xsl:when test="@value = '005'">iso9660 Rock Ridge</xsl:when>
							<xsl:when test="@value = '006'">iso9660 Apple HFS</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@value"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="medDensity">
			<tr>
				<td class="Level-2-element">Recording density:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="medDenUnits">
			<tr>
				<td class="Level-2-element">Density units of measure:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="medNote">
			<tr>
				<td class="Level-2-element">Limitations for using the medium:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--Portrayal Catalogue Reference (B.2.9 MD_PortrayalCatalogueReference - line268) -->
	<xsl:template match="porCatInfo">
		<a>
			<xsl:attribute name="NAME"><xsl:value-of select="generate-id()"/></xsl:attribute>
		</a>
		<table class="mytabtable" border="1" bordercolor="#D3D3D3">
			<tbody>
				<xsl:if test="count(/metadata/porCatInfo) = 1">
					<tr>
						<td class="sectionheader">Portrayal Catalogue Reference:</td>
					</tr>
				</xsl:if>
				<xsl:if test="count(/metadata/porCatInfo) &gt; 1">
					<tr>
						<td class="sectionheader">
                            Portrayal Catalogue Reference - Catalogue
                            <xsl:value-of select="position()"/>
                            :
                        </td>
					</tr>
				</xsl:if>
				<xsl:apply-templates select="portCatCit"/>
			</tbody>
		</table>
		<a href="#Top">Back to Top</a>
	</xsl:template>
	<!--APPLICATION SCHEMA -->
	<!--Application schema Information (B.2.12 MD_ApplicationSchemaInformation - line320) -->
	<xsl:template match="appSchInfo">
		<a>
			<xsl:attribute name="NAME"><xsl:value-of select="generate-id()"/></xsl:attribute>
		</a>
		<table class="mytabtable" border="1" bordercolor="#D3D3D3">
			<tbody>
				<xsl:if test="count(/metadata/appSchInfo) = 1">
					<tr>
						<td class="sectionheader">Application Schema Information:</td>
					</tr>
				</xsl:if>
				<xsl:if test="count(/metadata/appSchInfo) &gt; 1">
					<tr>
						<td class="sectionheader">
                            Application Schema Information - Schema
                            <xsl:value-of select="position()"/>
                            :
                        </td>
					</tr>
				</xsl:if>
				<xsl:apply-templates select="asName"/>
				<xsl:for-each select="asSchLang">
					<tr>
						<td class="Level-2-element">Schema language used:</td>
						<td>
							<xsl:value-of select="text()"/>
						</td>
					</tr>
				</xsl:for-each>
				<xsl:for-each select="asCstLang">
					<tr>
						<td class="Level-2-element">Formal language used in schema:</td>
						<td>
							<xsl:value-of select="text()"/>
						</td>
					</tr>
				</xsl:for-each>
				<xsl:for-each select="asAscii">
					<tr>
						<td class="Level-2-element">Schema ASCII file:</td>
						<td>
							<xsl:value-of select="text()"/>
						</td>
					</tr>
				</xsl:for-each>
				<xsl:for-each select="asGraFile">
					<tr>
						<td class="Level-2-element">Schema graphics file:</td>
						<td>
							<xsl:value-of select="text()"/>
						</td>
					</tr>
				</xsl:for-each>
				<xsl:for-each select="asSwDevFile">
					<tr>
						<td class="Level-2-element">Schema software development file:</td>
						<td>
							<xsl:value-of select="."/>
						</td>
					</tr>
				</xsl:for-each>
				<xsl:for-each select="asSwDevFiFt">
					<tr>
						<td class="Level-2-element">Software development file format:</td>
						<td>
							<xsl:value-of select="."/>
						</td>
					</tr>
				</xsl:for-each>
				<xsl:apply-templates select="featCatSup"/>
			</tbody>
		</table>
		<a href="#Top">Back to Top</a>
	</xsl:template>
	<!--Spatial Attribute Supplement Information (B.2.12.2 MD_SpatialAttributeSupplement - line332) -->
	<xsl:template match="featCatSup">
		<tr>
			<td class="Level-1-element">Feature catalogue supplement:</td>
		</tr>
		<xsl:apply-templates select="featTypeList"/>
	</xsl:template>
	<!--Feature Type List Information (B.2.12.1 MD_FeatureTypeList - line329 -->
	<xsl:template match="featTypeList">
		<tr>
			<td class="Level-1-Header">Feature type list:</td>
		</tr>
		<xsl:for-each select="spatObj">
			<tr>
				<td class="Level-2-element">Spatial object:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="spatSchName">
			<tr>
				<td class="Level-2-element">Spatial schema name:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--METADATA EXTENSIONS -->
	<!--Metadata Extension Information (B.2.11 MD_MetadataExtensionInformation - line303) -->
	<xsl:template match="mdExtInfo">
		<a>
			<xsl:attribute name="name"><xsl:value-of select="generate-id()"/></xsl:attribute>
		</a>
		<table class="mytabtable" border="1" bordercolor="#D3D3D3">
			<tr>
				<td colspan="2" class="sectionheader">Metadata extension information:</td>
			</tr>
			<xsl:apply-templates select="extOnRes"/>
			<xsl:apply-templates select="extEleInfo"/>
		</table>
		<a href="#Top">Back to Top</a>
	</xsl:template>
	<!--Extended Element Information (B.2.11.1 MD_ExtendedElementInformation - line306) -->
	<xsl:template match="extEleInfo">
		<tr>
			<td colspan="2" class="Level-1-Header">Extended element information:</td>
		</tr>
		<xsl:for-each select="extEleName">
			<tr>
				<td class="Level-2-element">Element name:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="extShortName">
			<tr>
				<td class="Level-2-element">Short name:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="extDomCode">
			<tr>
				<td class="Level-2-element">Codelist value:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="extEleDef">
			<tr>
				<td class="Level-2-element">Definition:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="extEleOb">
			<tr>
				<td class="Level-2-element">Obligation:</td>
				<td>
					<xsl:for-each select="ObCd">
						<xsl:choose>
							<xsl:when test="@value = '001'">mandatory</xsl:when>
							<xsl:when test="@value = '002'">optional</xsl:when>
							<xsl:when test="@value = '003'">conditional</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@value"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="extEleCond">
			<tr>
				<td class="Level-2-element">Condition:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="extEleMxOc">
			<tr>
				<td class="Level-2-element">Maximum occurrence:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="eleDataType">
			<tr>
				<td class="Level-2-element">Data type:</td>
				<td>
					<xsl:for-each select="DatatypeCd">
						<xsl:choose>
							<xsl:when test="@value = '001'">class</xsl:when>
							<xsl:when test="@value = '002'">codelist</xsl:when>
							<xsl:when test="@value = '003'">enumeration</xsl:when>
							<xsl:when test="@value = '004'">codelist element</xsl:when>
							<xsl:when test="@value = '005'">abstract class</xsl:when>
							<xsl:when test="@value = '006'">aggregate class</xsl:when>
							<xsl:when test="@value = '007'">specified class</xsl:when>
							<xsl:when test="@value = '008'">datatype class</xsl:when>
							<xsl:when test="@value = '009'">interface class</xsl:when>
							<xsl:when test="@value = '010'">union class</xsl:when>
							<xsl:when test="@value = '011'">meta class</xsl:when>
							<xsl:when test="@value = '012'">type class</xsl:when>
							<xsl:when test="@value = '013'">character string</xsl:when>
							<xsl:when test="@value = '014'">integer</xsl:when>
							<xsl:when test="@value = '015'">association</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@value"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="extEleDomVal">
			<tr>
				<td class="Level-2-element">Domain:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="extEleParEnt">
			<tr>
				<td class="Level-1-element">Parent element:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="extEleRule">
			<tr>
				<td class="Level-1-element">Relationship to existing elements:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="extEleRat">
			<tr>
				<td class="Level-1-element">Why the element was created:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:apply-templates select="extEleSrc"/>
	</xsl:template>
	<!--TEMPLATES FOR DATA TYPE CLASSES -->
	<!--CITATION AND CONTACT INFORMATION -->
	<!--Citation Information (B.3.2 CI_Citation - line359) -->
	<!--<xsl:template match = "gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation | thesaName | identAuth | srcCitatn | evalProc | conSpec | paraCit | portCatCit | catCitation | asName">-->
	<xsl:template match="gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation | thesaName | identAuth | srcCitatn | evalProc | gmd:specification/gmd:CI_Citation  | paraCit | portCatCit | catCitation | asName | srv:SV_ServiceIdentification/gmd:citation/gmd:CI_Citation">
		<xsl:choose>
			<xsl:when test="../gmd:MD_DataIdentification | ../srv:SV_ServiceIdentification">
				<!--<tr>
                <td>  
                Citation:
                </td>
                </tr>-->
			</xsl:when>
			<xsl:when test="../thesaName">
				<tr>
					<td colspan="2" class="Level-1-Header">Thesaurus name:</td>
				</tr>
			</xsl:when>
			<xsl:when test="../identAuth">
				<tr>
					<td colspan="2" class="Level-1-Header">Refererensystem som beskriver värdet:</td>
				</tr>
			</xsl:when>
			<xsl:when test="../srcCitatn">
				<tr>
					<td colspan="2" class="Level-1-Header">Source citation:</td>
				</tr>
			</xsl:when>
			<xsl:when test="../evalProc">
				<tr>
					<td colspan="2" class="Level-1-Header">Beskrivning av utvärderingsprocedur:</td>
				</tr>
			</xsl:when>
			<xsl:when test="../gmd:specification">
				<tr>
					<td colspan="2" class="Level-1-Header">Description of conformance requirements:</td>
				</tr>
			</xsl:when>
			<xsl:when test="../paraCit">
				<tr>
					<td colspan="2" class="Level-1-Header">Georeferencing parameters citation:</td>
				</tr>
			</xsl:when>
			<xsl:when test="../portCatCit">
				<tr>
					<td colspan="2" class="Level-1-Header">Portrayal catalogue citation:</td>
				</tr>
			</xsl:when>
			<xsl:when test="../catCitation">
				<tr>
					<td colspan="2" class="Level-1-Header">Feature catalogue citation:</td>
				</tr>
			</xsl:when>
			<xsl:when test="../asName">
				<tr>
					<td colspan="2" class="Level-1-Header">Application schema name:</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<!-- <tr> -->
					<!--<td colspan = "2" class = "Level-1-Header">Citation:</td>-->
				<!--	<td colspan="2" class="Level-1-Header">Hänvisning till specifikation:</td>
				</tr> -->
			</xsl:otherwise>
		</xsl:choose>
		<!-- Jwalin-->
		<xsl:for-each select="gmd:title">
			<tr>
				<td class="Level-1-element">Titel</td>
				<td>
					<xsl:value-of select="gco:CharacterString/text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:if test="gmd:alternateTitle">
			<!-- <tr>
				<td class="Level-2-element">Alternativ titel</td>
				<td>
					<xsl:for-each select="gmd:alternateTitle">
						<xsl:value-of select="gco:CharacterString/text()"/>
						<xsl:if test="position()!=last()">,</xsl:if>
					</xsl:for-each>
				</td>
			</tr> -->
			<xsl:for-each select="gmd:alternateTitle">
				<tr>
					<td class="Level-1-element">Alternativ titel</td>
					<td>
						<xsl:apply-templates mode="render-value" select="gco:CharacterString"/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:if>
		<xsl:apply-templates select="gmd:date"/>
		<xsl:for-each select="resEd">
			<tr>
				<td class="Level-2-element">Version:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="resEdDate">
			<tr>
				<td class="Level-2-element">Edition date:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<!--Jwalin-->
		<!--<DD>
        <DL>-->
		<!--Start #116 -->
		<xsl:choose>
			<!--Swedish language -->
			<xsl:when test="$language = 'Swedish'">
				<xsl:for-each select="gmd:CI_Citation/gmd:Title">
					<tr>
						<td class="Level-2-element">Titel:</td>
						<td>
							<xsl:value-of select="gco:CharacterString/text()"/>
						</td>
					</tr>
				</xsl:for-each>
			</xsl:when>
			<!--English language -->
			<xsl:when test="$language = 'English'">
				<xsl:for-each select="gmd:CI_Citation/gmd:Title">
					<tr>
						<td class="Level-2-element">Title:</td>
						<td>
							<xsl:value-of select="gco:CharacterString/text()"/>
						</td>
					</tr>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
		<!--End #116 -->
		<xsl:if test="resAltTitle">
			<tr>
				<td class="Level-2-element">Alternativ titel:</td>
				<td>
					<xsl:for-each select="gmd:CI_Citation/gmd:alternateTitle/gco:CharacterString[text()]">
						<xsl:value-of select="gmd:CI_Citation/gmd:alternateTitle/gco:CharacterString/text()"/>
						<xsl:if test="position()!=last()">,</xsl:if>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:if>
		<xsl:apply-templates select="resRefDate"/>
		<xsl:for-each select="resEd">
			<tr>
				<td class="Level-2-element">Version:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="resEdDate">
			<tr>
				<td class="Level-2-element">Edition date:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="collTitle">
			<tr>
				<td class="Level-2-element">Collection title:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:apply-templates select="gmd:series"/>
		<xsl:for-each select="isbn">
			<tr>
				<td class="Level-2-element">ISBN:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="issn">
			<tr>
				<td class="Level-2-element">ISSN:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:identifier/(gmd:RS_Identifier | gmd:MD_Identifier)/gmd:code">
			<tr>
				<!--<td class = "Level-2-element">Unik identifierare för resurs:</td>-->
				<td class="Level-1-element">Identifierare för resurs</td>
				<td>
					<xsl:value-of select="gco:CharacterString/text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="citIdType">
			<tr>
				<td class="Level-2-element">Typ av identifierare:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="otherCitDet">
			<tr>
				<td class="Level-2-element">Annan hänvisning:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<!--<xsl:apply-templates select = "citRespParty"/>-->
		<!--<xsl:apply-templates select = "gmd:CI_ResponsibleParty"/>-->
		<!--</DL>
        </DD>-->
	</xsl:template>
	<!--Date Information (B.3.2.3 CI_Date) -->
	<xsl:template match="gmd:date">
		<tr>
			<td class="Level-1-element">
				<xsl:for-each select="gmd:CI_Date">
					<xsl:for-each select="gmd:dateType">
						<xsl:for-each select="gmd:CI_DateTypeCode">
							<xsl:choose>
								<xsl:when test="@codeListValue = 'creation'">Datum ( Skapande )</xsl:when>
								<xsl:when test="@codeListValue = 'publication'">Datum ( Publicering )</xsl:when>
								<xsl:when test="@codeListValue = 'revision'">Datum ( Revision )</xsl:when>
								<!--Extension MetaGIS/Michael Östling 2003-03-06-->
								<xsl:when test="@codeListValue = '004'">Leveransdatum:</xsl:when>
								<xsl:when test="@codeListValue = '091'">Granskningsdatum:</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="@codeListValue"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
						<!--<xsl:value-of select="gco:Date"/>-->
					</xsl:for-each>
				</xsl:for-each>
			</td>
			<td colspan="2" datatype='xsd:date'>
				<xsl:attribute name="content">
					<xsl:value-of select="gmd:CI_Date/gmd:date/gco:Date"/>
				</xsl:attribute>
				<span>
					<xsl:if test="../../../gmd:citation">
				<xsl:choose>					
					<xsl:when test="gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='creation'">
						<xsl:attribute name="itemprop">
							<xsl:value-of select="'dateCreated'"/>
						</xsl:attribute>
						<xsl:attribute name="property">
							<xsl:value-of select="'dct:created'"/>
						</xsl:attribute>
					</xsl:when>
					<xsl:when test="gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='revision'">
						<xsl:attribute name="itemprop">
							<xsl:value-of select="'dateModified'"/>
						</xsl:attribute>
						<xsl:attribute name="property">
							<xsl:value-of select="'dct:modified'"/>
						</xsl:attribute>
					</xsl:when>					
					<xsl:when test="gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='publication'">
						<xsl:attribute name="itemprop">
							<xsl:value-of select="'datePublished'"/>
						</xsl:attribute>
						<xsl:attribute name="property">
							<xsl:value-of select="'dct:issued'"/>
						</xsl:attribute>
					</xsl:when>					
				</xsl:choose>
						<xsl:attribute name="datetime">
							<xsl:value-of select="gmd:CI_Date/gmd:date/gco:Date"/>
						</xsl:attribute>
					</xsl:if>
				<xsl:for-each select="gmd:CI_Date">
					<xsl:for-each select="gmd:date">
						<!--<DT>-->
						<xsl:apply-templates mode="render-value" select="gco:Date"/>
						<!--</DT>-->
					</xsl:for-each>
				</xsl:for-each>
				</span>
			</td>
		</tr>
		<!--Date : 30.10.2010-->
	</xsl:template>
	<xsl:template mode="maxDate" match="gmd:date[1]">
		<xsl:variable name="dates">
			<xsl:for-each select="parent::node()/gmd:date">
				<xsl:value-of  select="*/gmd:date/gco:Date[matches(., '[0-9]{4}-[0-9]{2}-[0-9]{2}')]"/>
				<xsl:if test="position() != last()">,</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="dateList" select="tokenize(normalize-space($dates), ',')" />
		<xsl:variable name="latestDate" select="max($dateList)" />
		<xsl:for-each select="parent::node()/gmd:date[gmd:CI_Date/gmd:date/gco:Date=$latestDate]">
			<tr>
			  <td class="Level-1-element">
				  <xsl:choose>					
					<xsl:when test="gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='creation'">Datum ( Skapande )</xsl:when>
					<xsl:when test="gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='publication'">Datum ( Publicering )</xsl:when>					
					<xsl:when test="gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='revision'">Datum ( Revision )</xsl:when>
				</xsl:choose>
			  </td>
			  <td colspan="2">
				<xsl:apply-templates mode="render-value" select="*/gmd:date/*"/>
			  </td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<xsl:template mode="maxDate" match="gmd:date[position() > 1]" priority="100"/>
	<!--Responsible Party Information (B.3.2 CI_ResponsibleParty - line374) -->
	<!---->
	<!--<xsl:template match = "gmd:contact | idPoC | usrCntInfo | stepProc | gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact | citRespParty | extEleSrc ">-->
	<!--gmd:contact/gmd:CI_ResponsibleParty-->
	<xsl:template match="usrCntInfo | gmd:LI_ProcessStep/gmd:processor | gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact | extEleSrc | gmd:MD_Distributor/gmd:distributorContact | gmd:identificationInfo/srv:SV_ServiceIdentification/gmd:pointOfContact">
		<xsl:choose>
			<xsl:when test="../gmd:contact">
				<tr>
					<td colspan="2" class="Level-1-Header">Metadatakontakt:</td>
				</tr>
			</xsl:when>
			<!--<xsl:when test = "../idPoC">-->
			<xsl:when test="../gmd:CI_ResponsibleParty">
				<tr>
					<!--<td colspan = "2" class = "Level-1-Header">Point of contact:</td>-->
					<td colspan="2" class="Level-1-Header">Resurskontakt:</td>
				</tr>
			</xsl:when>
			<xsl:when test="../usrCntInfo">
				<tr>
					<td colspan="2" class="Level-1-Header">Party using the resource:</td>
				</tr>
			</xsl:when>
			<xsl:when test="../gmd:processor">
				<tr>
					<td colspan="2" class="Level-1-Header">Bearbetningsanvarig:</td>
				</tr>
			</xsl:when>
			<!--<xsl:when test = "../gmd:pointOfContact">
                <tr>
                    -->
			<!--<td colspan = "2" class = "Level-1-Header">Kontaktinformation6666:</td>-->
			<!--
          <td colspan = "2" class = "Level-0-Header">Kontaktinformation6666:</td>
        </tr>
            </xsl:when>-->
			<xsl:when test="../gmd:distributorContact">
				<tr>
					<td colspan="2" class="Level-1-Header">Resurskontakt:</td>
				</tr>
			</xsl:when>
			<xsl:when test="gmd:CI_ResponsibleParty">
				<tr>
					<td colspan="2" class="Level-1-EmptyRow">-</td>
				</tr>
				<tr>
					<!--<td colspan = "2" class = "Level-0-Header">Kontaktinformation:</td>-->
					<td colspan="2" class="Level-0-Header">Resurskontakt:</td>
				</tr>
				<tr>
					<!--<FONT color="#0000AA">
                    <B>Delvis ansvarig för data: </B>
                    </FONT> -->
					<!--<xsl:for-each select = "../gmd:CI_ResponsibleParty/gmd:role">-->
					<xsl:for-each select="../gmd:CI_ResponsibleParty/gmd:role">
						<xsl:for-each select="gmd:CI_RoleCode">
							<xsl:choose>
								<xsl:when test="@codeListValue = 'resourceProvider'">
									<td colspan="2" class="Level-1-Header">Leverantör</td>
								</xsl:when>
								<xsl:when test="@codeListValue = 'custodian'">
									<td colspan="2" class="Level-1-Header">Förvaltare</td>
								</xsl:when>
								<xsl:when test="@codeListValue = 'owner'">
									<td colspan="2" class="Level-1-Header">Ansvarig</td>
								</xsl:when>
								<xsl:when test="@codeListValue = 'user'">
									<td colspan="2" class="Level-1-Header">Användare</td>
								</xsl:when>
								<xsl:when test="@codeListValue = 'distributor'">
									<td colspan="2" class="Level-1-Header">Distributör</td>
								</xsl:when>
								<xsl:when test="@codeListValue = 'originator'">
									<td colspan="2" class="Level-1-Header">Producent</td>
								</xsl:when>
								<xsl:when test="@codeListValue = 'pointOfContact'">
									<td colspan="2" class="Level-1-Header">Organisatorisk tillhörighet</td>
								</xsl:when>
								<xsl:when test="@codeListValue = 'principalInvestigator'">
									<td colspan="2" class="Level-1-Header">Undersökningsledare</td>
								</xsl:when>
								<xsl:when test="@codeListValue = 'processor'">
									<td colspan="2" class="Level-1-Header">Vidareförädlare</td>
								</xsl:when>
								<xsl:when test="@codeListValue = 'publisher'">
									<td colspan="2" class="Level-1-Header">Utgivare</td>
								</xsl:when>
								<xsl:when test="@codeListValue = 'author'">
									<td colspan="2" class="Level-1-Header">Upphovsman</td>
								</xsl:when>
								<xsl:when test="@codeListValue = 'informationManager'">
									<td colspan="2" class="Level-1-Header">Informationsförvaltare</td>
								</xsl:when>
								<xsl:when test="@codeListValue = 'actingInformationManager'">
									<td colspan="2" class="Level-1-Header">Tillförordnad Informationsförvaltare</td>
								</xsl:when>
								<xsl:when test="@codeListValue = 'datasetsManager'">
									<td colspan="2" class="Level-1-Header">Dataset förvaltare</td>
								</xsl:when>
								<xsl:when test="@codeListValue = 'manager'">
									<td colspan="2" class="Level-1-Header">Chef</td>
								</xsl:when>
								<xsl:otherwise>
									<td colspan="2" class="Level-1-Header">
										<xsl:value-of select="@codeListValue"/>
									</td>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:for-each>
				</tr>
			</xsl:when>
			<xsl:when test="../extEleSrc">
				<tr>
					<td>Extension source:</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td>Contact information:</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:for-each select="gmd:CI_ResponsibleParty/gmd:role">
			<tr>
				<!--Information om data-->
				<td class="Level-2-element">Ansvarsområde:</td>
				<td>
					<xsl:for-each select="gmd:CI_RoleCode">
						<xsl:choose>
							<xsl:when test="@codeListValue = 'resourceProvider'">Leverantör</xsl:when>
							<xsl:when test="@codeListValue = 'custodian'">Förvaltare</xsl:when>
							<xsl:when test="@codeListValue = 'owner'">Ansvarig</xsl:when>
							<xsl:when test="@codeListValue = 'user'">Användare</xsl:when>
							<xsl:when test="@codeListValue = 'distributor'">Distributör</xsl:when>
							<xsl:when test="@codeListValue = 'originator'">Producent</xsl:when>
							<xsl:when test="@codeListValue = 'pointOfContact'">Organisatorisk tillhörighet</xsl:when>
							<xsl:when test="@codeListValue = 'principalInvestigator'">Undersökningsledare</xsl:when>
							<xsl:when test="@codeListValue = 'processor'">Vidareförädlare</xsl:when>
							<xsl:when test="@codeListValue = 'publisher'">Utgivare</xsl:when>
							<xsl:when test="@codeListValue = 'author'">Upphovsman</xsl:when>
							<xsl:when test="@codeListValue = '101'">informationsförvaltare/designer</xsl:when>
							<xsl:when test="@codeListValue = '102'">teknisk förvaltare</xsl:when>
							<xsl:when test="@codeListValue = 'informationManager'">Informationsförvaltare</xsl:when>
							<xsl:when test="@codeListValue = 'actingInformationManager'">Tillförordnad Informationsförvaltare</xsl:when>
							<xsl:when test="@codeListValue = 'datasetsManager'">Dataset förvaltare</xsl:when>
							<xsl:when test="@codeListValue = 'manager'">Chef</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@gmd:CI_RoleCode"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:CI_ResponsibleParty/gmd:individualName">
			<tr>
				<td class="Level-2-element">Person:</td>
				<td>
					<xsl:value-of select="gco:CharacterString/text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<!--Make Comment : 04-11-10 It had occured double times-->
		<xsl:for-each select="gmd:CI_ResponsibleParty/gmd:organisationName">
			<tr>
				<td class="Level-2-element">Organsation:</td>
				<td>
					<xsl:value-of select="gco:CharacterString/text()"/>
				</td>
			</tr>
		</xsl:for-each>		
		<xsl:apply-templates select="gmd:CI_ResponsibleParty/gmd:contactInfo"/>
	</xsl:template>
	<xsl:template match="gmd:MD_DataIdentification/gmd:abstract | srv:SV_ServiceIdentification/gmd:abstract ">
		<tr>
			<td class="Level-1-element">Sammanfattning</td>
			<td colspan="2">
				<div id="abstract">
					<xsl:variable name="preId" select="generate-id()"/>					
					<pre>
						<xsl:attribute name="id">pre<xsl:value-of select="$preId"/><xsl:value-of select="position()"/></xsl:attribute>
						<xsl:attribute name="property"><xsl:value-of select="'dct:description'"/></xsl:attribute>
						<xsl:attribute name="itemprop"><xsl:value-of select="'description'"/></xsl:attribute>
						<xsl:value-of select="gco:CharacterString/text()" disable-output-escaping="yes"/>
					</pre>
					<script type="text/javascript">fix2('pre<xsl:value-of select="$preId"/>
						<xsl:value-of select="position()"/>');
						</script>
				</div>
				<script type="text/javascript">setLinkClickable('abstract');</script>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="gmd:MD_DataIdentification/gmd:purpose">
		<tr>
			<td class="Level-1-element">Syfte:</td>
			<td>
				<xsl:value-of select="gco:CharacterString/text()"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty | gmd:contact/gmd:CI_ResponsibleParty">
		<xsl:choose>
			<xsl:when test="../gmd:contact">
				<tr>
					<td colspan="2" class="Level-1-Header">Metadatakontakt:</td>
				</tr>
			</xsl:when>
			<!--<xsl:when test = "../idPoC">-->
			<xsl:when test="../gmd:CI_ResponsibleParty">
				<tr>
					<!--<td colspan = "2" class = "Level-1-Header">Point of contact:</td>-->
					<td colspan="2" class="Level-1-Header">Resurskontakt:</td>
				</tr>
			</xsl:when>
			<xsl:when test="../usrCntInfo">
				<tr>
					<td colspan="2" class="Level-1-Header">Party using the resource:</td>
				</tr>
			</xsl:when>
			<xsl:when test="../gmd:processor">
				<tr>
					<td colspan="2" class="Level-1-Header">Bearbetningsanvarig:</td>
				</tr>
			</xsl:when>
			<xsl:when test="../gmd:pointOfContact">
				<tr>
					<td colspan="2" class="Level-1-Header">Resurskontakt:</td>
				</tr>
			</xsl:when>
			<!--<xsl:when test = "gmd:contact/gmd:CI_ResponsibleParty">tttt007-->
			<xsl:when test="gmd:CI_ResponsibleParty">
				<tr>
					<td colspan="2" class="Level-1-EmptyRow">-</td>
				</tr>
				<tr>
					<td colspan="2" class="Level-0-Header">Resurskontakt:</td>
				</tr>
				<tr>
					<!--<FONT color="#0000AA">
                    <B>Delvis ansvarig för data: </B>
                    </FONT> -->
					<!--<xsl:for-each select = "../gmd:CI_ResponsibleParty/gmd:role">-->
					<xsl:for-each select="gmd:CI_ResponsiblePartyy">
						<xsl:for-each select="gmd:role">
							<xsl:for-each select="gmd:CI_RoleCode">
								<xsl:choose>
									<xsl:when test="@codeListValue = 'pointOfContact'">Organisatorisk tillhörighet</xsl:when>
									<xsl:when test="@codeListValue = 'resourceProvider'">Leverantör</xsl:when>
									<!--<xsl:when test = "@codeListValue = 'originator'">
                    <td colspan = "2" class = "Level-1-Header">Förvaltare</td>
                  </xsl:when>-->
									<xsl:when test="@codeListValue = 'custodian'">
										<td colspan="2" class="Level-1-Header">Förvaltare</td>
									</xsl:when>
									<xsl:when test="@codeListValue = 'owner'">
										<td colspan="2" class="Level-1-Header">Ansvarig</td>
									</xsl:when>
									<xsl:when test="@codeListValue = 'user'">
										<td colspan="2" class="Level-1-Header">Användare</td>
									</xsl:when>
									<xsl:when test="@codeListValue = 'distributör'">
										<!--*-->
										<td colspan="2" class="Level-1-Header">Leverantör</td>
										<!--*-->
									</xsl:when>
									<xsl:when test="@codeListValue = 'originator'">
										<td colspan="2" class="Level-1-Header">Producent</td>
									</xsl:when>
									<xsl:when test="@codeListValue = 'originator'">
										<td colspan="2" class="Level-1-Header">Kontakt</td>
									</xsl:when>
									<xsl:when test="@codeListValue = '008'">
										<td colspan="2" class="Level-1-Header">Beställare</td>
									</xsl:when>
									<xsl:when test="@codeListValue = '009'">
										<td colspan="2" class="Level-1-Header">Bearbetare</td>
									</xsl:when>
									<xsl:when test="@codeListValue = '010'">
										<td colspan="2" class="Level-1-Header">Utgivare</td>
									</xsl:when>
									<xsl:when test="@codeListValue = 'informationManager'">
										<td colspan="2" class="Level-1-Header">Informationsförvaltare</td>
									</xsl:when>
									<xsl:when test="@codeListValue = 'actingInformationManager'">
										<td colspan="2" class="Level-1-Header">Tillförordnad Informationsförvaltare</td>
									</xsl:when>
									<xsl:when test="@codeListValue = 'datasetsManager'">
										<td colspan="2" class="Level-1-Header">Dataset förvaltare</td>
									</xsl:when>
									<xsl:when test="@codeListValue = 'manager'">
										<td colspan="2" class="Level-1-Header">Chef</td>
									</xsl:when>
									
									<xsl:otherwise>
										<td colspan="2" class="Level-1-Header">
											<xsl:value-of select="@codeListValue"/>
										</td>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</xsl:for-each>
					</xsl:for-each>
				</tr>
			</xsl:when>
			<xsl:when test="../extEleSrc">
				<tr>
					<td>Extension source:</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td>Contact information:</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:for-each select="gmd:CI_ResponsibleParty/gmd:role">
			<tr>
				<td class="Level-2-element">Ansvarsområde:</td>
				<td>
					<xsl:for-each select="gmd:CI_RoleCode">
						<xsl:choose>
							<xsl:when test="@codeListValue = 'resourceProvider'">tillhandahållare av resursen</xsl:when>
							<!--<xsl:when test="@codeListValue = 'originator'">förvaltare</xsl:when>-->
							<!--*-->
							<xsl:when test="@codeListValue = 'custodian'">förvaltare</xsl:when>
							<!--*custodian-->
							<xsl:when test="@codeListValue = 'owner'">Ansvarig</xsl:when>
							<xsl:when test="@codeListValue = 'user'">användare</xsl:when>
							<xsl:when test="@codeListValue = 'distributor'">distributör</xsl:when>
							<xsl:when test="@codeListValue = 'originator'">upphovsman</xsl:when>
							<xsl:when test="@codeListValue = 'pointOfContact'">Organisatorisk tillhörighet</xsl:when>
							<xsl:when test="@codeListValue = 'principalInvestigator'">Undersökningsledare</xsl:when>
							<xsl:when test="@codeListValue = 'processor'">Vidareförädlare</xsl:when>
							<xsl:when test="@codeListValue = 'publisher'">Utgivare</xsl:when>
							<xsl:when test="@codeListValue = 'author'">Upphovsman</xsl:when>
							<xsl:when test="@codeListValue = '101'">informationsförvaltare/designer</xsl:when>
							<xsl:when test="@codeListValue = '102'">teknisk förvaltare</xsl:when>
							<xsl:when test="@codeListValue = 'informationManager'">Informationsförvaltare</xsl:when>
							<xsl:when test="@codeListValue = 'actingInformationManager'">Tillförordnad Informationsförvaltare</xsl:when>
							<xsl:when test="@codeListValue = 'datasetsManager'">Dataset förvaltare</xsl:when>
							<xsl:when test="@codeListValue = 'manager'">Chef</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@codeListValue"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:CI_ResponsibleParty/gmd:individualName">
			<tr>
				<td class="Level-2-element">Person:</td>
				<td>
					<xsl:value-of select="gco:CharacterString/text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:CI_ResponsibleParty/gmd:organisationName">
			<tr>
				<td class="Level-2-element">Organisation:</td>
				<td>
					<xsl:value-of select="gco:CharacterString/text()"/>
				</td>
			</tr>
		</xsl:for-each>		
		<xsl:apply-templates select="gmd:CI_ResponsibleParty/gmd:contactInfo"/>
	</xsl:template>
	<!--end new added-->
	<!--Contact Information (B.3.2.2 CI_Contact - line387) -->
	<xsl:template match="gmd:CI_ResponsibleParty/gmd:contactInfo">
		<!--<DD>
        <DT>
        <FONT color="#0000AA">
        <B>Kontaktinformation:</B>
        </FONT>
        </DT>
        <DD>
        <DL>-->
		<xsl:apply-templates select="gmd:CI_Contact/gmd:phone"/>
		<xsl:apply-templates select="gmd:CI_Contact/gmd:address"/>
		<xsl:apply-templates select="gmd:CI_Contact/gmd:onlineResource"/>
		<!--</DL>
        </DD>
        </DD>-->
	</xsl:template>
	<!--Telephone Information (B.3.2.6 CI_Telephone - line407) -->
	<xsl:template match="gmd:CI_Contact/gmd:phone">
		<tr>
			<td class="Level-2-element">Telefonnummer:</td>
			<!--</DT>
            <DL>-->
			<xsl:for-each select="gmd:CI_Telephone/gmd:voice/gco:CharacterString">
				<!--<DT>
                <FONT color="#0000AA">
                <B>Voice:</B>
                </FONT>-->
				<td>
					<xsl:value-of select="."/>
				</td>
			</xsl:for-each>
		</tr>
		<!--<xsl:for-each select="faxNum">
        <tr>
        <td class="Level-2-element">Fax:<</td>
        <td><xsl:value-of select="."/></td>
        </tr>
        </xsl:for-each>-->
		<!--</DL>
        </DD>-->
	</xsl:template>
	<!--Address Information (B.3.2.1 CI_Address - line380) -->
	<xsl:template match="gmd:CI_Contact/gmd:address">
		<!--<DT>
        <FONT color="#0000AA">
        <B>Address:</B>
        </FONT>
        </DT>
        <DD>
        <DL>
        <xsl:for-each select="delPoint">
        <DT>
        <FONT color="#0000AA">
        <B>Delivery point:</B>
        </FONT>
        </DT>
        <pre>
        <xsl:attribute name="id">pre<xsl:value-of select="$preId"/><xsl:value-of select="position()"/></xsl:attribute>
        <xsl:value-of select="."/>
        </pre>
        <script type="text/javascript">fix('pre<xsl:value-of select="$preId"/><xsl:value-of select="position()"/>');</script>
        
        </xsl:for-each>
        <xsl:for-each select="city">
        <DT>
        <FONT color="#0000AA">
        <B>City:</B>
        </FONT>
        <xsl:value-of select="."/>
        </DT>
        </xsl:for-each>
        <xsl:for-each select="adminArea">
        <DT>
        <FONT color="#0000AA">
        <B>Administrative area:</B>
        </FONT>
        <xsl:value-of select="."/>
        </DT>
        </xsl:for-each>
        <xsl:for-each select="postCode">
        <DT>
        <FONT color="#0000AA">
        <B>Postal code:</B>
        </FONT>
        <xsl:value-of select="."/>
        </DT>
        </xsl:for-each>
        <xsl:for-each select="country">
        <DT>
        <FONT color="#0000AA">
        <B>Country:</B>
        </FONT>-->
		<!--2 letter country codes from ISO 3661-1, in alphabetical order by name -->
		<!--<xsl:choose>
        <xsl:when test="(. = 'af') or (. = 'AF')]">Afghanistan</xsl:when>
        <xsl:when test="(. = 'al') or (. = 'AL')]">Albania</xsl:when>
        <xsl:when test="(. = 'dz') or (. = 'DZ')]">Algeria</xsl:when>
        <xsl:when test="(. = 'as') or (. = 'AS')]">American Samoa</xsl:when>
        <xsl:when test="(. = 'ad') or (. = 'AD')]">Andorra</xsl:when>
        <xsl:when test="(. = 'ao') or (. = 'AO')]">Angola</xsl:when>
        <xsl:when test="(. = 'ai') or (. = 'AI')]">Anguilla</xsl:when>
        <xsl:when test="(. = 'aq') or (. = 'AQ')]">Antarctica</xsl:when>
        <xsl:when test="(. = 'ag') or (. = 'AG')]">Antigua and Barbuda</xsl:when>
        <xsl:when test="(. = 'ar') or (. = 'AR')]">Argentina</xsl:when>
        <xsl:when test="(. = 'am') or (. = 'AM')]">Armenia</xsl:when>
        <xsl:when test="(. = 'aw') or (. = 'AW')]">Aruba</xsl:when>
        <xsl:when test="(. = 'au') or (. = 'AU')]">Australia</xsl:when>
        <xsl:when test="(. = 'at') or (. = 'AT')]">Austria</xsl:when>
        <xsl:when test="(. = 'az') or (. = 'AZ')]">Azerbaijan</xsl:when>
        <xsl:when test="(. = 'bs') or (. = 'BS')]">Bahamas</xsl:when>
        <xsl:when test="(. = 'bh') or (. = 'BH')]">Bahrain</xsl:when>
        <xsl:when test="(. = 'bd') or (. = 'BD')]">Bangladesh</xsl:when>
        <xsl:when test="(. = 'bb') or (. = 'BB')]">Barbados</xsl:when>
        <xsl:when test="(. = 'by') or (. = 'BY')]">Belarus</xsl:when>
        <xsl:when test="(. = 'be') or (. = 'BE')]">Belgium</xsl:when>
        <xsl:when test="(. = 'bz') or (. = 'BZ')]">Belize</xsl:when>
        <xsl:when test="(. = 'bj') or (. = 'BJ')]">Benin</xsl:when>
        <xsl:when test="(. = 'bm') or (. = 'BM')]">Bermuda</xsl:when>
        <xsl:when test="(. = 'bt') or (. = 'BT')]">Bhutan</xsl:when>
        <xsl:when test="(. = 'bo') or (. = 'BO')]">Bolivia</xsl:when>
        <xsl:when test="(. = 'ba') or (. = 'BA')]">Bosnia and Herzegovina</xsl:when>
        <xsl:when test="(. = 'bw') or (. = 'BW')]">Botswana</xsl:when>
        <xsl:when test="(. = 'bv') or (. = 'BV')]">Bouvet Island</xsl:when>
        <xsl:when test="(. = 'br') or (. = 'BR')]">Brazil</xsl:when>
        <xsl:when test="(. = 'io') or (. = 'IO')]">British Indian Ocean Territory</xsl:when>
        <xsl:when test="(. = 'bn') or (. = 'BN')]">Brunei Darussalam</xsl:when>
        <xsl:when test="(. = 'bg') or (. = 'BG')]">Bulgaria</xsl:when>
        <xsl:when test="(. = 'bf') or (. = 'BF')]">Burkina Faso</xsl:when>
        <xsl:when test="(. = 'bi') or (. = 'BI')]">Burundi</xsl:when>
        <xsl:when test="(. = 'kh') or (. = 'KH')]">Cambodia</xsl:when>
        <xsl:when test="(. = 'cm') or (. = 'CM')]">Cameroon</xsl:when>
        <xsl:when test="(. = 'ca') or (. = 'CA')]">Canada</xsl:when>
        <xsl:when test="(. = 'cv') or (. = 'CV')]">Cape Verde</xsl:when>
        <xsl:when test="(. = 'ky') or (. = 'KY')]">Cayman Islands</xsl:when>
        <xsl:when test="(. = 'cf') or (. = 'CF')]">Central African Republic</xsl:when>
        <xsl:when test="(. = 'td') or (. = 'TD')]">Chad</xsl:when>
        <xsl:when test="(. = 'cl') or (. = 'CL')]">Chile</xsl:when>
        <xsl:when test="(. = 'cn') or (. = 'CN')]">China</xsl:when>
        <xsl:when test="(. = 'cx') or (. = 'CX')]">Christmas Island</xsl:when>
        <xsl:when test="(. = 'cc') or (. = 'CC')]">Cocos (Keeling) Islands</xsl:when>
        <xsl:when test="(. = 'co') or (. = 'CO')]">Colombia</xsl:when>
        <xsl:when test="(. = 'km') or (. = 'KM')]">Comoros</xsl:when>
        <xsl:when test="(. = 'cg') or (. = 'CG')]">Congo</xsl:when>
        <xsl:when test="(. = 'cd') or (. = 'CD')]">Congo, Democratic Republic of the</xsl:when>
        <xsl:when test="(. = 'ck') or (. = 'CK')]">Cook Islands</xsl:when>
        <xsl:when test="(. = 'cr') or (. = 'CR')]">Costa Rica</xsl:when>
        <xsl:when test="(. = 'ci') or (. = 'CI')]">Cote D'Ivoire</xsl:when>
        <xsl:when test="(. = 'hr') or (. = 'HR')]">Croatia</xsl:when>
        <xsl:when test="(. = 'cu') or (. = 'CU')]">Cuba</xsl:when>
        <xsl:when test="(. = 'cy') or (. = 'CY')]">Cyprus</xsl:when>
        <xsl:when test="(. = 'cz') or (. = 'CZ')]">Czech Republic</xsl:when>
        <xsl:when test="(. = 'dk') or (. = 'DK')]">Denmark</xsl:when>
        <xsl:when test="(. = 'dj') or (. = 'DJ')]">Djibouti</xsl:when>
        <xsl:when test="(. = 'dm') or (. = 'DM')]">Dominica</xsl:when>
        <xsl:when test="(. = 'do') or (. = 'DO')]">Dominican Republic</xsl:when>
        <xsl:when test="(. = 'tp') or (. = 'TP')]">East Timor</xsl:when>
        <xsl:when test="(. = 'ec') or (. = 'EC')]">Ecuador</xsl:when>
        <xsl:when test="(. = 'eg') or (. = 'EG')]">Egypt</xsl:when>
        <xsl:when test="(. = 'sv') or (. = 'SV')]">El Salvador</xsl:when>
        <xsl:when test="(. = 'gq') or (. = 'GQ')]">Equatorial Guinea</xsl:when>
        <xsl:when test="(. = 'er') or (. = 'ER')]">Eritrea</xsl:when>
        <xsl:when test="(. = 'ee') or (. = 'EE')]">Estonia</xsl:when>
        <xsl:when test="(. = 'et') or (. = 'ET')]">Ethiopia</xsl:when>
        <xsl:when test="(. = 'fk') or (. = 'FK')]">Falkland Islands (Malvinias)</xsl:when>
        <xsl:when test="(. = 'fo') or (. = 'FO')]">Faroe Islands</xsl:when>
        <xsl:when test="(. = 'fj') or (. = 'FJ')]">Fiji</xsl:when>
        <xsl:when test="(. = 'fi') or (. = 'FI')]">Finland</xsl:when>
        <xsl:when test="(. = 'fr') or (. = 'FR')]">France</xsl:when>
        <xsl:when test="(. = 'gf') or (. = 'GF')]">French Guiana</xsl:when>
        <xsl:when test="(. = 'pf') or (. = 'PF')]">French Polynesia</xsl:when>
        <xsl:when test="(. = 'tf') or (. = 'TF')]">French Southern Territories</xsl:when>
        <xsl:when test="(. = 'ga') or (. = 'GA')]">Gabon</xsl:when>
        <xsl:when test="(. = 'gm') or (. = 'GM')]">Gambia</xsl:when>
        <xsl:when test="(. = 'ge') or (. = 'GE')]">Georgia</xsl:when>
        <xsl:when test="(. = 'de') or (. = 'DE')]">Germany</xsl:when>
        <xsl:when test="(. = 'gh') or (. = 'GH')]">Ghana</xsl:when>
        <xsl:when test="(. = 'gi') or (. = 'GI')]">Gibraltar</xsl:when>
        <xsl:when test="(. = 'gr') or (. = 'GR')]">Greece</xsl:when>
        <xsl:when test="(. = 'gl') or (. = 'GL')]">Greenland</xsl:when>
        <xsl:when test="(. = 'gd') or (. = 'GD')]">Grenada</xsl:when>
        <xsl:when test="(. = 'gp') or (. = 'GP')]">Guadeloupe</xsl:when>
        <xsl:when test="(. = 'gu') or (. = 'GU')]">Guam</xsl:when>
        <xsl:when test="(. = 'gt') or (. = 'GT')]">Guatemala</xsl:when>
        <xsl:when test="(. = 'gn') or (. = 'GN')]">Guinea</xsl:when>
        <xsl:when test="(. = 'gw') or (. = 'GW')]">Guinea-Bissau</xsl:when>
        <xsl:when test="(. = 'gy') or (. = 'GY')]">Guyana</xsl:when>
        <xsl:when test="(. = 'ht') or (. = 'HT')]">Haiti</xsl:when>
        <xsl:when test="(. = 'hm') or (. = 'HM')]">Heard Island and McDonald Islands</xsl:when>
        <xsl:when test="(. = 'va') or (. = 'VA')]">Holy See / Vatican City State</xsl:when>
        <xsl:when test="(. = 'hn') or (. = 'HN')]">Honduras</xsl:when>
        <xsl:when test="(. = 'hk') or (. = 'HK')]">Hong Kong</xsl:when>
        <xsl:when test="(. = 'hu') or (. = 'HU')]">Hungary</xsl:when>
        <xsl:when test="(. = 'is') or (. = 'IS')]">Iceland</xsl:when>
        <xsl:when test="(. = 'in') or (. = 'IN')]">India</xsl:when>
        <xsl:when test="(. = 'id') or (. = 'ID')]">Indonesia</xsl:when>
        <xsl:when test="(. = 'ir') or (. = 'IR')]">Iran, Islamic Republic of</xsl:when>
        <xsl:when test="(. = 'iq') or (. = 'IQ')]">Iraq</xsl:when>
        <xsl:when test="(. = 'ie') or (. = 'IE')]">Ireland</xsl:when>
        <xsl:when test="(. = 'il') or (. = 'IL')]">Israel</xsl:when>
        <xsl:when test="(. = 'it') or (. = 'IT')]">Italy</xsl:when>
        <xsl:when test="(. = 'jm') or (. = 'JM')]">Jamaica</xsl:when>
        <xsl:when test="(. = 'jp') or (. = 'JP')]">Japan</xsl:when>
        <xsl:when test="(. = 'jo') or (. = 'JO')]">Jordan</xsl:when>
        <xsl:when test="(. = 'kz') or (. = 'KZ')]">Kazakstan</xsl:when>
        <xsl:when test="(. = 'ke') or (. = 'KE')]">Kenya</xsl:when>
        <xsl:when test="(. = 'ki') or (. = 'KI')]">Kiribati</xsl:when>
        <xsl:when test="(. = 'kp') or (. = 'KP')]">Korea, Democratic People's Republic of</xsl:when>
        <xsl:when test="(. = 'kr') or (. = 'KR')]">Korea, Republic of</xsl:when>
        <xsl:when test="(. = 'kw') or (. = 'KW')]">Kuwait</xsl:when>
        <xsl:when test="(. = 'kg') or (. = 'KG')]">Kyrgyzstan</xsl:when>
        <xsl:when test="(. = 'la') or (. = 'LA')]">Lao People's Demoratic Republic</xsl:when>
        <xsl:when test="(. = 'lv') or (. = 'LV')]">Latvia</xsl:when>
        <xsl:when test="(. = 'lb') or (. = 'LB')]">Lebanon</xsl:when>
        <xsl:when test="(. = 'ls') or (. = 'LS')]">Lesotho</xsl:when>
        <xsl:when test="(. = 'lr') or (. = 'LR')]">Liberia</xsl:when>
        <xsl:when test="(. = 'ly') or (. = 'LY')]">Libyan Arab Jamahiriya</xsl:when>
        <xsl:when test="(. = 'li') or (. = 'LI')]">Liechtenstein</xsl:when>
        <xsl:when test="(. = 'lt') or (. = 'LT')]">Lithuania</xsl:when>
        <xsl:when test="(. = 'lu') or (. = 'LU')]">Luxembourg</xsl:when>
        <xsl:when test="(. = 'mo') or (. = 'MO')]">Macau</xsl:when>
        <xsl:when test="(. = 'mk') or (. = 'MK')]">Macedonia, The Former Yugoslav Republic of</xsl:when>
        <xsl:when test="(. = 'mg') or (. = 'MG')]">Madagascar</xsl:when>
        <xsl:when test="(. = 'mw') or (. = 'MW')]">Malawi</xsl:when>
        <xsl:when test="(. = 'my') or (. = 'MY')]">Malaysia</xsl:when>
        <xsl:when test="(. = 'mv') or (. = 'MV')]">Maldives</xsl:when>
        <xsl:when test="(. = 'ml') or (. = 'ML')]">Mali</xsl:when>
        <xsl:when test="(. = 'mt') or (. = 'MT')]">Malta</xsl:when>
        <xsl:when test="(. = 'mh') or (. = 'MH')]">Marshall Islands</xsl:when>
        <xsl:when test="(. = 'mq') or (. = 'MQ')]">Martinique</xsl:when>
        <xsl:when test="(. = 'mr') or (. = 'MR')]">Mauritania</xsl:when>
        <xsl:when test="(. = 'mu') or (. = 'MU')]">Mauritius</xsl:when>
        <xsl:when test="(. = 'yt') or (. = 'YT')]">Mayotte</xsl:when>
        <xsl:when test="(. = 'mx') or (. = 'MX')]">Mexico</xsl:when>
        <xsl:when test="(. = 'fm') or (. = 'FM')]">Micronesia, Federated States of</xsl:when>
        <xsl:when test="(. = 'md') or (. = 'MD')]">Moldova, Republic of</xsl:when>
        <xsl:when test="(. = 'mc') or (. = 'MC')]">Monaco</xsl:when>
        <xsl:when test="(. = 'mn') or (. = 'MN')]">Mongolia</xsl:when>
        <xsl:when test="(. = 'ms') or (. = 'MS')]">Montserrat</xsl:when>
        <xsl:when test="(. = 'ma') or (. = 'MA')]">Morocco</xsl:when>
        <xsl:when test="(. = 'mz') or (. = 'MZ')]">Mozambique</xsl:when>
        <xsl:when test="(. = 'mm') or (. = 'MM')]">Myanmar</xsl:when>
        <xsl:when test="(. = 'na') or (. = 'NA')]">Namibia</xsl:when>
        <xsl:when test="(. = 'nr') or (. = 'NR')]">Nauru</xsl:when>
        <xsl:when test="(. = 'np') or (. = 'NP')]">Nepal</xsl:when>
        <xsl:when test="(. = 'nl') or (. = 'NL')]">Netherlands</xsl:when>
        <xsl:when test="(. = 'an') or (. = 'AN')]">Netherlands Antilles</xsl:when>
        <xsl:when test="(. = 'nc') or (. = 'NC')]">New Caledonia</xsl:when>
        <xsl:when test="(. = 'nz') or (. = 'NZ')]">New Zealand</xsl:when>
        <xsl:when test="(. = 'ni') or (. = 'NI')]">Nicaragua</xsl:when>
        <xsl:when test="(. = 'ne') or (. = 'NE')]">Niger</xsl:when>
        <xsl:when test="(. = 'ng') or (. = 'NG')]">Nigeria</xsl:when>
        <xsl:when test="(. = 'nu') or (. = 'NU')]">Niue</xsl:when>
        <xsl:when test="(. = 'nf') or (. = 'NF')]">Norfolk Island</xsl:when>
        <xsl:when test="(. = 'mp') or (. = 'MP')]">Northern Mariana Islands</xsl:when>
        <xsl:when test="(. = 'no') or (. = 'NO')]">Norway</xsl:when>
        <xsl:when test="(. = 'om') or (. = 'OM')]">Oman</xsl:when>
        <xsl:when test="(. = 'pk') or (. = 'PK')]">Pakistan</xsl:when>
        <xsl:when test="(. = 'pw') or (. = 'PW')]">Palau</xsl:when>
        <xsl:when test="(. = 'ps') or (. = 'PS')]">Palestinian Territory, Occupied</xsl:when>
        <xsl:when test="(. = 'pa') or (. = 'PA')]">Panama</xsl:when>
        <xsl:when test="(. = 'pg') or (. = 'PG')]">Papua New Guinea</xsl:when>
        <xsl:when test="(. = 'py') or (. = 'PY')]">Paraguay</xsl:when>
        <xsl:when test="(. = 'pe') or (. = 'PE')]">Peru</xsl:when>
        <xsl:when test="(. = 'ph') or (. = 'PH')]">Phillippines</xsl:when>
        <xsl:when test="(. = 'pn') or (. = 'PN')]">Pitcairn</xsl:when>
        <xsl:when test="(. = 'pl') or (. = 'PL')]">Poland</xsl:when>
        <xsl:when test="(. = 'pt') or (. = 'PT')]">Portugal</xsl:when>
        <xsl:when test="(. = 'pr') or (. = 'PR')]">Puerto Rico</xsl:when>
        <xsl:when test="(. = 'qa') or (. = 'QA')]">Qatar</xsl:when>
        <xsl:when test="(. = 're') or (. = 'RE')]">Reunion</xsl:when>
        <xsl:when test="(. = 'ro') or (. = 'RO')]">Romania</xsl:when>
        <xsl:when test="(. = 'ru') or (. = 'RU')]">Russian Federation</xsl:when>
        <xsl:when test="(. = 'rw') or (. = 'RW')]">Rwanda</xsl:when>
        <xsl:when test="(. = 'sh') or (. = 'SH')]">Saint Helena</xsl:when>
        <xsl:when test="(. = 'kn') or (. = 'KN')]">Saint Kitts and Nevis</xsl:when>
        <xsl:when test="(. = 'lc') or (. = 'LC')]">Saint Lucia</xsl:when>
        <xsl:when test="(. = 'pm') or (. = 'PM')]">Saint Pierre and Miquelon</xsl:when>
        <xsl:when test="(. = 'vc') or (. = 'VC')]">Saint Vincent and the Grenadines</xsl:when>
        <xsl:when test="(. = 'ws') or (. = 'WS')]">Samoa</xsl:when>
        <xsl:when test="(. = 'sm') or (. = 'SM')]">San Marino</xsl:when>
        <xsl:when test="(. = 'st') or (. = 'ST')]">Sao Tome and Principe</xsl:when>
        <xsl:when test="(. = 'sa') or (. = 'SA')]">Saudi Arabia</xsl:when>
        <xsl:when test="(. = 'sn') or (. = 'SN')]">Senegal</xsl:when>
        <xsl:when test="(. = 'sc') or (. = 'SC')]">Seychelles</xsl:when>
        <xsl:when test="(. = 'sl') or (. = 'SL')]">Sierra Leone</xsl:when>
        <xsl:when test="(. = 'sg') or (. = 'SG')]">Singapore</xsl:when>
        <xsl:when test="(. = 'sk') or (. = 'SK')]">Slovakia</xsl:when>
        <xsl:when test="(. = 'si') or (. = 'SI')]">Slovenia</xsl:when>
        <xsl:when test="(. = 'sb') or (. = 'SB')]">Solomon Islands</xsl:when>
        <xsl:when test="(. = 'so') or (. = 'S0')]">Somalia</xsl:when>
        <xsl:when test="(. = 'za') or (. = 'ZA')]">South Africa</xsl:when>
        <xsl:when test="(. = 'gs') or (. = 'GS')]">South Georgia and the South Sandwich Islands</xsl:when>
        <xsl:when test="(. = 'es') or (. = 'ES')]">Spain</xsl:when>
        <xsl:when test="(. = 'lk') or (. = 'LK')]">Sri Lanka</xsl:when>
        <xsl:when test="(. = 'sd') or (. = 'SD')]">Sudan</xsl:when>
        <xsl:when test="(. = 'sr') or (. = 'SR')]">Suriname</xsl:when>
        <xsl:when test="(. = 'sj') or (. = 'SJ')]">Svalbard and Jan Mayen</xsl:when>
        <xsl:when test="(. = 'sz') or (. = 'SZ')]">Swaziland</xsl:when>
        <xsl:when test="(. = 'se') or (. = 'SE')]">Sweden</xsl:when>
        <xsl:when test="(. = 'ch') or (. = 'CH')]">Switzerland</xsl:when>
        <xsl:when test="(. = 'sy') or (. = 'SY')]">Syrian Arab Republic</xsl:when>
        <xsl:when test="(. = 'tw') or (. = 'TW')]">Taiwan, Province of China</xsl:when>
        <xsl:when test="(. = 'tj') or (. = 'TJ')]">Tajikistan</xsl:when>
        <xsl:when test="(. = 'tz') or (. = 'TZ')]">Tanzania, United Republic of</xsl:when>
        <xsl:when test="(. = 'th') or (. = 'TH')]">Thailand</xsl:when>
        <xsl:when test="(. = 'tg') or (. = 'TG')]">Togo</xsl:when>
        <xsl:when test="(. = 'tk') or (. = 'TK')]">Tokelau</xsl:when>
        <xsl:when test="(. = 'to') or (. = 'TO')]">Tonga</xsl:when>
        <xsl:when test="(. = 'tt') or (. = 'TT')]">Trinidad and Tobago</xsl:when>
        <xsl:when test="(. = 'tn') or (. = 'TN')]">Tunisia</xsl:when>
        <xsl:when test="(. = 'tr') or (. = 'TR')]">Turkey</xsl:when>
        <xsl:when test="(. = 'tm') or (. = 'TM')]">Turkmenistan</xsl:when>
        <xsl:when test="(. = 'tc') or (. = 'TC')]">Turks and Caicos Islands</xsl:when>
        <xsl:when test="(. = 'tv') or (. = 'TV')]">Tuvalu</xsl:when>
        <xsl:when test="(. = 'ug') or (. = 'UG')]">Uganda</xsl:when>
        <xsl:when test="(. = 'ua') or (. = 'UA')]">Ukraine</xsl:when>
        <xsl:when test="(. = 'ae') or (. = 'AE')]">United Arab Emirates</xsl:when>
        <xsl:when test="(. = 'gb') or (. = 'GB')]">United Kingdom</xsl:when>
        <xsl:when test="(. = 'us') or (. = 'US')]">United States</xsl:when>
        <xsl:when test="(. = 'um') or (. = 'UM')]">United States Minor Outlying Islands</xsl:when>
        <xsl:when test="(. = 'uy') or (. = 'UY')]">Uruguay</xsl:when>
        <xsl:when test="(. = 'uz') or (. = 'UZ')]">Uzbekistan</xsl:when>
        <xsl:when test="(. = 'vu') or (. = 'VU')]">Vanuatu</xsl:when>
        <xsl:when test="(. = 've') or (. = 'VE')]">Venezuela</xsl:when>
        <xsl:when test="(. = 'vn') or (. = 'VN')]">Viet Nam</xsl:when>
        <xsl:when test="(. = 'vg') or (. = 'VG')]">Virgin Islands, British</xsl:when>
        <xsl:when test="(. = 'vi') or (. = 'VI')]">Virgin Islands, U.S.</xsl:when>
        <xsl:when test="(. = 'wf') or (. = 'WF')]">Wallis and Futuna</xsl:when>
        <xsl:when test="(. = 'eh') or (. = 'EH')]">Western Sahara</xsl:when>
        <xsl:when test="(. = 'ye') or (. = 'YE')]">Yemen</xsl:when>
        <xsl:when test="(. = 'yu') or (. = 'YU')]">Yugoslavia</xsl:when>
        <xsl:when test="(. = 'zm') or (. = 'ZM')]">Zambia</xsl:when>
        <xsl:when test="(. = 'zw') or (. = 'ZW')]">Zimbabwe</xsl:when>
        <xsl:otherwise>
        <xsl:value-of select="."/>
        </xsl:otherwise>
        </xsl:choose>
        </DT>
        </xsl:for-each>-->
		<xsl:for-each select="gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString">
			<tr>
				<td class="Level-2-element">Epost:</td>
				<td>
					<a>
						<xsl:attribute name="href">
                            mailto:
                            <xsl:value-of select="text()"/></xsl:attribute>
						<xsl:value-of select="text()"/>
					</a>
				</td>
			</tr>
		</xsl:for-each>
		<!--</DL>
        </DD>-->
	</xsl:template>
	<!--Online Resource Information (B.3.2.4 CI_OnLineResource - line396) -->
	<xsl:template match="gmd:CI_Contact/gmd:onlineResource | gmd:MD_DigitalTransferOptions/gmd:onLine | extOnRes">
		<xsl:choose>
			<xsl:when test="../gmd:onLine">
				<tr>
					<!--<td colspan = "2" class = "Level-2-Header">Uppkopplad källa:</td>-->
					<td colspan="2" class="Level-2-Header">Onlinekälla:</td>
				</tr>
			</xsl:when>
			<xsl:when test="../extOnRes">
				<tr>
					<td colspan="2" class="Level-2-Header">Extension online resource:</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td colspan="2" class="Level-2-Header">Uppkopplad resurs:</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:for-each select="gmd:CI_OnlineResource/gmd:name/gco:CharacterString">
			<tr>
				<td class="Level-2-element">Namn på resurs:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:CI_OnlineResource/gmd:linkage">
			<tr>
				<xsl:if test="@Sync = 'TRUE'">
					<span class="s"><![CDATA[ ]]></span>
				</xsl:if>
				<td class="Level-2-element">Adress för uppkoppling:</td>
				<td>
					<a target="_blank" itemprop="url" property="dcat:accessURL">						
						<xsl:attribute name="href"><xsl:choose><xsl:when test="starts-with(gmd:URL/text(),'http')"><xsl:value-of select="gmd:URL/text()"/></xsl:when><xsl:otherwise>http://<xsl:value-of select="gmd:URL/text()"/></xsl:otherwise></xsl:choose></xsl:attribute>
						<xsl:value-of select="gmd:URL/text()"/>
					</a>
				</td>
			</tr>
		</xsl:for-each>
		<!--<xsl:for-each select="protocol">
        <tr>
        <xsl:if test="@Sync = 'TRUE']">
        <span class="s"></span>
        </xsl:if>
        <td class="Level-2-element">Regelverk för uppkoppling:</td>
        <td>
        <xsl:value-of select="."/>
        </td>
        </tr>
        </xsl:for-each>
        -->
		<xsl:for-each select="gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString">
			<tr>
				<td class="Level-2-element">Protokoll:</td>
				<td>
					<xsl:value-of select="."/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:CI_OnlineResource/gmd:function">
			<tr>
				<td class="Level-2-element">Funktion som kan utföras:</td>
				<td>
					<xsl:for-each select="OnFunctCd">
						<xsl:choose>
							<xsl:when test="@value = '001'">nedladdning</xsl:when>
							<xsl:when test="@value = '002'">information</xsl:when>
							<xsl:when test="@value = '003'">ej uppkopplad åtkomst</xsl:when>
							<xsl:when test="@value = '004'">order</xsl:when>
							<xsl:when test="@value = '005'">sökning</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="@value"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</td>
			</tr>
		</xsl:for-each>
		<!--do uncomment 02-11-10 -->
		<xsl:for-each select="gmd:CI_OnlineResource/gmd:description/gco:CharacterString">
			<tr>
				<td class="Level-2-element">Beskrivning:</td>
				<td>
					<xsl:value-of select="text()"/>
					<!--<xsl:choose>
        <xsl:when test=". = '001']">Uppkopplade kartor och datamängder</xsl:when>
        <xsl:when test=". = '002']">Nedladdningsbara data</xsl:when>
        <xsl:when test=". = '003']">Ej uppkopplade Data</xsl:when>
        <xsl:when test=". = '004']">Statiska kartbilder</xsl:when>
        <xsl:when test=". = '005']">Andra dokument</xsl:when>
        <xsl:when test=". = '006']">Applikationer</xsl:when>
        <xsl:when test=". = '007']">Geographic Services</xsl:when>
        <xsl:when test=". = '008']">Clearinghouses</xsl:when>
        <xsl:when test=". = '009']">Kartfiler</xsl:when>
        <xsl:when test=". = '010']">Geographic Activities</xsl:when>
        <xsl:otherwise>
        <xsl:value-of select="."/>
        </xsl:otherwise>
        </xsl:choose>-->
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--Series Information (B.3.2.5 CI_Series - line403) -->
	<xsl:template match="gmd:series">
		<!--<DD>-->
		<!--<DT>
        <FONT color="#0000AA">
        <B>Series:</B>
        </FONT>
        </DT>-->
		<!--<DD>
        <DL>-->
		<xsl:for-each select="gmd:CI_Series/gmd:name">
			<tr>
				<!--<td class = "Level-1-element">Produkt:</td>-->
				<td class="Level-1-element">Serienamn:</td>
				<td>
					<xsl:value-of select="gco:CharacterString"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="issId">
			<tr>
				<td class="Level-1-element">Issue:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="artPage">
			<tr>
				<td class="Level-1-element">Pages:</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<!--</DL>
        </DD>-->
		<!--</DD>-->
	</xsl:template>
	<!--EXTENT INFORMATION -->
	<!--Extent Information (B.3.1 EX_Extent - line334) -->
	<xsl:template match="gmd:MD_DataIdentification/gmd:extent |  srv:SV_ServiceIdentification/srv:extent | gmd:extent | srcExt ">
		<xsl:choose>
			<xsl:when test=".">
				<xsl:for-each select=".">
					<tr>
						<xsl:for-each select="gmd:EX_Extent/gmd:description/gco:CharacterString">
							<tr>
								<td class="Level-1-element">Beskriving av utsträckning</td>
								<td>
									<xsl:value-of select="."/>
								</td>
							</tr>
						</xsl:for-each>
						<xsl:for-each select="gmd:EX_Extent/gmd:geographicElement">
							<xsl:apply-templates select="gmd:EX_GeographicDescription"/>
							<!-- Need to fix how to show map. For now commenting out gmd:EX_BoundingPolygon template-->
							<!-- <xsl:apply-templates select="gmd:EX_BoundingPolygon"/> -->
							<xsl:apply-templates select="gmd:EX_GeographicBoundingBox"/>
						</xsl:for-each>
						<xsl:for-each select="gmd:EX_Extent/gmd:temporalElement">
							<xsl:apply-templates select="gmd:temporalElement/gmd:EX_TemporalExtent"/>
							<xsl:apply-templates select="gmd:EX_TemporalExtent/gmd:extent"/>
						</xsl:for-each>
						<xsl:apply-templates select="gmd:EX_Extent/gmd:verticalElement"/>
					</tr>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--<xsl:template match = "exTypeCode">-->
	<xsl:template match="gmd:MD_Identifier/gmd:code">
		<xsl:for-each select="gmd:code">
			<tr>
				<td class="Level-2-element">Utsträckning innesluter resurs:</td>
				<td>
					<xsl:choose>
						<xsl:when test="gco:CharacterString/text() = '1'">Ja</xsl:when>
						<xsl:when test="gco:CharacterString/text() = '0'">Nej</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="gco:CharacterString/text()"/>
						</xsl:otherwise>
					</xsl:choose>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--Bounding Polygon Information (B.3.1.1 EX_BoundingPolygon - line341) -->
	<!--<xsl:template match = "gmd:Ex_geographicExtent/gmd:EX_BoundingPolygon">-->
	<xsl:template match="gmd:EX_BoundingPolygon">
		<tr>
			<!--<td colspan="2" class="Level-3-Header">Bounding polygon:</td>-->
			<td colspan="2" class="Level-2-Header">Omskrivande polygon:</td>
		</tr>
		<xsl:for-each select="gmd:polygon/gml:Polygon/gml:exterior/gml:Ring/gml:curveMember/gml:LineString">
			<xsl:for-each select="gml:coordinates">
				<tr>
					<td class="Level-3-element">Koordinater:</td>
					<td>
						<xsl:value-of select="text()"/>
					</td>
				</tr>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	<!--Bounding Box Information (B.3.1.1 EX_GeographicBoundingBox - line343) -->
	<!--<xsl:template match = "geoBox | gmd:Ex_geographicExtent/gmd:EX_GeographicBoundingBox">-->
	<xsl:template match="geoBox | gmd:EX_GeographicBoundingBox">
		<xsl:for-each select="gmd:westBoundLongitude/gco:Decimal">
			<tr>
				<td class="Level-1-element">Västligaste longitud</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:eastBoundLongitude/gco:Decimal">
			<tr>
				<td class="Level-1-element">Östligaste longitud</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:southBoundLatitude/gco:Decimal">
			<tr>
				<td class="Level-1-element">Sydligaste latitud</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:northBoundLatitude/gco:Decimal">
			<tr>
				<td class="Level-1-element">Nordligaste latitud</td>
				<td>
					<xsl:value-of select="text()"/>
				</td>
			</tr>
		</xsl:for-each>
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
		<!-- <xsl:if test="$west != 0 and $north != 0 and $east != 0 and $south != 0">
			<xsl:copy-of select="gn-fn-render:bbox(
                            xs:double(gmd:westBoundLongitude/gco:Decimal),
                            xs:double(gmd:southBoundLatitude/gco:Decimal),
                            xs:double(gmd:eastBoundLongitude/gco:Decimal),
                            xs:double(gmd:northBoundLatitude/gco:Decimal))"/>
		</xsl:if> -->
	</xsl:template>
	<!--Geographic Description Information (B.3.1.1 EX_GeographicDescription - line348) -->
	<!--<xsl:template match = "gmd:Ex_geographicExtent/gmd:EX_GeographicDescription | GeoDesc">-->
	<xsl:template match="gmd:EX_GeographicDescription | GeoDesc">
		<xsl:apply-templates select="gmd:geographicIdentifier"/>
	</xsl:template>
	<!--Temporal Extent Information (B.3.1.2 EX_TemporalExtent - line350) -->
	<!--<xsl:template match="TempExtent">-->
	<!--<DD>
    <DT>
    <FONT color="#0000AA">
    <B>Temporal extent:</B>
    </FONT>
    </DT>
    <xsl:apply-templates select="exTemp/TM_GeometricPrimitive"/>
    </DD> -->
	<!--</xsl:template>-->
	<!--temporal extent Information from ISO 19103 as defined is DTD -->
	<xsl:template match="gmd:extent">
		<xsl:for-each select="gml:TimePeriod">
			<tr>
				<td class="Level-1-element">Temporal Utstäckning</td>
				<td>
					<xsl:value-of select="gml:beginPosition"/><xsl:text>&#160;</xsl:text><xsl:value-of select="gml:endPosition"/>
				</td>
			</tr>
			<!-- <xsl:for-each select="gml:beginPosition">
				<tr>
					<td class="Level-3-element">Startdatum:</td>
					<td>
						<xsl:value-of select="text()"/>
					</td>
				</tr>
			</xsl:for-each>
			<xsl:for-each select="gml:endPosition">
				<tr>
					<td class="Level-3-element">Slutdatum::</td>
					<td>
						<xsl:value-of select="text()"/>
					</td>
				</tr>
			</xsl:for-each>
			-->
		</xsl:for-each>
	</xsl:template>
	<!--Spatial Temporal Extent Information (B.3.1.2 EX_SpatialTemporalExtent - line352) -->
	<!--<xsl:template match="(SpatTempEx | TempExtent)">-->
	<xsl:template match="exTemp | SpatTempEx">
		<!--<xsl:template match="exTemp">-->
		<tr>
			<td colspan="2" class="Level-2-Header">Spatial and temporal extent:</td>
		</tr>
		<!--<xsl:for-each select="exTemp">-->
		<xsl:for-each select=".">
			<tr>
				<td colspan="2" class="Level-2-element">Används ej efter:</td>
			</tr>
			<xsl:apply-templates select="TM_GeometricPrimitive"/>
		</xsl:for-each>
		<xsl:for-each select="exSpat">
			<tr>
				<td class="Level-1-element">Spatial extent:</td>
			</tr>
			<xsl:apply-templates select="BoundPoly"/>
			<xsl:apply-templates select="GeoBndBox"/>
			<xsl:apply-templates select="GeoDesc"/>
		</xsl:for-each>
	</xsl:template>
	<!--Vertical Extent Information (B.3.1.3 EX_VerticalExtent - line354) -->
	<!--changed at : 02-11-10-->
	<xsl:template match="gmd:verticalElement/gmd:EX_VerticalExtent">
		<xsl:for-each select="gmd:minimumValue">
			<tr>
				<td class="Level-1-element">
					<xsl:if test="@Sync = 'TRUE'">
						<span class="s">*</span>
					</xsl:if>
                    Lägsta höjd
                </td>
				<td>
					<xsl:value-of select="gco:Real/text()"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="gmd:maximumValue">
			<tr>
				<td class="Level-1-element">
					<xsl:if test="@Sync = 'TRUE'">
						<span class="s">*</span>
					</xsl:if>
                    Högsta höjd
                </td>
				<td>
					<xsl:value-of select="gco:Real/text()"/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!--ESRI EXTENDED ELEMENTS -->
	<!--BINARY INFORMATION -->
	<!--Thumbnail -->
	<xsl:template match="/metadata/Binary/Thumbnail/img[@src]">
		<!--
        <img id="thumbnail" align="absmiddle" style="width:217px; border:2px outset #ffffff; position:relative;">
            <xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
        </img>
-->
	</xsl:template>
	<!--Enclosures -->
	<!--<xsl:template match="Binary">
    <A name="Binary_Enclosures">
    <A name="Binary_Enclosures">
    
    </A>
    <DL>
    <DT>
    <FONT color="#0000AA" size="3">
    <B>Binary Enclosures:</B>
    </FONT>
    </DT>
    <br />
    <br />
    <DD>
    <DL>
    <xsl:for-each select="Thumbnail">
    <DT>
    <FONT color="#0000AA">
    <B>Thumbnail:</B>
    </FONT>
    </DT>
    <DD>
    <DL>
    <xsl:for-each select="img">
    <DT>
    <FONT color="#0000AA">
    <B>Enclosure type:</B>
    </FONT> Picture</DT>
    <IMG ID="thumbnail" ALIGN="absmiddle" style="height:144; 
    border:'2 outset #ffffff'; position:relative">
    <xsl:attribute name="SRC"><xsl:value-of select="@src"/></xsl:attribute>
    </IMG>
    </xsl:for-each>
    </DL>
    </DD>
    <br />
    </xsl:for-each>
    <xsl:for-each select="Enclosure">
    <DT>
    <FONT color="#006400">
    <B>Enclosure:</B>
    </FONT>
    </DT>
    <DD>
    <DL>
    <xsl:for-each select="*/@EsriPropertyType">
    <DT>
    <FONT color="#006400">
    <B>Enclosure type:</B>
    </FONT>
    <xsl:value-of select="."/>
    </DT>
    </xsl:for-each>
    <xsl:for-each select="img">
    <DT>
    <FONT color="#006400">
    <B>Enclosure type:</B>
    </FONT> Image</DT>
    </xsl:for-each>
    <xsl:for-each select="*/@OriginalFileName">
    <DT>
    <FONT color="#006400">
    <B>Original file name:</B>
    </FONT>
    <xsl:value-of select="."/>
    </DT>
    </xsl:for-each>
    <xsl:for-each select="Descript">
    <DT>
    <FONT color="#006400">
    <B>Description of enclosure:</B>
    </FONT>
    <xsl:value-of select="."/>
    </DT>
    </xsl:for-each>
    <xsl:for-each select="img">
    <DD>
    <br />
    <IMG style="height:144; border:'2 outset #ffffff'; position:relative">
    <xsl:attribute name="TITLE"><xsl:value-of select="img/@OriginalFileName"/></xsl:attribute>
    <xsl:attribute name="SRC"><xsl:value-of select="@src"/></xsl:attribute>
    </IMG>
    </DD>
    </xsl:for-each>
    </DL>
    </DD>
    <br />
    </xsl:for-each>
    </DL>
    </DD>
    </DL>
    <a HREF="#Top">Back to Top</a>
    </xsl:template> -->
	<!--<xsl:template match="FC_FeatureCatalog"> -->
	<xsl:template match="FC_FeatureCatalog">
		<xsl:if test="name[text()] | versionDate[text()] | catFetTypes[text()]">
			<!--<tr>
            <td colspan="2" class="Level-1-Header">Objekttypskatalog:</td>
            </tr>
            <xsl:if test="name[text()]">
            <tr>
            <td class="Level-2-element">Namn:</td>
            <td>
            <xsl:value-of select="name"/>
            </td>
            </tr>
            </xsl:if>
            
            <xsl:if test="versionDate[text()]">
            <tr>
            <td class="Level-2-element">Datum:</td>
            <td>
            <xsl:value-of select="versionDate"/>
            </td>
            </tr>
            </xsl:if>
            <xsl:if test="catFetTypes[text()]">
            <tr>
            <td class="Level-2-element">Beskrivning:</td>
            <td>
            <xsl:value-of select="catFetTypes"/>
            </td>
            </tr>
            </xsl:if>
            -->
		</xsl:if>
		<xsl:apply-templates select="FC_FeatureType"/>
	</xsl:template>
	<xsl:template match="FC_FeatureType">
		<xsl:call-template name="SubMenu">
			<xsl:with-param name="strCSS">Parent IsVisible</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="FC_FeatureAttribute">
		<tr>
			<td class="subtabledata">
				<xsl:value-of select="name"/>
			</td>
			<td class="subtabledata">
				<xsl:value-of select="code"/>
			</td>
			<td class="subtabledata">
				<xsl:value-of select="valueDataType"/>
			</td>
			<td class="subtabledata">
				<xsl:value-of select="definition"/>
			</td>
			<!--ej med i SKB    
            <td class="subtabledata">
            <xsl:value-of select="valueDomain"/>
            </td>-->
		</tr>
		<xsl:if test="ValueDomainValues/code[text()]">
			<tr>
				<td colspan="5">Domänvärden</td>
			</tr>
			<tr>
				<th colspan="3">
					<table class="MYTABLE">
						<tr class="Level-3-Header">
							<td width="20%">Kod</td>
							<td width="20%">Namn</td>
							<td>Beskrivning</td>
						</tr>
						<xsl:apply-templates select="ValueDomainValues"/>
					</table>
				</th>
			</tr>
			<tr class="Level-1-EmptyRow">
				<td colspan="5">x</td>
			</tr>
		</xsl:if>
	</xsl:template>
	<xsl:template match="FC_FeatureAttribute/ValueDomainValues">
		<tr>
			<td class="subtabledata2">
				<xsl:value-of select="code"/>
			</td>
			<td class="subtabledata2">
				<xsl:value-of select="label"/>
			</td>
			<td class="subtabledata2">
				<xsl:value-of select="definition"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="MDURI"/>
	<xsl:template match="metadata/serviceInfo">
		<table id="serviceinfo" class="MYTABLE" border="1" bordercolor="#6495ED">
			<!--Following will show the service information -->
			<!--<xsl:call-template name = "SubMenuSrv">
                <xsl:with-param name = "strCSS">Parent IsVisible</xsl:with-param>
            </xsl:call-template>
            -->
			<!--Following will show the Layer information -->
			<!--
            <xsl:call-template name = "SubMenuLayer">
                <xsl:with-param name = "strCSS">Parent IsVisible</xsl:with-param>
            </xsl:call-template>-->
		</table>
	</xsl:template>
	<!--SubMenu -->
	<xsl:template name="SubMenu">
		<xsl:param name="strCSS"/>
		<tr>
			<td>
				<div class="{$strCSS}">
					<xsl:choose>
						<xsl:when test="count(.) &gt; 0">
							<!--Element has children, it can be expanded -->
							<input type="hidden" id="hidIsExpanded" value="0"/>
							<label id="lblExpand" class="Expander" onclick="ExpanderClicked();">+&#160;</label>
						</xsl:when>
						<xsl:otherwise>
							<label class="Expander">&#160;&#160;</label>
						</xsl:otherwise>
					</xsl:choose>
					<b>
						<font style="font-size:10pt">Objektyp(lager):</font>
					</b>
					<xsl:call-template name="FetTypeDetails"/>
					<xsl:for-each select="FC_FeatureAttribute">
						<!--<DIV1>-->
						<xsl:call-template name="SubMenuAttr">
							<xsl:with-param name="strCSS1">NotVisible</xsl:with-param>
						</xsl:call-template>
						<!--</DIV1>-->
					</xsl:for-each>
				</div>
			</td>
		</tr>
	</xsl:template>
	<xsl:template name="FetTypeDetails">
		<xsl:if test="name[text()]|definition[text()]|code[text()]|alias[text()]">
			<table border="1px" width="100%">
				<xsl:if test="name[text()]">
					<tr>
						<td width="7px" style="background-color:#E4E4C9">Namn:</td>
						<td style="background-color:#F4F4EA;font-weight:normal">
							<xsl:value-of select="name"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="definition[text()]">
					<tr>
						<td width="7px" style="background-color:#E4E4C9">Beskrivning:</td>
						<td style="background-color:#F4F4EA;font-weight:normal">
							<xsl:value-of select="definition"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="code[text()]">
					<tr>
						<td width="7px" style="background-color:#E4E4C9">Kod:</td>
						<td style="background-color:#F4F4EA;font-weight:normal">
							<xsl:value-of select="code"/>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="alias[text()]">
					<tr>
						<td width="7px" style="background-color:#E4E4C9">Filsyntax:</td>
						<td style="background-color:#F4F4EA;font-weight:normal">
							<xsl:value-of select="alias"/>
						</td>
					</tr>
				</xsl:if>
			</table>
		</xsl:if>
	</xsl:template>
	<!--SubMenuAttr -->
	<xsl:template name="SubMenuAttr">
		<xsl:param name="strCSS1"/>
		<div id="childDiv" class="{$strCSS1}">
			<!--<xsl:value-of select="$strCSS1"/>-->
			<xsl:choose>
				<xsl:when test="count(.) &gt; 0">
					<!--Element has children, it can be expanded -->
					<input type="hidden" id="hidIsExpanded" value="0"/>
					<!--<label id="lblExpand" class="Expander" onclick="ExpanderClicked()">+&#160;</label>-->
					<label id="lblExpand" class="Expander" onclick="ExpanderClicked();">+&#160;</label>
				</xsl:when>
				<xsl:otherwise>
					<label class="Expander">&#160;&#160;</label>
				</xsl:otherwise>
			</xsl:choose>
			<!--<xsl:value-of select="$strCSS1"/>-->
			<b>
				<font style="font-size:10pt">
                    Attributvärde:
                    <!--<xsl:value-of select="name"/>-->
				</font>
			</b>
			<!--<table border = "1px" width = "98%">
                <tr style = "background-color:#DAE8EB;font-weight:bold">
                    <td width = "50px">Alias</td>
                    <td width = "50px">Fältnamn</td>
                    <td width = "50px">Datatyp</td>
                    <td width = "50px">Beskrivning</td>
                </tr>
                <tr style = "background-color:#EEF5F7;font-weight:normal">
                    <td>
                        <xsl:value-of select = "name"/>
                    </td>
                    <td>
                        <xsl:value-of select = "code"/>
                    </td>
                    <td>
                        <xsl:value-of select = "valueDataType"/>
                    </td>
                    <td>
                        <xsl:value-of select = "definition"/>
                    </td>
                </tr>
            </table>-->
			<table border="1px" width="100%">
				<tr>
					<td width="7px" style="background-color:#DAE8EB">Alias:</td>
					<td style="background-color:#EEF5F7;font-weight:normal">
						<xsl:value-of select="name"/>
					</td>
				</tr>
				<tr>
					<td width="7px" style="background-color:#DAE8EB">Fältnamn:</td>
					<td style="background-color:#EEF5F7;font-weight:normal">
						<xsl:value-of select="code"/>
					</td>
				</tr>
				<tr>
					<td width="7px" style="background-color:#DAE8EB">Datatyp:</td>
					<td style="background-color:#EEF5F7;font-weight:normal">
						<xsl:value-of select="valueDataType"/>
					</td>
				</tr>
				<tr>
					<td width="7px" style="background-color:#DAE8EB">Beskrivning:</td>
					<td style="background-color:#EEF5F7;font-weight:normal">
						<xsl:value-of select="definition"/>
					</td>
				</tr>
			</table>
			<xsl:for-each select="ValueDomainValues">
				<!--<xsl:if test = "ValueDomainValues">-->
				<!--<DIV2>-->
				<xsl:call-template name="SubMenuDomainVal">
					<xsl:with-param name="strCSS2">NotVisible</xsl:with-param>
				</xsl:call-template>
				<!--FeatureAttribute456:
                </DIV2>-->
			</xsl:for-each>
		</div>
	</xsl:template>
	<xsl:template name="SubMenuDomainVal">
		<xsl:param name="strCSS2"/>
		<div id="childchildDiv" class="{$strCSS2}">
			<xsl:choose>
				<xsl:when test="count(.) &gt; 0">
					<!--Element has children, it can be expanded-->
					<input type="hidden" id="hidIsExpanded" value="0"/>
					<!--<label id="lblExpand" class="Expander" onclick="ExpanderClicked()">+&#160;</label>-->
					<label id="lblExpand" class="Expander" onclick="ExpanderClicked();">+&#160;</label>
				</xsl:when>
				<xsl:otherwise>
					<label class="Expander">&#160;&#160;</label>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:call-template name="SubMenuDomainDetail">
				<xsl:with-param name="strCSS3">NotVisible</xsl:with-param>
			</xsl:call-template>
		</div>
	</xsl:template>
	<xsl:template name="SubMenuDomainDetail">
		<xsl:param name="strCSS3"/>
		<div id="DomainchildDiv" class="{$strCSS3}">
			<table border="1px" width="95%">
				<tr>
					<td width="7px" style="background-color:#EEEEEE">Kod:</td>
					<td style="background-color:#F7F7F7;font-weight:normal">
						<xsl:value-of select="code"/>
					</td>
				</tr>
				<tr>
					<td width="7px" style="background-color:#EEEEEE">Namn:</td>
					<td style="background-color:#F7F7F7;font-weight:normal">
						<xsl:value-of select="label"/>
					</td>
				</tr>
				<tr>
					<td width="7px" style="background-color:#EEEEEE">Beskrivning:</td>
					<td style="background-color:#F7F7F7;font-weight:normal">
						<xsl:value-of select="def"/>
					</td>
				</tr>
			</table>
		</div>
	</xsl:template>
	<!-- Ticket #105 -->
	<xsl:template name="SubMenuSrv">
		<xsl:param name="strCSS"/>
		<tr>
			<td>
				<div class="{$strCSS}">
					<xsl:choose>
						<xsl:when test="count(.) &gt; 0">
							<!-- Element has children, it can be expanded -->
							<input type="hidden" id="hidIsExpanded" value="0"/>
							<label id="lblExpand" class="Expander" onclick="ExpanderClicked();">+&#160;</label>
						</xsl:when>
						<xsl:otherwise>
							<label class="Expander">&#160;&#160;</label>
						</xsl:otherwise>
					</xsl:choose>
					<b>
						<font style="font-size:10pt">
              General Section:
            </font>
					</b>
					<!-- Loop through all parent Service-->
					<xsl:for-each select="Service">
						<xsl:call-template name="GeneralInformationDetails">
							<xsl:with-param name="strCSS1">NotVisible</xsl:with-param>
						</xsl:call-template>
					</xsl:for-each>
				</div>
			</td>
		</tr>
	</xsl:template>
	<!-- Service General Information -->
	<xsl:template name="GeneralInformationDetails">
		<xsl:param name="strCSS1"/>
		<div id="GenInfochildDiv" class="{$strCSS1}">
			<table border="2px solid #A59F98" width="100%">
				<tr>
					<td width="5px" style="background-color:#EEEEEE">Namn:</td>
					<td style="background-color:#F7F7F7;font-weight:normal">
						<xsl:value-of select="Name"/>
					</td>
				</tr>
				<tr>
					<td style="background-color:#EEEEEE">Titel:</td>
					<td style="background-color:#F7F7F7;font-weight:normal">
						<xsl:value-of select="Title"/>
					</td>
				</tr>
				<tr>
					<td style="background-color:#EEEEEE">Sammanfattning:</td>
					<td style="background-color:#F7F7F7;font-weight:normal">
						<xsl:value-of select="Abstract"/>
					</td>
				</tr>
				<xsl:for-each select="KeywordList">
					<tr>
						<td colspan="2" style="background-color:#EEEEEE">Sökordslistan:</td>
					</tr>
					<xsl:for-each select="Keyword">
						<tr>
							<td class="Level-2-element">Keyword:</td>
							<td style="background-color:#F7F7F7;font-weight:normal">
								<xsl:value-of select="."/>
							</td>
						</tr>
					</xsl:for-each>
				</xsl:for-each>
				<tr>
					<td style="background-color:#EEEEEE">Online Resource:</td>
					<td style="background-color:#F7F7F7;font-weight:normal">
						<xsl:value-of select="OnlineResource"/>
					</td>
				</tr>
				<tr>
					<td style="background-color:#EEEEEE">Avgifter:</td>
					<td style="background-color:#F7F7F7;font-weight:normal">
						<xsl:value-of select="Fees"/>
					</td>
				</tr>
				<tr>
					<td style="background-color:#EEEEEE">Tillgång Constraints:</td>
					<td style="background-color:#F7F7F7;font-weight:normal">
						<xsl:value-of select="AccessConstraints"/>
					</td>
				</tr>
			</table>
		</div>
	</xsl:template>
	<!-- Layer Level - 1 -->
	<xsl:template name="SubMenuLayerLevel1">
		<xsl:param name="strCSS1"/>
		<div id="childLayer1Div" class="{$strCSS1}">
			<xsl:choose>
				<xsl:when test="count(.) &gt; 0">
					<!-- Element has children, it can be expanded -->
					<input type="hidden" id="hidIsExpanded" value="0"/>
					<!--<label id="lblExpand" class="Expander" onclick="ExpanderClicked()">+&#160;</label>-->
					<label id="lblExpand" class="Expander" onclick="ExpanderClicked();">+&#160;</label>
				</xsl:when>
				<xsl:otherwise>
					<label class="Expander">&#160;&#160;</label>
				</xsl:otherwise>
			</xsl:choose>
			<b>
				<font style="font-size:10pt">
					<xsl:value-of select="Title"/>
				</font>
			</b>
			<table style="background-color:#E4E4C9" class="tableLayerStyle">
				<tr>
					<td class="tableLayerHeaderStyle">
            Title
          </td>
					<td class="tableLayerHeaderStyle">
            Name
          </td>
					<td class="tableLayerHeaderStyle">
            MinScale
          </td>
					<td class="tableLayerHeaderStyle">
            MaxScale
          </td>
					<td class="tableLayerHeaderStyle">
            LegendURL
          </td>
					<td class="tableLayerHeaderStyle">
            MetaDataURL
          </td>
					<td class="tableLayerHeaderStyle">
            SRS
          </td>
				</tr>
				<tr class="mytabledata">
					<td id="td0" onmousemove="showdata(this,0);" onmouseout="hidedata();" style="background-color:#F1F1E4" class="tableDataStyle">
						<xsl:value-of select="Title"/>
					</td>
					<td id="td1" onmousemove="showdata(this,1);" onmouseout="hidedata();" style="background-color:#F4F4EC" class="tableDataStyle">
						<xsl:value-of select="Name"/>
					</td>
					<td id="td2" onmousemove="showdata(this,2);" onmouseout="hidedata();" style="background-color:#F4F4EC" class="tableDataStyle">
						<xsl:value-of select="ScaleHint/@min"/>
					</td>
					<td id="td3" onmousemove="showdata(this,3);" onmouseout="hidedata();" style="background-color:#F4F4EC" class="tableDataStyle">
						<xsl:value-of select="ScaleHint/@max"/>
					</td>
					<td id="td4" onmousemove="showdata(this,4);" onmouseout="hidedata();" style="background-color:#F4F4EC" class="tableDataStyle">
						<IMG xmlns="http://www.w3.org/1999/xhtml" ID="thumbnail" ALIGN="absmiddle" style="border:'2 outset #ffffff';position:relative">
							<xsl:attribute name="SRC"><xsl:value-of select="Style/LegendURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/></xsl:attribute>
							<xsl:attribute name="width"><xsl:value-of select="Style/LegendURL/@width"/></xsl:attribute>
							<xsl:attribute name="height"><xsl:value-of select="Style/LegendURL/@height"/></xsl:attribute>
						</IMG>
						<br/>
						<a target="_blank">
							<xsl:attribute name="href"><xsl:value-of select="Style/LegendURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/></xsl:attribute>
							<xsl:value-of select="Style/LegendURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/>
						</a>
					</td>
					<td id="td5" onmousemove="showdata(this,5);" onmouseout="hidedata();" style="background-color:#F4F4EC" class="tableDataStyle">
						<a target="_blank">
							<xsl:attribute name="href"><xsl:value-of select="Style/MetadataURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/></xsl:attribute>
							<xsl:value-of select="Style/MetadataURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/>
						</a>
					</td>
					<td id="td6" onmousemove="showdata(this,6);" onmouseout="hidedata();" style="background-color:#F4F4EC" class="tableDataStyle">
						<xsl:for-each select="SRS">
							<xsl:value-of select="text()"/>
							<br/>
						</xsl:for-each>
					</td>
				</tr>
			</table>
			<!-- Loop through all parent layer-->
			<!-- level 2-->
			<xsl:for-each select="Layer">
				<xsl:call-template name="SubMenuLayerLevel2">
					<xsl:with-param name="strCSS2">NotVisible</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</div>
	</xsl:template>
	<!-- Layer Level - 2 -->
	<xsl:template name="SubMenuLayerLevel2">
		<xsl:param name="strCSS2"/>
		<div id="childLayer2Div" class="{$strCSS2}">
			<xsl:choose>
				<xsl:when test="count(Layer) &gt; 0">
					<!-- Element has children, it can be expanded -->
					<input type="hidden" id="hidIsExpanded" value="0"/>
					<!--<label id="lblExpand" class="Expander" onclick="ExpanderClicked()">+&#160;</label>-->
					<label id="lblExpand" class="Expander" onclick="ExpanderClicked();">+&#160;</label>
				</xsl:when>
				<xsl:otherwise>
					<label class="Expander">&#160;</label>
				</xsl:otherwise>
			</xsl:choose>
			<b>
				<font style="font-size:10pt">
					<xsl:value-of select="Title"/>
				</font>
			</b>
			<!--<table border="1px" width="100%">-->
			<table style="background-color:#DAE8EB" class="tableLayerStyle">
				<tr>
					<td class="tableLayerHeaderStyle">
            Title
          </td>
					<td class="tableLayerHeaderStyle">
            Name
          </td>
					<td class="tableLayerHeaderStyle">
            MinScale
          </td>
					<td class="tableLayerHeaderStyle">
            MaxScale
          </td>
					<td class="tableLayerHeaderStyle">
            LegendURL
          </td>
					<td class="tableLayerHeaderStyle">
            MetaDataURL
          </td>
					<td class="tableLayerHeaderStyle">
            SRS
          </td>
				</tr>
				<tr class="mytabledata">
					<td id="td0" onmousemove="showdata(this,0);" onmouseout="hidedata();" style="background-color:#F7FAFB" class="tableDataStyle">
						<xsl:value-of select="Title"/>
					</td>
					<td id="td1" onmousemove="showdata(this,1);" onmouseout="hidedata();" style="background-color:#F7FAFB" class="tableDataStyle">
						<xsl:value-of select="Name"/>
					</td>
					<td id="td2" onmousemove="showdata(this,2);" onmouseout="hidedata();" style="background-color:#F7FAFB" class="tableDataStyle">
						<xsl:value-of select="ScaleHint/@min"/>
					</td>
					<td id="td3" onmousemove="showdata(this,3);" onmouseout="hidedata();" style="background-color:#F7FAFB" class="tableDataStyle">
						<xsl:value-of select="ScaleHint/@max"/>
					</td>
					<td id="td4" onmousemove="showdata(this,4);" onmouseout="hidedata();" style="background-color:#F7FAFB" class="tableDataStyle">
						<IMG xmlns="http://www.w3.org/1999/xhtml" ID="thumbnail" ALIGN="absmiddle" style="border:'2 outset #ffffff';position:relative">
							<xsl:attribute name="SRC"><xsl:value-of select="Style/LegendURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/></xsl:attribute>
							<xsl:attribute name="width"><xsl:value-of select="Style/LegendURL/@width"/></xsl:attribute>
							<xsl:attribute name="height"><xsl:value-of select="Style/LegendURL/@height"/></xsl:attribute>
						</IMG>
						<br/>
						<a target="_blank">
							<xsl:attribute name="href"><xsl:value-of select="Style/LegendURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/></xsl:attribute>
							<xsl:value-of select="Style/LegendURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/>
						</a>
					</td>
					<td id="td5" onmousemove="showdata(this,5);" onmouseout="hidedata();" style="background-color:#F7FAFB" class="tableDataStyle">
						<a target="_blank">
							<xsl:attribute name="href"><xsl:value-of select="Style/MetadataURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/></xsl:attribute>
							<xsl:value-of select="Style/MetadataURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/>
						</a>
					</td>
					<td id="td6" onmousemove="showdata(this,6);" onmouseout="hidedata();" style="background-color:#F7FAFB" class="tableDataStyle">
						<xsl:for-each select="SRS">
							<xsl:value-of select="text()"/>
							<br/>
						</xsl:for-each>
					</td>
				</tr>
			</table>
			<!-- Loop through all parent layer-->
			<!-- level 3-->
			<xsl:for-each select="Layer">
				<xsl:call-template name="SubMenuLayerLevel3">
					<xsl:with-param name="strCSS3">NotVisible</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</div>
	</xsl:template>
	<!-- Layer Level - 3 -->
	<xsl:template name="SubMenuLayerLevel3">
		<xsl:param name="strCSS3"/>
		<div id="childLayer3Div" class="{$strCSS3}">
			<xsl:choose>
				<xsl:when test="count(Layer) &gt; 0">
					<!-- Element has children, it can be expanded -->
					<input type="hidden" id="hidIsExpanded" value="0"/>
					<!--<label id="lblExpand" class="Expander" onclick="ExpanderClicked()">+&#160;</label>-->
					<label id="lblExpand" class="Expander" onclick="ExpanderClicked();">+&#160;</label>
				</xsl:when>
				<xsl:otherwise>
					<label class="Expander">&#160;</label>
				</xsl:otherwise>
			</xsl:choose>
			<b>
				<font style="font-size:10pt">
					<xsl:value-of select="Title"/>
				</font>
			</b>
			<!--<table border="1px" width="100%">-->
			<table style="background-color:#FAD3DB" class="tableLayerStyle">
				<tr>
					<td class="tableLayerHeaderStyle">
            Title
          </td>
					<td class="tableLayerHeaderStyle">
            Name
          </td>
					<td class="tableLayerHeaderStyle">
            MinScale
          </td>
					<td class="tableLayerHeaderStyle">
            MaxScale
          </td>
					<td class="tableLayerHeaderStyle">
            LegendURL
          </td>
					<td class="tableLayerHeaderStyle">
            MetaDataURL
          </td>
					<td class="tableLayerHeaderStyle">
            SRS
          </td>
				</tr>
				<tr class="mytabledata">
					<td id="td0" onmousemove="showdata(this,0);" onmouseout="hidedata();" style="background-color:#FEF3F5" class="tableDataStyle">
						<xsl:value-of select="Title"/>
					</td>
					<td id="td1" onmousemove="showdata(this,1);" onmouseout="hidedata();" style="background-color:#FEF3F5" class="tableDataStyle">
						<xsl:value-of select="Name"/>
					</td>
					<td id="td2" onmousemove="showdata(this,2);" onmouseout="hidedata();" style="background-color:#FEF3F5" class="tableDataStyle">
						<xsl:value-of select="ScaleHint/@min"/>
					</td>
					<td id="td3" onmousemove="showdata(this,3);" onmouseout="hidedata();" style="background-color:#FEF3F5" class="tableDataStyle">
						<xsl:value-of select="ScaleHint/@max"/>
					</td>
					<td id="td4" onmousemove="showdata(this,4);" onmouseout="hidedata();" style="background-color:#FEF3F5" class="tableDataStyle">
						<IMG xmlns="http://www.w3.org/1999/xhtml" ID="thumbnail" ALIGN="absmiddle" style="border:'2 outset #ffffff';position:relative">
							<xsl:attribute name="SRC"><xsl:value-of select="Style/LegendURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/></xsl:attribute>
							<xsl:attribute name="width"><xsl:value-of select="Style/LegendURL/@width"/></xsl:attribute>
							<xsl:attribute name="height"><xsl:value-of select="Style/LegendURL/@height"/></xsl:attribute>
						</IMG>
						<br/>
						<a target="_blank">
							<xsl:attribute name="href"><xsl:value-of select="Style/LegendURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/></xsl:attribute>
							<xsl:value-of select="Style/LegendURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/>
						</a>
					</td>
					<td id="td5" onmousemove="showdata(this,5);" onmouseout="hidedata();" style="background-color:#FEF3F5" class="tableDataStyle">
						<a target="_blank">
							<xsl:attribute name="href"><xsl:value-of select="Style/MetadataURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/></xsl:attribute>
							<xsl:value-of select="Style/MetadataURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/>
						</a>
					</td>
					<td id="td6" onmousemove="showdata(this,6);" onmouseout="hidedata();" style="background-color:#FEF3F5" class="tableDataStyle">
						<xsl:for-each select="SRS">
							<xsl:value-of select="text()"/>
							<br/>
						</xsl:for-each>
					</td>
				</tr>
			</table>
			<!-- Loop through all parent layer-->
			<!-- level 4-->
			<xsl:for-each select="Layer">
				<xsl:call-template name="SubMenuLayerLevel4">
					<xsl:with-param name="strCSS4">NotVisible</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</div>
	</xsl:template>
	<!-- Layer Level - 4 -->
	<xsl:template name="SubMenuLayerLevel4">
		<xsl:param name="strCSS4"/>
		<div id="childLayer4Div" class="{$strCSS4}">
			<xsl:choose>
				<xsl:when test="count(Layer) &gt; 0">
					<!-- Element has children, it can be expanded -->
					<input type="hidden" id="hidIsExpanded" value="0"/>
					<!--<label id="lblExpand" class="Expander" onclick="ExpanderClicked()">+&#160;</label>-->
					<label id="lblExpand" class="Expander" onclick="ExpanderClicked();">+&#160;</label>
				</xsl:when>
				<xsl:otherwise>
					<label class="Expander">&#160;</label>
				</xsl:otherwise>
			</xsl:choose>
			<b>
				<font style="font-size:10pt">
					<xsl:value-of select="Title"/>
				</font>
			</b>
			<!--<table border="1px" width="100%">-->
			<table style="background-color:#E0D2BE" class="tableLayerStyle">
				<tr>
					<td class="tableLayerHeaderStyle">
            Title
          </td>
					<td class="tableLayerHeaderStyle">
            Name
          </td>
					<td class="tableLayerHeaderStyle">
            MinScale
          </td>
					<td class="tableLayerHeaderStyle">
            MaxScale
          </td>
					<td class="tableLayerHeaderStyle">
            LegendURL
          </td>
					<td class="tableLayerHeaderStyle">
            MetaDataURL
          </td>
					<td class="tableLayerHeaderStyle">
            SRS
          </td>
				</tr>
				<tr class="mytabledata">
					<td id="td0" onmousemove="showdata(this,0);" onmouseout="hidedata();" style="background-color:#F5F1EB" class="tableDataStyle">
						<xsl:value-of select="Title"/>
					</td>
					<td id="td1" onmousemove="showdata(this,1);" onmouseout="hidedata();" style="background-color:#F5F1EB" class="tableDataStyle">
						<xsl:value-of select="Name"/>
					</td>
					<td id="td2" onmousemove="showdata(this,2);" onmouseout="hidedata();" style="background-color:#F5F1EB" class="tableDataStyle">
						<xsl:value-of select="ScaleHint/@min"/>
					</td>
					<td id="td3" onmousemove="showdata(this,3);" onmouseout="hidedata();" style="background-color:#F5F1EB" class="tableDataStyle">
						<xsl:value-of select="ScaleHint/@max"/>
					</td>
					<td id="td4" onmousemove="showdata(this,4);" onmouseout="hidedata();" style="background-color:#F5F1EB" class="tableDataStyle">
						<IMG xmlns="http://www.w3.org/1999/xhtml" ID="thumbnail" ALIGN="absmiddle" style="border:'2 outset #ffffff';position:relative">
							<xsl:attribute name="SRC"><xsl:value-of select="Style/LegendURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/></xsl:attribute>
							<xsl:attribute name="width"><xsl:value-of select="Style/LegendURL/@width"/></xsl:attribute>
							<xsl:attribute name="height"><xsl:value-of select="Style/LegendURL/@height"/></xsl:attribute>
						</IMG>
						<br/>
						<a target="_blank">
							<xsl:attribute name="href"><xsl:value-of select="Style/LegendURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/></xsl:attribute>
							<xsl:value-of select="Style/LegendURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/>
						</a>
					</td>
					<td id="td5" onmousemove="showdata(this,5);" onmouseout="hidedata();" style="background-color:#F5F1EB" class="tableDataStyle">
						<a target="_blank">
							<xsl:attribute name="href"><xsl:value-of select="Style/MetadataURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/></xsl:attribute>
							<xsl:value-of select="Style/MetadataURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/>
						</a>
					</td>
					<td id="td6" onmousemove="showdata(this,6);" onmouseout="hidedata();" style="background-color:#F5F1EB" class="tableDataStyle">
						<xsl:for-each select="SRS">
							<xsl:value-of select="text()"/>
							<br/>
						</xsl:for-each>
					</td>
				</tr>
			</table>
			<!-- Loop through all parent layer-->
			<!-- level 5-->
			<xsl:for-each select="Layer">
				<xsl:call-template name="SubMenuLayerLevel5">
					<xsl:with-param name="strCSS5">NotVisible</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</div>
	</xsl:template>
	<!-- Layer Level - 5 -->
	<xsl:template name="SubMenuLayerLevel5">
		<xsl:param name="strCSS5"/>
		<div id="childLayer5Div" class="{$strCSS5}">
			<table style="background-color:#EEEEEE" class="tableLayerStyle">
				<tr>
					<td class="tableLayerHeaderStyle">
            Title
          </td>
					<td class="tableLayerHeaderStyle">
            Name
          </td>
					<td class="tableLayerHeaderStyle">
            MinScale
          </td>
					<td class="tableLayerHeaderStyle">
            MaxScale
          </td>
					<td class="tableLayerHeaderStyle">
            LegendURL
          </td>
					<td class="tableLayerHeaderStyle">
            MetaDataURL
          </td>
					<td class="tableLayerHeaderStyle">
            SRS
          </td>
				</tr>
				<tr class="mytabledata">
					<td id="td0" onmousemove="showdata(this,0);" onmouseout="hidedata();" class="tableDataStyle">
						<xsl:value-of select="Title"/>
					</td>
					<td id="td1" onmousemove="showdata(this,1);" onmouseout="hidedata();" class="tableDataStyle">
						<xsl:value-of select="Name"/>
					</td>
					<td id="td2" onmousemove="showdata(this,2);" onmouseout="hidedata();" class="tableDataStyle">
						<xsl:value-of select="ScaleHint/@min"/>
					</td>
					<td id="td3" onmousemove="showdata(this,3);" onmouseout="hidedata();" class="tableDataStyle">
						<xsl:value-of select="ScaleHint/@max"/>
					</td>
					<td id="td4" onmousemove="showdata(this,4);" onmouseout="hidedata();" class="tableDataStyle">
						<IMG xmlns="http://www.w3.org/1999/xhtml" ID="thumbnail" ALIGN="absmiddle" style="border:'2 outset #ffffff';position:relative">
							<xsl:attribute name="SRC"><xsl:value-of select="Style/LegendURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/></xsl:attribute>
							<xsl:attribute name="width"><xsl:value-of select="Style/LegendURL/@width"/></xsl:attribute>
							<xsl:attribute name="height"><xsl:value-of select="Style/LegendURL/@height"/></xsl:attribute>
						</IMG>
						<br/>
						<a target="_blank">
							<xsl:attribute name="href"><xsl:value-of select="Style/LegendURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/></xsl:attribute>
							<xsl:value-of select="Style/LegendURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/>
						</a>
					</td>
					<td id="td5" onmousemove="showdata(this,5);" onmouseout="hidedata();" class="tableDataStyle">
						<a target="_blank">
							<xsl:attribute name="href"><xsl:value-of select="Style/MetadataURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/></xsl:attribute>
							<xsl:value-of select="Style/MetadataURL/OnlineResource/@xlink:href" xmlns:xlink="http://www.w3.org/1999/xlink"/>
						</a>
					</td>
					<td id="td6" onmousemove="showdata(this,6);" onmouseout="hidedata();" class="tableDataStyle">
						<xsl:for-each select="SRS">
							<xsl:value-of select="text()"/>
							<br/>
						</xsl:for-each>
					</td>
				</tr>
			</table>
		</div>
	</xsl:template>
	<!-- Layer Information -->
	<xsl:template name="SubMenuLayer">
		<xsl:param name="strCSS"/>
		<!--<xsl:variable name="strURL" select="url" />-->
		<tr>
			<td>
				<div class="{$strCSS}">
					<xsl:choose>
						<xsl:when test="count(.) &gt; 0">
							<!-- Element has children, it can be expanded -->
							<input type="hidden" id="hidIsExpanded" value="0"/>
							<label id="lblExpand" class="Expander" onclick="ExpanderClicked();">+&#160;</label>
						</xsl:when>
						<xsl:otherwise>
							<label class="Expander">&#160;&#160;</label>
						</xsl:otherwise>
					</xsl:choose>
					<b>
						<font style="font-size:10pt">
              Layer Section:
            </font>
					</b>
					<!-- Loop through all parent layer-->
					<xsl:for-each select="Capability/Layer">
						<xsl:call-template name="SubMenuLayerLevel1">
							<xsl:with-param name="strCSS1">NotVisible</xsl:with-param>
						</xsl:call-template>
					</xsl:for-each>
					<!--<xsl:call-template name="SubMenuSrvLayerInformation">
            <xsl:with-param name="strCSS2">NotVisible</xsl:with-param>
          </xsl:call-template>-->
					<!--<xsl:call-template name ="SrvGeneralInformation" />-->
				</div>
			</td>
		</tr>
	</xsl:template>
	<xsl:template name="replace-string">
		<xsl:param name="text"/>
		<xsl:param name="replace"/>
		<xsl:param name="with"/>
		<xsl:choose>
			<xsl:when test="contains($text,$replace)">
				<xsl:value-of select="substring-before($text,$replace)"/>
				<xsl:value-of select="$with"/>
				<xsl:call-template name="replace-string">
					<xsl:with-param name="text" select="substring-after($text,$replace)"/>
					<xsl:with-param name="replace" select="$replace"/>
					<xsl:with-param name="with" select="$with"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- ... Dates - formatting is made on the client side by the directive  -->
	  <xsl:template mode="render-value"
					match="gco:Date[matches(., '[0-9]{4}')]">
		<xsl:value-of select="."/>
	  </xsl:template>

	  <xsl:template mode="render-value"
					match="gco:Date[matches(., '[0-9]{4}-[0-9]{2}')]">
		<xsl:value-of select="format-date(.,'[MN,*-3]-[Y0001]')"/>
	  </xsl:template>

	  <xsl:template mode="render-value"
					match="gco:Date[matches(., '[0-9]{4}-[0-9]{2}-[0-9]{2}')]">
		<xsl:value-of select="format-date(.,'[Y0001]-[M01]-[D01]')"/>
	  </xsl:template>

	  <xsl:template mode="render-value"
					match="gco:DateTime[matches(., '[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}')]">
		<xsl:value-of select="format-dateTime(.,'[Y0001]-[M01]-[D01] [h01]:[m01]')"/>
	  </xsl:template>

	  <xsl:template mode="render-value"
					match="gco:Date[matches(., '[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}')]">
		<xsl:value-of select="format-dateTime(.,'[Y0001]-[M01]-[D01]')"/>
	  </xsl:template>
	  
	  <xsl:template mode="render-value"
					match="gco:Date|gco:DateTime">
		<xsl:value-of select="format-date(.,'[Y0001]-[M01]-[D01]')"/>
	  </xsl:template>
	  
	  <xsl:template mode="online" match="gmd:onLine[1]" >
		<xsl:param name="overViewTab"/>
		<tr>
			<td class="Level-1-element online-table-td">Online-länkar</td>
			<td colspan="2">
				<table class="view-metadata-table">
					<tr>
						<th class="view-metadata-table-th-1">Länktyp</th>
						<th class="view-metadata-table-th-2">Namn</th>
						<th class="view-metadata-table-th-3">Url</th>
						<!-- Show description column only for non-overView tab: start  -->
						<xsl:if test="$overViewTab != 'true'">
							<th class="view-metadata-table-th-4">Description</th>
						</xsl:if>
						<!-- Show description column only for non-overView tab: end  -->
					</tr>
					<xsl:for-each select="parent::node()/gmd:onLine">
						<xsl:variable name="protocol">
							<xsl:apply-templates mode="render-value" select="*/gmd:protocol"/>
						</xsl:variable>
						<xsl:variable name="aliasProtocol">
							<xsl:choose>
								<xsl:when test="normalize-space($protocol) = 'HTTP:OGC:WFS'">Karttjänst (WFS)</xsl:when>
								<xsl:when test="normalize-space($protocol) = 'HTTP:OGC:WMS'">Karttjänst (WMS)</xsl:when>
								<xsl:when test="normalize-space($protocol) = 'HTTP:Information'">Informationssida</xsl:when>
								<xsl:when test="normalize-space($protocol) = 'HTTP:Nedladdning'">Nedladdningslänk</xsl:when>
								<xsl:when test="normalize-space($protocol) = 'HTTP:Nedladdning:ATOM'">Nedladdningslänk (ATOM)</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$protocol"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="name">
							<xsl:apply-templates mode="render-value" select="*/gmd:name"/>
						</xsl:variable>
						<xsl:variable name="url">
							<xsl:apply-templates mode="render-value" select="*/gmd:linkage/gmd:URL"/>
						</xsl:variable>
						<xsl:variable name="description">
							<xsl:apply-templates mode="render-value" select="*/gmd:description"/>
						</xsl:variable>
						<tr>
							<td class="view-metadata-table-td-1">
								<xsl:value-of select="normalize-space($aliasProtocol)"/>
							</td>
							<td class="view-metadata-table-td-2">
								<xsl:value-of select="normalize-space($name)"/>
							</td>
							<td class="view-metadata-table-td-3">
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
							<!-- Show description column only for non-overView tab: start  -->
							<xsl:if test="$overViewTab != 'true'">
								<td class="view-metadata-table-td-4">
									<xsl:variable name="preId" select="generate-id()"/>
									<div class="pre">
										<xsl:attribute name="id">pre<xsl:value-of select="$preId"/><xsl:value-of select="position()"/></xsl:attribute>
										<xsl:value-of select="normalize-space($description)"/>
									</div>
									<script type="text/javascript">setLinkClickable('pre<xsl:value-of select="$preId"/>
										<xsl:value-of select="position()"/>');
									</script>
								</td>
							</xsl:if>
							<!-- Show description column only for non-overView tab: end  -->
						</tr>
					</xsl:for-each>
				</table>
			</td>
		</tr>
	</xsl:template>

	<xsl:template mode="online" match="gmd:onLine[position() > 1]"/>
	
	<xsl:template mode="render-value" match="gco:CharacterString|gmd:URL">
		<xsl:choose>
		  <xsl:when test="contains(., 'http')">
			<!-- Replace hyperlink in text by an hyperlink -->
			<xsl:variable name="textWithLinks"
						  select="replace(., '([a-z][\w-]+:/{1,3}[^\s()&gt;&lt;]+[^\s`!()\[\]{};:'&apos;&quot;.,&gt;&lt;?«»“”‘’])',
										'&lt;a target=&quot;_blank&quot; href=''$1''&gt;$1&lt;/a&gt;')"/>

			<xsl:if test="$textWithLinks != ''">
			  <xsl:copy-of select="saxon:parse(
							  concat('&lt;span&gt;',
							  replace($textWithLinks, '&amp;', '&amp;amp;'),
							  '&lt;/span&gt;'))"/>
			</xsl:if>
		  </xsl:when>
		  <xsl:otherwise>
			<xsl:value-of select="normalize-space(.)"/>
		  </xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
