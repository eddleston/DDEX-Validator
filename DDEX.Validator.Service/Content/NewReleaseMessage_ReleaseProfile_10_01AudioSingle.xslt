<?xml version="1.0" encoding="UTF-8" standalone="yes"?><xsl:stylesheet xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:saxon="http://saxon.sf.net/" xmlns:schold="http://www.ascc.net/xml/schematron" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema" version="2.0"><!--Implementers: please note that overriding process-prolog or process-root is 
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
<xsl:template match="*" mode="schematron-get-full-path"><xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/><xsl:text>/</xsl:text><xsl:choose><xsl:when test="namespace-uri()=''"><xsl:value-of select="name()"/></xsl:when><xsl:otherwise><xsl:text>*:</xsl:text><xsl:value-of select="local-name()"/><xsl:text>[namespace-uri()='</xsl:text><xsl:value-of select="namespace-uri()"/><xsl:text>']</xsl:text></xsl:otherwise></xsl:choose><xsl:variable name="preceding" select="count(preceding-sibling::*[local-name()=local-name(current())                                   and namespace-uri() = namespace-uri(current())])"/><xsl:text>[</xsl:text><xsl:value-of select="1+ $preceding"/><xsl:text>]</xsl:text></xsl:template><xsl:template match="@*" mode="schematron-get-full-path"><xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/><xsl:text>/</xsl:text><xsl:choose><xsl:when test="namespace-uri()=''">@<xsl:value-of select="name()"/></xsl:when><xsl:otherwise><xsl:text>@*[local-name()='</xsl:text><xsl:value-of select="local-name()"/><xsl:text>' and namespace-uri()='</xsl:text><xsl:value-of select="namespace-uri()"/><xsl:text>']</xsl:text></xsl:otherwise></xsl:choose></xsl:template>

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
<xsl:template match="/"><svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" title="Schematron Release Profile for 01 Audio Single (version 1.0) for the NewReleaseMessage." schemaVersion=""><xsl:comment><xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/></xsl:comment><svrl:text>© 2006-2012 Digital Data Exchange, LLC (DDEX)</svrl:text><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_MessageSchemaVersionId</xsl:attribute><xsl:attribute name="name">MultiProfile_MessageSchemaVersionId</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M2"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_PrimaryResourcesMustBeSequenced</xsl:attribute><xsl:attribute name="name">MultiProfile_PrimaryResourcesMustBeSequenced</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M3"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_SecondaryResourcesMustNotBeSequenced</xsl:attribute><xsl:attribute name="name">MultiProfile_SecondaryResourcesMustNotBeSequenced</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M4"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_PrimaryResourcesMustBeSequencedWithinTheirGroup</xsl:attribute><xsl:attribute name="name">MultiProfile_PrimaryResourcesMustBeSequencedWithinTheirGroup</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M5"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_SoundRecordingMustHaveReferenceTitle</xsl:attribute><xsl:attribute name="name">MultiProfile_SoundRecordingMustHaveReferenceTitle</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M6"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_VideoMustHaveReferenceTitle</xsl:attribute><xsl:attribute name="name">MultiProfile_VideoMustHaveReferenceTitle</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M7"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_SingleFormalTitlePerTerritory</xsl:attribute><xsl:attribute name="name">MultiProfile_SingleFormalTitlePerTerritory</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M8"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_SingleDisplayTitlePerTerritory</xsl:attribute><xsl:attribute name="name">MultiProfile_SingleDisplayTitlePerTerritory</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M9"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_DisplayArtistMustBeProvided</xsl:attribute><xsl:attribute name="name">MultiProfile_DisplayArtistMustBeProvided</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M10"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_ParentalWarningTypeMustBeProvided</xsl:attribute><xsl:attribute name="name">MultiProfile_ParentalWarningTypeMustBeProvided</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M11"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_PLineMustBeProvided</xsl:attribute><xsl:attribute name="name">MultiProfile_PLineMustBeProvided</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M12"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_LabelNameMustBeProvided</xsl:attribute><xsl:attribute name="name">MultiProfile_LabelNameMustBeProvided</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M13"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_GenreMustBeProvided</xsl:attribute><xsl:attribute name="name">MultiProfile_GenreMustBeProvided</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M14"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_MustHaveGridOrICPN</xsl:attribute><xsl:attribute name="name">MultiProfile_MustHaveGridOrICPN</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M15"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_PrimarySoundRecordingMustHaveISRC</xsl:attribute><xsl:attribute name="name">MultiProfile_PrimarySoundRecordingMustHaveISRC</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M16"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_PrimaryVideoMustHaveISRC</xsl:attribute><xsl:attribute name="name">MultiProfile_PrimaryVideoMustHaveISRC</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M17"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_SecondaryResourceMustHaveProprietaryId</xsl:attribute><xsl:attribute name="name">MultiProfile_SecondaryResourceMustHaveProprietaryId</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M18"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_MustContainComponentRelease</xsl:attribute><xsl:attribute name="name">MultiProfile_MustContainComponentRelease</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M19"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">AudioSingle_ReleaseProfileVersionId</xsl:attribute><xsl:attribute name="name">AudioSingle_ReleaseProfileVersionId</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M20"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">AudioSingle_MustContainOneSoundRecording</xsl:attribute><xsl:attribute name="name">AudioSingle_MustContainOneSoundRecording</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M21"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">AudioSingle_MustContainMusicalWorkSoundRecording</xsl:attribute><xsl:attribute name="name">AudioSingle_MustContainMusicalWorkSoundRecording</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M22"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_MustContainOneImage</xsl:attribute><xsl:attribute name="name">MultiProfile_MustContainOneImage</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M23"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">MultiProfile_MustContainFrontCoverImage</xsl:attribute><xsl:attribute name="name">MultiProfile_MustContainFrontCoverImage</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M24"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">AudioSingle_MustContainTwoReleases</xsl:attribute><xsl:attribute name="name">AudioSingle_MustContainTwoReleases</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M25"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">AudioSingle_MustContainSingleRelease</xsl:attribute><xsl:attribute name="name">AudioSingle_MustContainSingleRelease</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M26"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">AudioSingle_MustContainTrackRelease</xsl:attribute><xsl:attribute name="name">AudioSingle_MustContainTrackRelease</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M27"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">AudioSingle_MustContainSoundRecordingResourceGroup</xsl:attribute><xsl:attribute name="name">AudioSingle_MustContainSoundRecordingResourceGroup</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M28"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">AudioSingle_MustContainImageResourceGroup</xsl:attribute><xsl:attribute name="name">AudioSingle_MustContainImageResourceGroup</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M29"/></svrl:schematron-output></xsl:template>

