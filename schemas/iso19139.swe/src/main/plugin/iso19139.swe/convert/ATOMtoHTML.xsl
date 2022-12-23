<xsl:transform version="1.0" 
               xmlns:atom="http://www.w3.org/2005/Atom"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="/atom:feed/atom:title"/></title>
        <style>body { padding: 2em; background-color: white; font-size: 10pt; font-family: sans-serif; max-width: 100ex; margin: 0 auto; }</style>
        <style>h1 { color: steelblue; }</style>
        <style>section.feed > h1 { border: 1pt solid black; padding: 1em; text-align: center }</style>
        <style>section.entry > h1 { display:block; margin: 2em 0 0 0; }</style>
        <style>section.feed > h1 { font-size: 2em; }</style>
        <style>section.feed > section.entry > h1 { font-size: 1.5em; }</style>
        <style>section.feed > section.entry > section.feed > h1 { font-size: 1.33em; }</style>
        <style>section.feed > section.entry > section.feed > section.entry > h1 { font-size: 1.25em; }</style>
        <style>hr { border-style: none; border-top: 1pt solid black; }</style>
        <style>div.datetime { font-size: 8pt; color: gray; margin-bottom: 1ex; }</style>
        <style>section.entry > section.feed { padding-left: 2em; border-left: 1pt dotted grey; }</style>
        <style>input.tree { display: none; }</style>
        <style>input.tree               + h1 > label:before { content: "\25BC\A0"; margin-left: -1.25em; }</style>
        <style>input.tree:not(:checked) + h1 > label:before { content: "\25BA\A0"; margin-left: -1.25em; }</style>
        <style>input.tree:not(:checked) + h1 ~ * { display: none; }</style>
      </head>
      <body>
        <xsl:apply-templates select="atom:feed"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="atom:feed">
    <section class="feed">
      <h1><xsl:value-of select="atom:title"/></h1>
      <xsl:apply-templates select="atom:updated"/>
      <xsl:apply-templates select="atom:entry"/>
    </section>    
  </xsl:template>

  <xsl:template match="atom:entry">
    <section class="entry">
      <!-- add position because entry ids may erroneously be same as feed id -->
      <xsl:variable name="id" select="concat(atom:id, '#', position())"/>
      <input class="tree" type="checkbox" id="{$id}" checked = "true"/>
      <h1><label for="{$id}"><xsl:value-of select="atom:title"/></label></h1>
      <hr/>
      <a target="_blank">
          <xsl:attribute name="href">
            <xsl:value-of select="atom:link[@rel='alternate']/@href"/>
          </xsl:attribute>
        <xsl:value-of select="atom:link[@rel='alternate']/@href"/>
      </a>
      <p/>
      <div><xsl:apply-templates select="atom:updated"/></div>
      <div><xsl:apply-templates select="atom:content"/></div>
      <div><xsl:apply-templates select="atom:summary"/></div>
      <xsl:apply-templates select="atom:link"/>
    </section>
  </xsl:template>

  <xsl:template match="atom:content">
    <xsl:value-of select="text()"/>
  </xsl:template>
  <xsl:template match="atom:content[@type='html']">
    <!-- fix content - trim extra space before ul once: "<br/><br/> <ul>" to "<ul>" -->
    <xsl:variable name="brbrul" select="'&lt;br /&gt;&lt;br /&gt; &lt;ul&gt;'"/>
    <xsl:variable name="ul" select="'&lt;ul&gt;'"/>
    <xsl:variable name="text1">
      <xsl:choose>
        <xsl:when test="contains(., $brbrul)">
          <xsl:value-of select="concat(substring-before(., $brbrul), $ul, substring-after(., $brbrul))"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="$text1" disable-output-escaping="yes"/>
  </xsl:template>

  <xsl:template match="atom:summary">
    <xsl:value-of select="text()"/>
  </xsl:template>

  <xsl:template match="atom:link[@rel='section' and @href]">
    <a target="_blank">
      <xsl:attribute name="href">
        <xsl:value-of select="@href"/>
      </xsl:attribute>
      <xsl:value-of select="@title"/>
    </a>
  </xsl:template>
    
  <xsl:template match="atom:link[@rel='alternate' and @href]">
    <a target="_blank">
      <xsl:attribute name="href">
        <xsl:value-of select="@href"/>
      </xsl:attribute>
      <xsl:value-of select="@title"/>
    </a>
  </xsl:template>

  <xsl:template match="atom:link[@type='application/atom+xml' and @href]">
    <a target="_blank">
      <xsl:attribute name="href">
        <xsl:value-of select="atom:link[@rel='self']/@href"/>
      </xsl:attribute>
      <xsl:value-of select="@title"/>
    </a>
    <xsl:apply-templates select="document(@href)/atom:feed"/>
  </xsl:template>
 
  <xsl:template match="atom:updated">
    <xsl:variable name="date" select="substring-before(., 'T')"/>
    <xsl:variable name="yyyy" select="substring-before($date, '-')"/>
    <xsl:variable name="MM_dd" select="substring-after($date, '-')"/>
    <xsl:variable name="MM" select="substring-before($MM_dd, '-')"/>
    <xsl:variable name="dd" select="substring-after($MM_dd, '-')"/>
    <xsl:variable name="time" select="substring-after(., 'T')"/>
    <xsl:variable name="HH_mm_ss" select="substring-before($time, '.')"/>
    <xsl:variable name="HH" select="substring-before($HH_mm_ss, ':')"/>
    <xsl:variable name="mm_ss" select="substring-after($HH_mm_ss, ':')"/>
    <!-- adjust for 2020 swedish time zone -->
    <xsl:variable name="beginCEST_M" select="29"/>
    <xsl:variable name="beginCEST_d" select="29"/>
    <xsl:variable name="beginCEST_h" select="1"/>
    <xsl:variable name="endCEST_M" select="10"/>
    <xsl:variable name="endCEST_d" select="25"/>
    <xsl:variable name="endCEST_h" select="2"/>
    <xsl:variable name="inStdTime"
                  select="$MM &lt; $beginCEST_M or 
                          ($MM = $beginCEST_M and $dd &lt; $beginCEST_d) or
                          ($MM = $beginCEST_M and $dd = $beginCEST_d and $HH &lt; $beginCEST_h) or
                          $MM &gt; $endCEST_M or
                          ($MM = $endCEST_M and $dd &gt; $endCEST_d) or
                          ($MM = $endCEST_M and $dd = $endCEST_d and $HH = $endCEST_h)"/>
    <xsl:variable name="H">
      <xsl:choose>
        <xsl:when test="$inStdTime='true'">
          <xsl:value-of select="number($HH - 1)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="number($HH - 2)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="d">
      <xsl:choose>
        <xsl:when test="$inStdTime='true' and $HH &gt;= 1 or
                        $inStdTime='false' and $HH &gt;= 2">
          <xsl:value-of select="number($dd)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="number($dd) - 1"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="monthName">
      <xsl:choose>
        <xsl:when test="$MM='01'">januari</xsl:when>
        <xsl:when test="$MM='02'">februari</xsl:when>
        <xsl:when test="$MM='03'">mars</xsl:when>
        <xsl:when test="$MM='04'">april</xsl:when>
        <xsl:when test="$MM='05'">maj</xsl:when>
        <xsl:when test="$MM='06'">juni</xsl:when>
        <xsl:when test="$MM='07'">juli</xsl:when>
        <xsl:when test="$MM='08'">augusti</xsl:when>
        <xsl:when test="$MM='09'">september</xsl:when>
        <xsl:when test="$MM='10'">oktober</xsl:when>
        <xsl:when test="$MM='11'">november</xsl:when>
        <xsl:when test="$MM='12'">december</xsl:when>
        <xsl:otherwise><xsl:value-of select="$MM"/></xsl:otherwise>
      </xsl:choose>        
    </xsl:variable>
    <div class="datetime"><xsl:value-of select="concat($d, ' ', $monthName, ' ', $yyyy, ', ', $H, ':', $mm_ss)"/></div>
  </xsl:template>

</xsl:transform>
