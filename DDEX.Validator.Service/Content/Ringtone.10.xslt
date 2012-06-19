<?xml version="1.0" encoding="UTF-8" standalone="yes"?><xsl:stylesheet xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" xmlns:ernm="http://ddex.net/xml/ern/34" version="1.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
<xsl:param name="archiveDirParameter"/><xsl:param name="archiveNameParameter"/><xsl:param name="fileNameParameter"/><xsl:param name="fileDirParameter"/><xsl:variable name="document-uri"><xsl:value-of select="document-uri(/)"/></xsl:variable>

<!--PHASES-->


<!--PROLOG-->
<xsl:output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" method="xml" omit-xml-declaration="no" standalone="yes" indent="yes"/>

<!--XSD TYPES FOR XSLT2-->


<!--KEYS AND FUNCTIONS-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-select-full-path"><xsl:apply-templates select="." mode="schematron-get-full-path"/></xsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-get-full-path"><xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/><xsl:text>/</xsl:text><xsl:choose><xsl:when test="namespace-uri()=''"><xsl:value-of select="name()"/><xsl:variable name="p_1" select="1+    count(preceding-sibling::*[name()=name(current())])"/><xsl:if test="$p_1&gt;1 or following-sibling::*[name()=name(current())]">[<xsl:value-of select="$p_1"/>]</xsl:if></xsl:when><xsl:otherwise><xsl:text>*[local-name()='</xsl:text><xsl:value-of select="local-name()"/><xsl:text>']</xsl:text><xsl:variable name="p_2" select="1+   count(preceding-sibling::*[local-name()=local-name(current())])"/><xsl:if test="$p_2&gt;1 or following-sibling::*[local-name()=local-name(current())]">[<xsl:value-of select="$p_2"/>]</xsl:if></xsl:otherwise></xsl:choose></xsl:template><xsl:template match="@*" mode="schematron-get-full-path"><xsl:text>/</xsl:text><xsl:choose><xsl:when test="namespace-uri()=''">@<xsl:value-of select="name()"/></xsl:when><xsl:otherwise><xsl:text>@*[local-name()='</xsl:text><xsl:value-of select="local-name()"/><xsl:text>' and namespace-uri()='</xsl:text><xsl:value-of select="namespace-uri()"/><xsl:text>']</xsl:text></xsl:otherwise></xsl:choose></xsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-2"><xsl:for-each select="ancestor-or-self::*"><xsl:text>/</xsl:text><xsl:value-of select="name(.)"/><xsl:if test="preceding-sibling::*[name(.)=name(current())]"><xsl:text>[</xsl:text><xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/><xsl:text>]</xsl:text></xsl:if></xsl:for-each><xsl:if test="not(self::*)"><xsl:text/>/@<xsl:value-of select="name(.)"/></xsl:if></xsl:template><!--MODE: SCHEMATRON-FULL-PATH-3-->
<!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-3"><xsl:for-each select="ancestor-or-self::*"><xsl:text>/</xsl:text><xsl:value-of select="name(.)"/><xsl:if test="parent::*"><xsl:text>[</xsl:text><xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/><xsl:text>]</xsl:text></xsl:if></xsl:for-each><xsl:if test="not(self::*)"><xsl:text/>/@<xsl:value-of select="name(.)"/></xsl:if></xsl:template>

<!--MODE: GENERATE-ID-FROM-PATH -->
<xsl:template match="/" mode="generate-id-from-path"/><xsl:template match="text()" mode="generate-id-from-path"><xsl:apply-templates select="parent::*" mode="generate-id-from-path"/><xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/></xsl:template><xsl:template match="comment()" mode="generate-id-from-path"><xsl:apply-templates select="parent::*" mode="generate-id-from-path"/><xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/></xsl:template><xsl:template match="processing-instruction()" mode="generate-id-from-path"><xsl:apply-templates select="parent::*" mode="generate-id-from-path"/><xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/></xsl:template><xsl:template match="@*" mode="generate-id-from-path"><xsl:apply-templates select="parent::*" mode="generate-id-from-path"/><xsl:value-of select="concat('.@', name())"/></xsl:template><xsl:template match="*" mode="generate-id-from-path" priority="-0.5"><xsl:apply-templates select="parent::*" mode="generate-id-from-path"/><xsl:text>.</xsl:text><xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/></xsl:template>