<!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Schematron Release Profile for 01 Audio Single (version 1.0) for the NewReleaseMessage.</svrl:text>

<!--PATTERN MultiProfile_MessageSchemaVersionId-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage" priority="1000" mode="M2"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage"/>

		<!--ASSERT warning-->
<xsl:choose><xsl:when test="@MessageSchemaVersionId = 'ern/341'"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@MessageSchemaVersionId = 'ern/341'"><xsl:attribute name="role">warning</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: the MessageSchemaVersionId should be 3.4.1 ('ern/341') (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/></xsl:template><xsl:template match="text()" priority="-1" mode="M2"/><xsl:template match="@*|node()" priority="-2" mode="M2"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M2"/></xsl:template>

<!--PATTERN MultiProfile_PrimaryResourcesMustBeSequenced-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ReleaseList/Release/*/ResourceGroup/ResourceGroup/ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]" priority="1000" mode="M3"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ReleaseList/Release/*/ResourceGroup/ResourceGroup/ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="SequenceNumber"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="SequenceNumber"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: track bundle resource groups should be sequenced (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/></xsl:template><xsl:template match="text()" priority="-1" mode="M3"/><xsl:template match="@*|node()" priority="-2" mode="M3"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M3"/></xsl:template>

<!--PATTERN MultiProfile_SecondaryResourcesMustNotBeSequenced-->


	<!--RULE -->
<xsl:template match="ResourceGroup/ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']]" priority="1000" mode="M4"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="ResourceGroup/ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']]"/>

		<!--REPORT error-->
<xsl:if test="SequenceNumber"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="SequenceNumber"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: secondary Resources (e.g. cover images) content items shall not be sequenced (Release Profile 01, v1.0).</svrl:text></svrl:successful-report></xsl:if><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/></xsl:template><xsl:template match="text()" priority="-1" mode="M4"/><xsl:template match="@*|node()" priority="-2" mode="M4"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M4"/></xsl:template>

<!--PATTERN MultiProfile_PrimaryResourcesMustBeSequencedWithinTheirGroup-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ReleaseList/Release/ReleaseDetailsByTerritory/ResourceGroup/ResourceGroup" priority="1000" mode="M5"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ReleaseList/Release/ReleaseDetailsByTerritory/ResourceGroup/ResourceGroup"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="descendant::ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource'] and SequenceNumber = '1']"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="descendant::ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource'] and SequenceNumber = '1']"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: all Primary Resources should be sequenced in the context of their track bundle ResourceGroup (i.e. the sequence restarts with the next track bundle) (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/></xsl:template><xsl:template match="text()" priority="-1" mode="M5"/><xsl:template match="@*|node()" priority="-2" mode="M5"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/></xsl:template>

<!--PATTERN MultiProfile_SoundRecordingMustHaveReferenceTitle-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ResourceList/SoundRecording" priority="1000" mode="M6"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ResourceList/SoundRecording"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="count(ReferenceTitle[string-length(normalize-space(TitleText)) &gt; 0]) = 1"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ReferenceTitle[string-length(normalize-space(TitleText)) &gt; 0]) = 1"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: a Single ReferenceTitle must be provided for each SoundRecording (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/></xsl:template><xsl:template match="text()" priority="-1" mode="M6"/><xsl:template match="@*|node()" priority="-2" mode="M6"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/></xsl:template>

<!--PATTERN MultiProfile_VideoMustHaveReferenceTitle-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ResourceList/Video" priority="1000" mode="M7"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ResourceList/Video"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="count(ReferenceTitle[string-length(normalize-space(TitleText)) &gt; 0]) = 1"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(ReferenceTitle[string-length(normalize-space(TitleText)) &gt; 0]) = 1"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: a Single ReferenceTitle must be provided for each Video (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/></xsl:template><xsl:template match="text()" priority="-1" mode="M7"/><xsl:template match="@*|node()" priority="-2" mode="M7"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/></xsl:template>

<!--PATTERN MultiProfile_SingleFormalTitlePerTerritory-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ReleaseList/Release/ReleaseDetailsByTerritory[1]" priority="1000" mode="M8"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ReleaseList/Release/ReleaseDetailsByTerritory[1]"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="Title[@TitleType='FormalTitle'][string-length(normalize-space(TitleText)) &gt; 0]"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="Title[@TitleType='FormalTitle'][string-length(normalize-space(TitleText)) &gt; 0]"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: at least one Title of type FormalTitle shall be provided for the default Worldwide ReleaseDetailsByTerritory section (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/></xsl:template><xsl:template match="text()" priority="-1" mode="M8"/><xsl:template match="@*|node()" priority="-2" mode="M8"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/></xsl:template>

<!--PATTERN MultiProfile_SingleDisplayTitlePerTerritory-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ReleaseList/Release/ReleaseDetailsByTerritory[1]" priority="1000" mode="M9"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ReleaseList/Release/ReleaseDetailsByTerritory[1]"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="Title[@TitleType='DisplayTitle'][string-length(normalize-space(TitleText)) &gt; 0]"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="Title[@TitleType='DisplayTitle'][string-length(normalize-space(TitleText)) &gt; 0]"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: at least one Title of type DisplayTitle shall be provided for the default Worldwide ReleaseDetailsByTerritory section (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/></xsl:template><xsl:template match="text()" priority="-1" mode="M9"/><xsl:template match="@*|node()" priority="-2" mode="M9"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/></xsl:template>

<!--PATTERN MultiProfile_DisplayArtistMustBeProvided-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ReleaseList/Release" priority="1000" mode="M10"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ReleaseList/Release"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="ReleaseDetailsByTerritory/DisplayArtist"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="ReleaseDetailsByTerritory/DisplayArtist"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: at least one DisplayArtist shall be communicated (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/></xsl:template><xsl:template match="text()" priority="-1" mode="M10"/><xsl:template match="@*|node()" priority="-2" mode="M10"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/></xsl:template>

<!--PATTERN MultiProfile_ParentalWarningTypeMustBeProvided-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage" priority="1000" mode="M11"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="//ParentalWarningType[string-length(normalize-space(text())) &gt; 0]"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="//ParentalWarningType[string-length(normalize-space(text())) &gt; 0]"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: the appropriate ParentalWarningType shall be provided (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/></xsl:template><xsl:template match="text()" priority="-1" mode="M11"/><xsl:template match="@*|node()" priority="-2" mode="M11"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/></xsl:template>

<!--PATTERN MultiProfile_PLineMustBeProvided-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ReleaseList/Release" priority="1000" mode="M12"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ReleaseList/Release"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="PLine"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="PLine"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: a PLine shall be provided (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/></xsl:template><xsl:template match="text()" priority="-1" mode="M12"/><xsl:template match="@*|node()" priority="-2" mode="M12"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/></xsl:template>

<!--PATTERN MultiProfile_LabelNameMustBeProvided-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ReleaseList/Release" priority="1000" mode="M13"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ReleaseList/Release"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="ReleaseDetailsByTerritory/LabelName"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="ReleaseDetailsByTerritory/LabelName"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: information about the issuing Label shall be communicated (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/></xsl:template><xsl:template match="text()" priority="-1" mode="M13"/><xsl:template match="@*|node()" priority="-2" mode="M13"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/></xsl:template>

<!--PATTERN MultiProfile_GenreMustBeProvided-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ReleaseList/Release" priority="1000" mode="M14"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ReleaseList/Release"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="ReleaseDetailsByTerritory/Genre/GenreText[string-length(normalize-space(text())) &gt; 0]"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="ReleaseDetailsByTerritory/Genre/GenreText[string-length(normalize-space(text())) &gt; 0]"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: at least one Genre shall be provided (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/></xsl:template><xsl:template match="text()" priority="-1" mode="M14"/><xsl:template match="@*|node()" priority="-2" mode="M14"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/></xsl:template>

<!--PATTERN MultiProfile_MustHaveGridOrICPN-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ReleaseList/Release[ReleaseType != 'TrackRelease' and ReleaseType != 'VideoTrackRelease']" priority="1000" mode="M15"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ReleaseList/Release[ReleaseType != 'TrackRelease' and ReleaseType != 'VideoTrackRelease']"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="ReleaseId/GRid[string-length(normalize-space(text())) &gt; 0] | ReleaseId/ICPN[string-length(normalize-space(text())) &gt; 0]"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="ReleaseId/GRid[string-length(normalize-space(text())) &gt; 0] | ReleaseId/ICPN[string-length(normalize-space(text())) &gt; 0]"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: the Release shall be identified by either a GRid or by an ICPN (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/></xsl:template><xsl:template match="text()" priority="-1" mode="M15"/><xsl:template match="@*|node()" priority="-2" mode="M15"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/></xsl:template>

<!--PATTERN MultiProfile_PrimarySoundRecordingMustHaveISRC-->


	<!--RULE -->
<xsl:template match="//ResourceGroupContentItem[ResourceType = 'SoundRecording']/ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']" priority="1000" mode="M16"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//ResourceGroupContentItem[ResourceType = 'SoundRecording']/ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="//ResourceReference[text() = current()]/../*/ISRC[string-length(normalize-space(text())) &gt; 0]"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="//ResourceReference[text() = current()]/../*/ISRC[string-length(normalize-space(text())) &gt; 0]"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: primary SoundRecording Resources shall be identified with an ISRC (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/></xsl:template><xsl:template match="text()" priority="-1" mode="M16"/><xsl:template match="@*|node()" priority="-2" mode="M16"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/></xsl:template>

<!--PATTERN MultiProfile_PrimaryVideoMustHaveISRC-->


	<!--RULE -->
<xsl:template match="//ResourceGroupContentItem[ResourceType = 'Video']/ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']" priority="1000" mode="M17"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//ResourceGroupContentItem[ResourceType = 'Video']/ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']"/>

		<!--ASSERT warning-->
<xsl:choose><xsl:when test="//ResourceReference[text() = current()]/../*/ISRC[string-length(normalize-space(text())) &gt; 0]"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="//ResourceReference[text() = current()]/../*/ISRC[string-length(normalize-space(text())) &gt; 0]"><xsl:attribute name="role">warning</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>WARNING regarding  Audio Single data: primary Video Resources should be identified with an ISRC (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/></xsl:template><xsl:template match="text()" priority="-1" mode="M17"/><xsl:template match="@*|node()" priority="-2" mode="M17"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/></xsl:template>

<!--PATTERN MultiProfile_SecondaryResourceMustHaveProprietaryId-->


	<!--RULE -->
<xsl:template match="//ResourceGroupContentItem/ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']" priority="1000" mode="M18"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//ResourceGroupContentItem/ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="//ResourceReference[text() = current()]/../*/ProprietaryId[string-length(normalize-space(text())) &gt; 0]"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="//ResourceReference[text() = current()]/../*/ProprietaryId[string-length(normalize-space(text())) &gt; 0]"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: secondary Resources shall be identified by a ProprietaryId (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/></xsl:template><xsl:template match="text()" priority="-1" mode="M18"/><xsl:template match="@*|node()" priority="-2" mode="M18"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M18"/></xsl:template>

<!--PATTERN MultiProfile_MustContainComponentRelease-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ReleaseList/Release[1]/descendant::ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]" priority="1000" mode="M19"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ReleaseList/Release[1]/descendant::ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="//Release[ReleaseType[(text() = 'TrackRelease') or (text() = 'VideoTrackRelease')]]/ReleaseResourceReferenceList/ReleaseResourceReference = ./ReleaseResourceReference"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="//Release[ReleaseType[(text() = 'TrackRelease') or (text() = 'VideoTrackRelease')]]/ReleaseResourceReferenceList/ReleaseResourceReference = ./ReleaseResourceReference"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: one component release should be supplied per primary resource referenced on the Main release, regardless of whether there are any deals available for the component release (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/></xsl:template><xsl:template match="text()" priority="-1" mode="M19"/><xsl:template match="@*|node()" priority="-2" mode="M19"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M19"/></xsl:template>

<!--PATTERN AudioSingle_ReleaseProfileVersionId-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage" priority="1000" mode="M20"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="@ReleaseProfileVersionId = 'CommonReleaseTypes/10/AudioSingle'"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="@ReleaseProfileVersionId = 'CommonReleaseTypes/10/AudioSingle'"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: the ReleaseProfileVersionId should be 'CommonReleaseTypes/10/AudioSingle' (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M20"/></xsl:template><xsl:template match="text()" priority="-1" mode="M20"/><xsl:template match="@*|node()" priority="-2" mode="M20"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M20"/></xsl:template>

<!--PATTERN AudioSingle_MustContainOneSoundRecording-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ResourceList" priority="1000" mode="M21"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ResourceList"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="count(SoundRecording) = 1"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(SoundRecording) = 1"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: an Audio Single must contain one (and only one) SoundRecording (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M21"/></xsl:template><xsl:template match="text()" priority="-1" mode="M21"/><xsl:template match="@*|node()" priority="-2" mode="M21"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M21"/></xsl:template>

<!--PATTERN AudioSingle_MustContainMusicalWorkSoundRecording-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ResourceList" priority="1000" mode="M22"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ResourceList"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="SoundRecording/SoundRecordingType[text() = 'MusicalWorkSoundRecording']"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="SoundRecording/SoundRecordingType[text() = 'MusicalWorkSoundRecording']"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: an Audio Single must contain one SoundRecording of type MusicalWorkSoundRecording (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M22"/></xsl:template><xsl:template match="text()" priority="-1" mode="M22"/><xsl:template match="@*|node()" priority="-2" mode="M22"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M22"/></xsl:template>

<!--PATTERN MultiProfile_MustContainOneImage-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ResourceList" priority="1000" mode="M23"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ResourceList"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="count(Image) = 1"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(Image) = 1"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: a <xsl:text/><xsl:value-of select="../ReleaseList/Release/ReleaseType"/><xsl:text/> must contain one (and only one) Image (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/></xsl:template><xsl:template match="text()" priority="-1" mode="M23"/><xsl:template match="@*|node()" priority="-2" mode="M23"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M23"/></xsl:template>

<!--PATTERN MultiProfile_MustContainFrontCoverImage-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ResourceList" priority="1000" mode="M24"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ResourceList"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="Image/ImageType[text() = 'FrontCoverImage']"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="Image/ImageType[text() = 'FrontCoverImage']"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: a <xsl:text/><xsl:value-of select="../ReleaseList/Release/ReleaseType"/><xsl:text/> must contain one Image of type FrontCoverImage (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/></xsl:template><xsl:template match="text()" priority="-1" mode="M24"/><xsl:template match="@*|node()" priority="-2" mode="M24"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M24"/></xsl:template>

<!--PATTERN AudioSingle_MustContainTwoReleases-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ReleaseList" priority="1000" mode="M25"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ReleaseList"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="count(Release) = 2"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="count(Release) = 2"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: an Audio Single must contain two releases (a Single and a TrackRelease) (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M25"/></xsl:template><xsl:template match="text()" priority="-1" mode="M25"/><xsl:template match="@*|node()" priority="-2" mode="M25"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M25"/></xsl:template>

<!--PATTERN AudioSingle_MustContainSingleRelease-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ReleaseList" priority="1000" mode="M26"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ReleaseList"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="Release/ReleaseType[text() = 'Single']"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="Release/ReleaseType[text() = 'Single']"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: an Audio Single must contain one Single release (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M26"/></xsl:template><xsl:template match="text()" priority="-1" mode="M26"/><xsl:template match="@*|node()" priority="-2" mode="M26"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M26"/></xsl:template>

<!--PATTERN AudioSingle_MustContainTrackRelease-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ReleaseList" priority="1000" mode="M27"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ReleaseList"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="Release/ReleaseType[text() = 'TrackRelease']"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="Release/ReleaseType[text() = 'TrackRelease']"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: an Audio Single must contain one TrackRelease (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M27"/></xsl:template><xsl:template match="text()" priority="-1" mode="M27"/><xsl:template match="@*|node()" priority="-2" mode="M27"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M27"/></xsl:template>

<!--PATTERN AudioSingle_MustContainSoundRecordingResourceGroup-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Single'] | *:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Album']" priority="1000" mode="M28"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Single'] | *:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Album']"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="descendant::ResourceGroupContentItem[ResourceType = 'SoundRecording' and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="descendant::ResourceGroupContentItem[ResourceType = 'SoundRecording' and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: a Single must contain at least one ResourceGroupContentItem of type SoundRecording, marked as a PrimaryResource (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M28"/></xsl:template><xsl:template match="text()" priority="-1" mode="M28"/><xsl:template match="@*|node()" priority="-2" mode="M28"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M28"/></xsl:template>

<!--PATTERN AudioSingle_MustContainImageResourceGroup-->


	<!--RULE -->
<xsl:template match="*:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Single'] | *:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Album']" priority="1000" mode="M29"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Single'] | *:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Album']"/>

		<!--ASSERT error-->
<xsl:choose><xsl:when test="descendant::ResourceGroupContentItem[ResourceType = 'Image' and ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']]"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="descendant::ResourceGroupContentItem[ResourceType = 'Image' and ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']]"><xsl:attribute name="role">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>ERROR regarding  Audio Single data: an Single must contain at least one ResourceGroupContentItem of type Image, marked as a SecondaryResource (Release Profile 01, v1.0).</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M29"/></xsl:template><xsl:template match="text()" priority="-1" mode="M29"/><xsl:template match="@*|node()" priority="-2" mode="M29"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M29"/></xsl:template></xsl:stylesheet>