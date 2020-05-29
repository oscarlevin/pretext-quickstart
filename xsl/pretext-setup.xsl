<?xml version='1.0' encoding="UTF-8"?>

<!--********************************************************************
Copyright 2019 Oscar Levin

This file is part of PreTeXt Quickstart
*********************************************************************-->

<!-- Identify as a stylesheet -->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:exsl="http://exslt.org/common"
    xmlns:date="http://exslt.org/dates-and-times"
    xmlns:str="http://exslt.org/strings"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    extension-element-prefixes="exsl date str"
    exclude-result-prefixes="xsl"
>

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>


<!-- Entry template: -->
<xsl:template match="/">
  <xsl:call-template name="bookinfo"/>
  <xsl:call-template name="frontmatter"/>
  <xsl:apply-templates/>
</xsl:template>



<!-- ########################################### -->
<!-- Templates to generate files:                -->
<!-- ########################################### -->


<xsl:template match="book">
  <xsl:variable name="xmlid">
    <xsl:call-template name="getid"/>
  </xsl:variable>
  <exsl:document href="src/{$xmlid}.ptx" method="xml" indent="yes">
    <xsl:comment>Generated by pretext-setup.xsl</xsl:comment>
    <pretext xmlns:xi="http://www.w3.org/2001/XInclude" xml:lang="en-US">
      <xi:include href="./bookinfo.ptx"/>
      <book>
        <xsl:attribute name="xml:id">
          <xsl:value-of select="$xmlid"/>
        </xsl:attribute>
        <title><xsl:value-of select="/book/metadata/title"/></title>
        <subtitle><xsl:value-of select="/book/metadata/subtitle"/></subtitle>
        
        <xsl:comment>Include the frontmatter</xsl:comment>
        <xi:include href="./frontmatter.ptx"/>
        
        <xsl:comment>Chapters to be included</xsl:comment>
        <xsl:apply-templates select="outline/chapter"/>

        <!-- <xsl:comment>Include the backmatter</xsl:comment>
        <xi:include href="./backmatter.ptx"/> -->
      </book>
    </pretext>
  </exsl:document>
</xsl:template>

<xsl:template match="chapter">
  <xsl:variable name="xmlid">
    <xsl:call-template name="getid"/>
  </xsl:variable>
  <xi:include href="{$xmlid}.ptx"/>
  <exsl:document href="{$xmlid}.ptx" method="xml" indent="yes">
    <chapter xmlns:xi="http://www.w3.org/2001/XInclude">
      <xsl:attribute name="xml:id"><xsl:value-of select="$xmlid"/></xsl:attribute>
      <title><xsl:apply-templates select="title"/></title>
      <xsl:apply-templates select="section"/>
    </chapter>
  </exsl:document>
</xsl:template>

<xsl:template match="section">
  <xsl:variable name="xmlid">
    <xsl:call-template name="getid"/>
  </xsl:variable>
  <xi:include href="{$xmlid}.ptx"/>
  <exsl:document href="{$xmlid}.ptx" method="xml" indent="yes">
    <section xmlns:xi="http://www.w3.org/2001/XInclude">
      <xsl:attribute name="xml:id"><xsl:value-of select="$xmlid"/></xsl:attribute>
      <title><xsl:apply-templates select="title"/></title>
      <xsl:apply-templates select="subsection"/>
    </section>
  </exsl:document>
</xsl:template>


<xsl:template name="bookinfo">
  <exsl:document href="src/bookinfo.ptx" method="xml" encoding="UTF-8" indent="yes">
    <xsl:comment>
      This file was generated by pretext-quickstart based on information provided in an outline. 
      It will be included in your main file and will contain metadata about your book, macros for latex and image creation, plus any customizations you want to make (like renaming elements).
      You can now modify this document to match your needs as you continue with the document.
    </xsl:comment>
    <docinfo xmlns:xi="http://www.w3.org/2001/XInclude">
      
      <xsl:comment>The brandlogo element will display a linked image for the html version.  When you know this info, uncomment and provide the relevant details.
      </xsl:comment>
        <brandlogo url="[bookurl]" source="images/cover.png"/>
      <covers front="images/front.pdf" back="images/back.pdf"/>
      <document-id>[doc-id]</document-id>
      <macros>
        \newcommand{\N}{\mathbb N}
        \newcommand{\Z}{\mathbb Z}
      </macros>
      <latex-image-preamble>
        \usepackage{tikz, pgfplots}
        \usetikzlibrary{positioning,matrix,arrows}
        \usetikzlibrary{shapes,decorations,shadows,fadings,patterns}
        \usetikzlibrary{decorations.markings}
      </latex-image-preamble>
        <rename element="investigation" xml:lang="en-US">Investigate!</rename>
      <cross-references text="type-global" />
    </docinfo>
  </exsl:document>
</xsl:template>


<xsl:template name="frontmatter">
  <exsl:document href="src/frontmatter.ptx" format="xml"  encoding="UTF-8" indent="yes">
    <xsl:comment>Generated by pretext-setup.xsl</xsl:comment>
    <frontmatter xmlns:xi="http://www.w3.org/2001/XInclude" xml:id="frontmatter">
      <titlepage>
        <author>
          <personname>
            <xsl:value-of select="book/metadata/author"/>
          </personname>
          <department>
            <xsl:value-of select="book/metadata/department"/>
          </department>
          <institution>
            <xsl:value-of select="book/metadata/institution"/>
          </institution>
        </author>
        <date><today/></date>
      </titlepage>
    
      <colophon>
        <xsl:comment>
        <website>
          <name><c>[website]</c></name>
          <address>[website]</address>
        </website>
      </xsl:comment>
        <copyright>
          <year>[copyright-year]</year>
          <holder>[copyright-holder]</holder>
          <!-- <minilicense><image source="../images/by-sa.png" /></minilicense> -->
          <shortlicense>
            <!-- <image source="../images/by-sa.png" width="15%"/>  -->
            This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License. To view a copy of this license, visit <url href="http://creativecommons.org/licenses/by-sa/4.0/">http://creativecommons.org/licenses/by-sa/4.0/</url>
          </shortlicense>
    
        </copyright>
    
      </colophon>

    </frontmatter>
  </exsl:document>
</xsl:template>


<xsl:template name="backmatter">
  <exsl:document href="src/backmatter.ptx" format="xml"  encoding="UTF-8" indent="yes">
    <xsl:comment>Generated by pretext-setup.xsl</xsl:comment>
    <backmatter xmlns:xi="http://www.w3.org/2001/XInclude" xml:id="backmatter">
      <index>
        <title>Index</title>
        <index-list/>
      </index>
    
      <colophon>
        <p>
          This book was authored in <pretext />.
        </p>
      </colophon>
    </backmatter>
  </exsl:document>
</xsl:template>


<xsl:template name="getid">
  <xsl:choose>
    <xsl:when test="@xml:id">
      <xsl:value-of select="@xml:id"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="div-shortname"/>
      <xsl:value-of select="translate(translate(title, '!', ''), '. ', '-')"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="div-shortname">
  <xsl:choose>
    <xsl:when test="self::chapter">
      <text>ch-</text>
    </xsl:when>
    <xsl:when test="self::section">
      <text>sec-</text>
    </xsl:when>
  </xsl:choose>
</xsl:template>


</xsl:stylesheet>