<!--MODE: GENERATE-ID-2 -->
<xsl:template match="/" mode="generate-id-2">U</xsl:template><xsl:template match="*" mode="generate-id-2" priority="2"><xsl:text>U</xsl:text><xsl:number level="multiple" count="*"/></xsl:template><xsl:template match="node()" mode="generate-id-2"><xsl:text>U.</xsl:text><xsl:number level="multiple" count="*"/><xsl:text>n</xsl:text><xsl:number count="node()"/></xsl:template><xsl:template match="@*" mode="generate-id-2"><xsl:text>U.</xsl:text><xsl:number level="multiple" count="*"/><xsl:text>_</xsl:text><xsl:value-of select="string-length(local-name(.))"/><xsl:text>_</xsl:text><xsl:value-of select="translate(name(),':','.')"/></xsl:template><!--Strip characters--><xsl:template match="text()" priority="-1"/>

<!--SCHEMA SETUP-->
<xsl:template match="/"><svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" title="Ringtone" schemaVersion=""><xsl:comment><xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/></xsl:comment><svrl:ns-prefix-in-attribute-values uri="http://ddex.net/xml/ern/34" prefix="ernm"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MustContainRingtoneClipSoundRecording</xsl:attribute><xsl:attribute name="name">MustContainRingtoneClipSoundRecording</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M2"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MustContainAComponentRelease</xsl:attribute><xsl:attribute name="name">MustContainAComponentRelease</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M3"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MustContainOneVideoResourceGroup</xsl:attribute><xsl:attribute name="name">MustContainOneVideoResourceGroup</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M4"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MustContainARelatedReleaseOfTypeIsReleaseFromRelease</xsl:attribute><xsl:attribute name="name">MustContainARelatedReleaseOfTypeIsReleaseFromRelease</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M5"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MustContainSequencedTrackBundle</xsl:attribute><xsl:attribute name="name">MustContainSequencedTrackBundle</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M6"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">SecondaryResourcesMustNotBeSequenced</xsl:attribute><xsl:attribute name="name">SecondaryResourcesMustNotBeSequenced</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M7"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">PrimaryResourcesShouldBeSequencedWithinTheirBundleResourceGroup</xsl:attribute><xsl:attribute name="name">PrimaryResourcesShouldBeSequencedWithinTheirBundleResourceGroup</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M8"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">SoundRecordingMustHaveReferenceTitle</xsl:attribute><xsl:attribute name="name">SoundRecordingMustHaveReferenceTitle</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M9"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">SingleFormalTitlePerTerritory</xsl:attribute><xsl:attribute name="name">SingleFormalTitlePerTerritory</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M10"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">SingleDisplayTitlePerTerritory</xsl:attribute><xsl:attribute name="name">SingleDisplayTitlePerTerritory</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M11"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">AtLeastOneDisplayArtist</xsl:attribute><xsl:attribute name="name">AtLeastOneDisplayArtist</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M12"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">ParentalWarningMustBeSet</xsl:attribute><xsl:attribute name="name">ParentalWarningMustBeSet</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M13"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">PLineMustBeProvided</xsl:attribute><xsl:attribute name="name">PLineMustBeProvided</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M14"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">IssuingLabelMustBeProvided</xsl:attribute><xsl:attribute name="name">IssuingLabelMustBeProvided</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M15"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">AtLeastOneGenre</xsl:attribute><xsl:attribute name="name">AtLeastOneGenre</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M16"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">HasGridOrIcpn</xsl:attribute><xsl:attribute name="name">HasGridOrIcpn</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M17"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">PrimaryResourcesIdentifiedByISRC</xsl:attribute><xsl:attribute name="name">PrimaryResourcesIdentifiedByISRC</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M18"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">SecondaryResourcesIdentifiedByProprietaryId</xsl:attribute><xsl:attribute name="name">SecondaryResourcesIdentifiedByProprietaryId</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M19"/></svrl:schematron-output></xsl:template>

<!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Ringtone</svrl:text>

<!--PATTERN MustContainRingtoneClipSoundRecording-->


	<!--RULE -->
