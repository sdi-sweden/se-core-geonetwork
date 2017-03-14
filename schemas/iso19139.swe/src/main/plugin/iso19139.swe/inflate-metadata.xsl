<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                  xmlns:gmd="http://www.isotc211.org/2005/gmd"
                  xmlns:xlink='http://www.w3.org/1999/xlink'
                  xmlns:gco="http://www.isotc211.org/2005/gco"
                  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                  xmlns:gmx="http://www.isotc211.org/2005/gmx"
                  xmlns:napec="http://www.ec.gc.ca/data_donnees/standards/schemas/napec"
                  exclude-result-prefixes="gmd xlink gco xsi napec">

  <!-- ================================================================= -->

  <xsl:template match="/root">
    <xsl:apply-templates select="gmd:MD_Metadata"/>
  </xsl:template>

  <!-- ================================================================= -->
  <xsl:template match="gmd:MD_DataIdentification">
    <xsl:copy>
      <xsl:copy-of select="@*" />

      <xsl:apply-templates select="gmd:citation" />
      <xsl:apply-templates select="gmd:abstract" />
      <xsl:apply-templates select="gmd:purpose" />
      <xsl:apply-templates select="gmd:credit" />
      <xsl:apply-templates select="gmd:status" />
      <xsl:apply-templates select="gmd:pointOfContact" />
      <xsl:apply-templates select="gmd:resourceMaintenance" />
      <xsl:apply-templates select="gmd:graphicOverview" />
      <xsl:apply-templates select="gmd:resourceFormat" />
      <xsl:apply-templates select="gmd:descriptiveKeywords" />


      <xsl:if test="count(gmd:descriptiveKeywords[gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString = 'Initiativ']) = 0">
        <gmd:descriptiveKeywords xmlns:gn="http://www.fao.org/geonetwork" xmlns:srv="http://www.isotc211.org/2005/srv">
          <gmd:MD_Keywords>
            <gmd:keyword>
              <gco:CharacterString></gco:CharacterString>
            </gmd:keyword>
            <gmd:type>
              <gmd:MD_KeywordTypeCode codeList="http://www.isotc211.org/2005/resources/codeList.xml#MD_KeywordTypeCode" codeListValue="theme"/>
            </gmd:type>
            <gmd:thesaurusName>
              <gmd:CI_Citation>
                <gmd:title>
                  <gco:CharacterString>Initiativ</gco:CharacterString>
                </gmd:title>
                <gmd:date>
                  <gmd:CI_Date>
                    <gmd:date>
                      <gco:Date>2011-04-04</gco:Date>
                    </gmd:date>
                    <gmd:dateType>
                      <gmd:CI_DateTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/codelist/ML_gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication"/>
                    </gmd:dateType>
                  </gmd:CI_Date>
                </gmd:date>
                <gmd:identifier>
                  <gmd:MD_Identifier>
                    <gmd:code>
                      <gmx:Anchor xlink:href="{/root/env/url}/thesaurus.download?ref=external.theme.Initiativ">geonetwork.thesaurus.external.theme.Initiativ</gmx:Anchor>
                    </gmd:code>
                  </gmd:MD_Identifier>
                </gmd:identifier>
              </gmd:CI_Citation>
            </gmd:thesaurusName>
          </gmd:MD_Keywords>
        </gmd:descriptiveKeywords>
      </xsl:if>


      <xsl:apply-templates select="gmd:resourceSpecificUsage" />
      <xsl:apply-templates select="gmd:resourceConstraints" />
      <xsl:apply-templates select="gmd:aggregationInfo" />
      <xsl:apply-templates select="gmd:spatialRepresentationType" />

      <xsl:apply-templates select="gmd:spatialResolution" />

      <xsl:choose>
        <xsl:when test="count(gmd:spatialResolution/gmd:MD_Resolution/gmd:equivalentScale) = 0">
          <gmd:spatialResolution>
            <gmd:MD_Resolution>
              <gmd:equivalentScale>
                <gmd:MD_RepresentativeFraction>
                  <gmd:denominator>
                    <gco:Integer/>
                  </gmd:denominator>
                </gmd:MD_RepresentativeFraction>
              </gmd:equivalentScale>
            </gmd:MD_Resolution>
          </gmd:spatialResolution>
          <gmd:spatialResolution>
            <gmd:MD_Resolution>
              <gmd:equivalentScale>
                <gmd:MD_RepresentativeFraction>
                  <gmd:denominator>
                    <gco:Integer/>
                  </gmd:denominator>
                </gmd:MD_RepresentativeFraction>
              </gmd:equivalentScale>
            </gmd:MD_Resolution>
          </gmd:spatialResolution>
        </xsl:when>
        <xsl:when test="count(gmd:spatialResolution/gmd:MD_Resolution/gmd:equivalentScale) = 1">
          <gmd:spatialResolution>
            <gmd:MD_Resolution>
              <gmd:equivalentScale>
                <gmd:MD_RepresentativeFraction>
                  <gmd:denominator>
                    <gco:Integer/>
                  </gmd:denominator>
                </gmd:MD_RepresentativeFraction>
              </gmd:equivalentScale>
            </gmd:MD_Resolution>
          </gmd:spatialResolution>
        </xsl:when>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="count(gmd:spatialResolution/gmd:MD_Resolution/gmd:distance) = 0">
          <gmd:spatialResolution>
            <gmd:MD_Resolution>
              <gmd:distance>
                <gco:Distance uom=""></gco:Distance>
              </gmd:distance>
            </gmd:MD_Resolution>
          </gmd:spatialResolution>
          <gmd:spatialResolution>
            <gmd:MD_Resolution>
              <gmd:distance>
                <gco:Distance uom=""></gco:Distance>
              </gmd:distance>
            </gmd:MD_Resolution>
          </gmd:spatialResolution>
        </xsl:when>
        <xsl:when test="count(gmd:spatialResolution/gmd:MD_Resolution/gmd:distance) = 1">
          <gmd:spatialResolution>
            <gmd:MD_Resolution>
              <gmd:distance>
                <gco:Distance uom=""></gco:Distance>
              </gmd:distance>
            </gmd:MD_Resolution>
          </gmd:spatialResolution>
        </xsl:when>
      </xsl:choose>


      <xsl:apply-templates select="gmd:language" />
      <xsl:apply-templates select="gmd:characterSet" />
      <xsl:apply-templates select="gmd:topicCategory" />
      <xsl:apply-templates select="gmd:environmentDescription" />
      <xsl:apply-templates select="gmd:extent" />
      <xsl:apply-templates select="gmd:supplementalInformation" />
    </xsl:copy>
  </xsl:template>

  <!-- Inflate organisation name and role if required -->
  <xsl:template match="gmd:CI_ResponsibleParty">
    <xsl:copy>
      <xsl:copy-of select="@*" />

      <xsl:apply-templates select="gmd:individualName" />

      <xsl:apply-templates select="gmd:organisationName" />

      <xsl:if test="not(gmd:organisationName)">
        <gmd:organisationName gco:nilReason='missing'>
          <gco:CharacterString></gco:CharacterString>
        </gmd:organisationName>
      </xsl:if>

      <xsl:apply-templates select="gmd:positionName" />
      <xsl:apply-templates select="gmd:contactInfo" />

      <xsl:apply-templates select="gmd:role" />

      <xsl:if test="not(gmd:role)">
        <gmd:role>
          <gmd:CI_RoleCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/codelist/ML_gmxCodelists.xml#CI_RoleCode"
                           codeListValue=""/>
        </gmd:role>
      </xsl:if>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="gmd:contactInfo/gmd:CI_Contact">
    <xsl:copy>
      <xsl:copy-of select="@*" />

      <xsl:apply-templates select="gmd:phone" />
      <xsl:if test="not(gmd:phone)">
        <gmd:phone>
          <gmd:CI_Telephone>
            <gmd:voice gco:nilReason='missing'>
              <gco:CharacterString></gco:CharacterString>
            </gmd:voice>
          </gmd:CI_Telephone>
        </gmd:phone>
      </xsl:if>

      <xsl:apply-templates select="gmd:address" />
      <xsl:if test="not(gmd:address)">
        <gmd:address>
          <gmd:CI_Address>
            <gmd:electronicMailAddress gco:nilReason='missing'>
              <gco:CharacterString></gco:CharacterString>
            </gmd:electronicMailAddress>
          </gmd:CI_Address>
        </gmd:address>
      </xsl:if>

      <xsl:apply-templates select="gmd:onlineResource" />
      <xsl:apply-templates select="gmd:hoursOfService" />
      <xsl:apply-templates select="gmd:contactInstructions" />
    </xsl:copy>
  </xsl:template>

  <!-- Inflate electronic mail address if required -->
  <xsl:template match="gmd:address">
    <xsl:copy>
      <xsl:copy-of select="@*" />

      <xsl:for-each select="gmd:CI_Address">
        <xsl:copy>
          <xsl:copy-of select="@*" />

          <xsl:apply-templates select="gmd:deliveryPoint" />
          <xsl:apply-templates select="gmd:city" />
          <xsl:apply-templates select="gmd:administrativeArea" />
          <xsl:apply-templates select="gmd:postalCode" />
          <xsl:apply-templates select="gmd:country" />
          <xsl:apply-templates select="gmd:electronicMailAddress" />

          <xsl:if test="not(gmd:electronicMailAddress)">
            <gmd:electronicMailAddress gco:nilReason='missing'>
              <gco:CharacterString></gco:CharacterString>
            </gmd:electronicMailAddress>
          </xsl:if>
        </xsl:copy>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>

  <!-- Inflate voice phone if required -->
  <xsl:template match="gmd:phone">
    <xsl:copy>
      <xsl:copy-of select="@*" />

      <xsl:for-each select="gmd:CI_Telephone">
        <xsl:copy>
          <xsl:copy-of select="@*" />

          <xsl:apply-templates select="gmd:voice" />

          <xsl:if test="not(gmd:voice)">
            <gmd:voice gco:nilReason='missing'>
              <gco:CharacterString></gco:CharacterString>
            </gmd:voice>
          </xsl:if>

          <xsl:apply-templates select="gmd:facsimile" />
        </xsl:copy>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>

  <!-- Inflate format -->
  <xsl:template match="gmd:MD_Distributor">
    <xsl:copy>
      <xsl:copy-of select="@*" />

      <xsl:apply-templates select="gmd:distributorContact" />
      <xsl:apply-templates select="gmd:distributionOrderProcess" />
      <xsl:apply-templates select="gmd:distributorFormat" />
      <xsl:if test="not(gmd:distributorFormat)">
        <gmd:distributorFormat>
          <gmd:MD_Format>
            <gmd:name gco:nilReason='missing'>
              <gco:CharacterString></gco:CharacterString>
            </gmd:name>
            <gmd:version gco:nilReason='missing'>
              <gco:CharacterString></gco:CharacterString>
            </gmd:version>
          </gmd:MD_Format>
        </gmd:distributorFormat>
      </xsl:if>
      <xsl:apply-templates select="gmd:distributorTransferOptions" />
    </xsl:copy>
  </xsl:template>

  <!-- ================================================================= -->
  <!-- copy everything else as is -->

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>