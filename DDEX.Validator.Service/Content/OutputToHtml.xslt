<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" omit-xml-declaration="yes" indent="yes" />
  <xsl:template name="string-replace-all">
    <xsl:param name="text" />
    <xsl:param name="replace" />
    <xsl:param name="by" />
    <xsl:choose>
      <xsl:when test="contains($text, $replace)">
        <xsl:value-of select="substring-before($text,$replace)" />
        <xsl:value-of select="$by" />
        <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text"
          select="substring-after($text,$replace)" />
          <xsl:with-param name="replace" select="$replace" />
          <xsl:with-param name="by" select="$by" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



  <xsl:template match="/">
    <div>
      <xsl:if test="count(//svrl:failed-assert) = 0">
        <p>This message is valid!</p>
      </xsl:if>
      <xsl:if test="count(//svrl:failed-assert[(not(@flag) or @flag='') or (@role='error')]) > 0">
        <div>Errors</div>
        <ul>
          <xsl:for-each select="//svrl:failed-assert[(not(@flag) or @flag='') or (@role='error')]">
            <li>
              <span class="error-message">
                <xsl:value-of select="svrl:text" />
              </span> at <span class="error-location">
                <xsl:call-template name="string-replace-all">
                  <xsl:with-param name="text" select="@location" />
                  <xsl:with-param name="replace" select='"/*[local-name()=&apos;NewReleaseMessage&apos;]"' />
                  <xsl:with-param name="by" select="'/NewReleaseMessage'" />
                </xsl:call-template>
              </span>
            </li>
          </xsl:for-each>
        </ul>
      </xsl:if>
      <xsl:if test="count(//svrl:failed-assert[(@flag = 'warning') or (@role = 'warning')]) > 0">
        <div>Warnings</div>
        <ul>
          <xsl:for-each select="//svrl:failed-assert[(@flag = 'warning') or (@role = 'warning')]">
            <li>
              <span class="error-message">
                <xsl:value-of select="svrl:text" /> 
              </span> at <span class="error-location">
                <xsl:call-template name="string-replace-all">
                  <xsl:with-param name="text" select="@location" />
                  <xsl:with-param name="replace" select='"/*[local-name()=&apos;NewReleaseMessage&apos;]"' />
                  <xsl:with-param name="by" select="'/NewReleaseMessage'" />
                </xsl:call-template>
              </span>
            </li>
          </xsl:for-each>
        </ul>
      </xsl:if>
    </div>
  </xsl:template>
</xsl:stylesheet>