<xsl:template match="ernm:NewReleaseMessage/ResourceList" priority="1000" mode="M2"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ernm:NewReleaseMessage/ResourceList"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="SoundRecording/SoundRecordingType[text() = 'RingtoneClip']"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="SoundRecording/SoundRecordingType[text() = 'RingtoneClip']"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
				A Ringtone must contain one SoundRecording of type RingtoneClip
			</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/></xsl:template><xsl:template match="text()" priority="-1" mode="M2"/><xsl:template match="@*|node()" priority="-2" mode="M2"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/></xsl:template>

<!--PATTERN MustContainAComponentRelease-->


	<!--RULE -->
<xsl:template match="ernm:NewReleaseMessage/ReleaseList" priority="1000" mode="M3"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ernm:NewReleaseMessage/ReleaseList"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="Release/ReleaseType[text() = 'RingtoneRelease']"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="Release/ReleaseType[text() = 'RingtoneRelease']"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
				A Ringtone must contain one RingtoneRelease release
			</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/></xsl:template><xsl:template match="text()" priority="-1" mode="M3"/><xsl:template match="@*|node()" priority="-2" mode="M3"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/></xsl:template>

<!--PATTERN MustContainOneVideoResourceGroup-->


	<!--RULE -->
<xsl:template match="ernm:NewReleaseMessage/ReleaseList/Release" priority="1000" mode="M4"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ernm:NewReleaseMessage/ReleaseList/Release"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="descendant::ResourceGroupContentItem[(ResourceType = 'Video' or ResourceType = 'SoundRecording') and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="descendant::ResourceGroupContentItem[(ResourceType = 'Video' or ResourceType = 'SoundRecording') and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
				A Ringtone must contain at least one ResourceGroupContentItem of type Video or SoundRecording, marked as a PrimaryResource
			</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/></xsl:template><xsl:template match="text()" priority="-1" mode="M4"/><xsl:template match="@*|node()" priority="-2" mode="M4"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/></xsl:template>

<!--PATTERN MustContainARelatedReleaseOfTypeIsReleaseFromRelease-->


	<!--RULE -->
<xsl:template match="ernm:NewReleaseMessage/ReleaseList/Release" priority="1000" mode="M5"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ernm:NewReleaseMessage/ReleaseList/Release"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="descendant::RelatedRelease[ReleaseRelationshipType = 'IsReleaseFromRelease']"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="descendant::RelatedRelease[ReleaseRelationshipType = 'IsReleaseFromRelease']"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
				A Ringtone must contain a RelatedRelease of type IsReleaseFromRelease
			</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/></xsl:template><xsl:template match="text()" priority="-1" mode="M5"/><xsl:template match="@*|node()" priority="-2" mode="M5"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/></xsl:template>

<!--PATTERN MustContainSequencedTrackBundle-->


	<!--RULE -->
<xsl:template match="ernm:NewReleaseMessage/ReleaseList/Release/*/ResourceGroup/ResourceGroup/ResourceGroupContentItem[ResourceType = 'Video' and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]" priority="1000" mode="M6"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ernm:NewReleaseMessage/ReleaseList/Release/*/ResourceGroup/ResourceGroup/ResourceGroupContentItem[ResourceType = 'Video' and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="SequenceNumber"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="SequenceNumber"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
				Track bundle resource groups should be sequenced
			</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/></xsl:template><xsl:template match="text()" priority="-1" mode="M6"/><xsl:template match="@*|node()" priority="-2" mode="M6"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/></xsl:template>

<!--PATTERN SecondaryResourcesMustNotBeSequenced-->


	<!--RULE -->
<xsl:template match="ResourceGroup/ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']]" priority="1000" mode="M7"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ResourceGroup/ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']]"/>

		<!--REPORT -->
<xsl:if test="SequenceNumber"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="SequenceNumber"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
				Secondary Resources (e.g. cover images) content items shall not be sequenced
			</svrl:text></svrl:successful-report></xsl:if><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/></xsl:template><xsl:template match="text()" priority="-1" mode="M7"/><xsl:template match="@*|node()" priority="-2" mode="M7"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/></xsl:template>

<!--PATTERN PrimaryResourcesShouldBeSequencedWithinTheirBundleResourceGroup-->


	<!--RULE -->
<xsl:template match="ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType='Bundle']/ReleaseDetailsByTerritory/ResourceGroup/ResourceGroup" priority="1000" mode="M8"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType='Bundle']/ReleaseDetailsByTerritory/ResourceGroup/ResourceGroup"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="descendant::ResourceGroupContentItem[(ResourceType = 'Video' or ResourceType = 'SoundRecording') and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource'] and SequenceNumber = '1']"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="descendant::ResourceGroupContentItem[(ResourceType = 'Video' or ResourceType = 'SoundRecording') and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource'] and SequenceNumber = '1']"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
				All Primary Resources should be sequenced in the context of their track bundle ResourceGroup (i.e. the sequence restarts with the next track bundle)
			</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/></xsl:template><xsl:template match="text()" priority="-1" mode="M8"/><xsl:template match="@*|node()" priority="-2" mode="M8"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/></xsl:template>

<!--PATTERN SoundRecordingMustHaveReferenceTitle-->


	<!--RULE -->
<xsl:template match="ernm:NewReleaseMessage/ResourceList/SoundRecording" priority="1000" mode="M9"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ernm:NewReleaseMessage/ResourceList/SoundRecording"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="count(ReferenceTitle[TitleText != '']) = 1"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ReferenceTitle[TitleText != '']) = 1"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
				A Single ReferenceTitle must be provided for each SoundRecording
			</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/></xsl:template><xsl:template match="text()" priority="-1" mode="M9"/><xsl:template match="@*|node()" priority="-2" mode="M9"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/></xsl:template>

<!--PATTERN SingleFormalTitlePerTerritory-->


	<!--RULE -->
<xsl:template match="ernm:NewReleaseMessage/ReleaseList/Release/ReleaseDetailsByTerritory" priority="1000" mode="M10"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ernm:NewReleaseMessage/ReleaseList/Release/ReleaseDetailsByTerritory"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="count(Title[@TitleType='FormalTitle'][TitleText != '']) = 1"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(Title[@TitleType='FormalTitle'][TitleText != '']) = 1"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
				Exactly one Title of type FormalTitle shall be provided for each Territory communicated
			</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/></xsl:template><xsl:template match="text()" priority="-1" mode="M10"/><xsl:template match="@*|node()" priority="-2" mode="M10"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/></xsl:template>

<!--PATTERN SingleDisplayTitlePerTerritory-->


	<!--RULE -->
<xsl:template match="ernm:NewReleaseMessage/ReleaseList/Release/ReleaseDetailsByTerritory" priority="1000" mode="M11"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ernm:NewReleaseMessage/ReleaseList/Release/ReleaseDetailsByTerritory"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="count(Title[@TitleType='DisplayTitle'][TitleText != '']) = 1"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(Title[@TitleType='DisplayTitle'][TitleText != '']) = 1"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
				Exactly one Title of type DisplayTitle shall be provided for each Territory communicated
			</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/></xsl:template><xsl:template match="text()" priority="-1" mode="M11"/><xsl:template match="@*|node()" priority="-2" mode="M11"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/></xsl:template>

<!--PATTERN AtLeastOneDisplayArtist-->


	<!--RULE -->
<xsl:template match="ernm:NewReleaseMessage/ReleaseList/Release" priority="1000" mode="M12"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ernm:NewReleaseMessage/ReleaseList/Release"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="ReleaseDetailsByTerritory/DisplayArtist"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="ReleaseDetailsByTerritory/DisplayArtist"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
				At least one DisplayArtist shall be communicated
			</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/></xsl:template><xsl:template match="text()" priority="-1" mode="M12"/><xsl:template match="@*|node()" priority="-2" mode="M12"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/></xsl:template>

<!--PATTERN ParentalWarningMustBeSet-->


	<!--RULE -->
<xsl:template match="ernm:NewReleaseMessage" priority="1000" mode="M13"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ernm:NewReleaseMessage"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="//ParentalWarningType[string-length(normalize-space(text())) &gt; 0]"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="//ParentalWarningType[string-length(normalize-space(text())) &gt; 0]"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
				The appropriate ParentalWarningType shall be provided
			</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/></xsl:template><xsl:template match="text()" priority="-1" mode="M13"/><xsl:template match="@*|node()" priority="-2" mode="M13"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/></xsl:template>

<!--PATTERN PLineMustBeProvided-->


	<!--RULE -->
<xsl:template match="ernm:NewReleaseMessage/ReleaseList/Release" priority="1000" mode="M14"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ernm:NewReleaseMessage/ReleaseList/Release"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="PLine"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="PLine"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
				A PLine shall be provided
			</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/></xsl:template><xsl:template match="text()" priority="-1" mode="M14"/><xsl:template match="@*|node()" priority="-2" mode="M14"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/></xsl:template>

<!--PATTERN IssuingLabelMustBeProvided-->


	<!--RULE -->
<xsl:template match="ernm:NewReleaseMessage/ReleaseList/Release" priority="1000" mode="M15"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ernm:NewReleaseMessage/ReleaseList/Release"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="ReleaseDetailsByTerritory/LabelName"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="ReleaseDetailsByTerritory/LabelName"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
				Information about the issuing Label shall be communicated
			</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/></xsl:template><xsl:template match="text()" priority="-1" mode="M15"/><xsl:template match="@*|node()" priority="-2" mode="M15"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/></xsl:template>

<!--PATTERN AtLeastOneGenre-->


	<!--RULE -->
<xsl:template match="ernm:NewReleaseMessage/ReleaseList/Release" priority="1000" mode="M16"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ernm:NewReleaseMessage/ReleaseList/Release"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="ReleaseDetailsByTerritory/Genre/GenreText[string-length(normalize-space(text())) &gt; 0]"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="ReleaseDetailsByTerritory/Genre/GenreText[string-length(normalize-space(text())) &gt; 0]"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
				At least one Genre shall be provided
			</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/></xsl:template><xsl:template match="text()" priority="-1" mode="M16"/><xsl:template match="@*|node()" priority="-2" mode="M16"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/></xsl:template>

<!--PATTERN HasGridOrIcpn-->


	<!--RULE -->
<xsl:template match="ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType != 'TrackRelease' and ReleaseType != 'VideoTrackRelease']" priority="1000" mode="M17"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType != 'TrackRelease' and ReleaseType != 'VideoTrackRelease']"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="ReleaseId/GRid[string-length(normalize-space(text())) &gt; 0] | ReleaseId/ICPN[string-length(normalize-space(text())) &gt; 0]"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="ReleaseId/GRid[string-length(normalize-space(text())) &gt; 0] | ReleaseId/ICPN[string-length(normalize-space(text())) &gt; 0]"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
				The Release shall be identified by either a GRid or by an ICPN
			</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/></xsl:template><xsl:template match="text()" priority="-1" mode="M17"/><xsl:template match="@*|node()" priority="-2" mode="M17"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/></xsl:template>

<!--PATTERN PrimaryResourcesIdentifiedByISRC-->


	<!--RULE -->
<xsl:template match="//ResourceGroupContentItem/ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']" priority="1000" mode="M18"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//ResourceGroupContentItem/ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="//ResourceReference[text() = current()]/../*/ISRC[string-length(normalize-space(text())) &gt; 0]"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="//ResourceReference[text() = current()]/../*/ISRC[string-length(normalize-space(text())) &gt; 0]"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
				Primary Resources shall be identified with an ISRC
			</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/></xsl:template><xsl:template match="text()" priority="-1" mode="M18"/><xsl:template match="@*|node()" priority="-2" mode="M18"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/></xsl:template>

<!--PATTERN SecondaryResourcesIdentifiedByProprietaryId-->


	<!--RULE -->
<xsl:template match="//ResourceGroupContentItem/ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']" priority="1000" mode="M19"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//ResourceGroupContentItem/ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="//ResourceReference[text() = current()]/../*/ProprietaryId[string-length(normalize-space(text())) &gt; 0]"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="//ResourceReference[text() = current()]/../*/ProprietaryId[string-length(normalize-space(text())) &gt; 0]"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
				Secondary Resources shall be identified by a ProprietaryId
			</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/></xsl:template><xsl:template match="text()" priority="-1" mode="M19"/><xsl:template match="@*|node()" priority="-2" mode="M19"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/></xsl:template></xsl:stylesheet>