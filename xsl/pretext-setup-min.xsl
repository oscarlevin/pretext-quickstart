<?xml version='1.0' encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<root>
  <xsl:comment>Text comment</xsl:comment>
  <child><name>A child</name></child>
  <xsl:comment><child><name>commented child</name></child></xsl:comment>
</root>
</xsl:template>


<xsl:template match="/">
<root>
  <xsl:comment>Text comment</xsl:comment>
  <child><name>A child</name></child>
  <xsl:text disable-output-escaping="yes">&lt;!--</xsl:text>
  <child><name>commented child</name></child>
  <xsl:text disable-output-escaping="yes">--&gt;</xsl:text>
</root>
</xsl:template>

</xsl:stylesheet>