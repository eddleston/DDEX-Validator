<!-- 
	(c) 2012 Digital Data Exchange, LLC (DDEX)
	This file forms part of the DDEX Standard defining Release Profiles for Common Release Types
	
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
	<ns prefix="ernm" uri="http://ddex.net/xml/ern/34" />	
	
	<title>Mixed Media Bundle</title> 

	<pattern id="MustContainTwoDifferentResourceTypes">
		<rule context="ernm:NewReleaseMessage">
			<assert test="count(distinct-values(//ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType='PrimaryResource']]/ResourceType)) &gt; 1">
				A Mixed Media Bundle must contain at least 2 resources of different types
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainOneImage">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="Image">
				A Mixed Media Bundle must contain at least one Image
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainFrontCoverImage">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="Image/ImageType[text() = 'FrontCoverImage']">
				A Mixed Media Bundle must contain one Image of type FrontCoverImage
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainABundle">
		<rule context="ernm:NewReleaseMessage/ReleaseList">
			<assert test="Release/ReleaseType[text() = 'Bundle']">
				A Mixed Media Bundle must contain one Bundle release
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainAComponentRelease">
		<rule context="ernm:NewReleaseMessage/ReleaseList">
			<assert test="Release/ReleaseType[text() = 'TrackRelease'] | Release/ReleaseType[text() = 'VideoTrackRelease']">
				A Mixed Media Bundle must contain at least one component release (TrackRelease or VideoTrackRelease)
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainOneVideoResourceGroup">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release">
			<assert test="descendant::ResourceGroupContentItem[(ResourceType = 'Video' or ResourceType = 'SoundRecording') and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]">
				A Mixed Media Bundle must contain at least one ResourceGroupContentItem of type Video or SoundRecording, marked as a PrimaryResource
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainOneImageResourceGroup">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Bundle']">
			<assert test="descendant::ResourceGroupContentItem[ResourceType = 'Image' and ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']]">
				A Mixed Media Bundle must contain at least one ResourceGroupContentItem of type Image, marked as a SecondaryResource
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainSequencedTrackBundle">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release/*/ResourceGroup/ResourceGroup/ResourceGroupContentItem[ResourceType = 'Video' and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]">
			<assert test="SequenceNumber">
				Track bundle resource groups should be sequenced
			</assert>
		</rule>
	</pattern>
	<pattern id="SecondaryResourcesMustNotBeSequenced">
		<rule context="ResourceGroup/ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']]">
			<report test="SequenceNumber">
				Secondary Resources (e.g. cover images) content items shall not be sequenced
			</report>
		</rule>
	</pattern>
	<pattern id="PrimaryResourcesShouldBeSequencedWithinTheirBundleResourceGroup">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType='Bundle']/ReleaseDetailsByTerritory/ResourceGroup/ResourceGroup">
			<assert test="descendant::ResourceGroupContentItem[(ResourceType = 'Video' or ResourceType = 'SoundRecording') and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource'] and SequenceNumber = '1']">
				All Primary Resources should be sequenced in the context of their track bundle ResourceGroup (i.e. the sequence restarts with the next track bundle)
			</assert>
		</rule>
	</pattern>

<!-- Release Profile Rules -->

	<pattern id="SoundRecordingMustHaveReferenceTitle">
		<rule context="ernm:NewReleaseMessage/ResourceList/Video | ernm:NewReleaseMessage/ResourceList/SoundRecording">
			<assert test="count(ReferenceTitle[TitleText != '']) = 1">
				A Single ReferenceTitle must be provided for each Video or SoundRecording
			</assert>
		</rule>
	</pattern>
	<pattern id="SingleFormalTitlePerTerritory">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release/ReleaseDetailsByTerritory">
			<assert test="count(Title[@TitleType='FormalTitle'][TitleText != '']) = 1">
				Exactly one Title of type FormalTitle shall be provided for each Territory communicated
			</assert>
		</rule>
	</pattern>
	<pattern id="SingleDisplayTitlePerTerritory">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release/ReleaseDetailsByTerritory">
			<assert test="count(Title[@TitleType='DisplayTitle'][TitleText != '']) = 1">
				Exactly one Title of type DisplayTitle shall be provided for each Territory communicated
			</assert>
		</rule>
	</pattern>
	<pattern id="AtLeastOneDisplayArtist">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release">
			<assert test="ReleaseDetailsByTerritory/DisplayArtist">
				At least one DisplayArtist shall be communicated
			</assert>
		</rule>
	</pattern>
	<pattern id="ParentalWarningMustBeSet">
		<rule context="ernm:NewReleaseMessage">
			<assert test="//ParentalWarningType[string-length(normalize-space(text())) &gt; 0]">
				The appropriate ParentalWarningType shall be provided
			</assert>
		</rule>
	</pattern>
	<pattern id="PLineMustBeProvided">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release">
			<assert test="PLine">
				A PLine shall be provided
			</assert>
		</rule>
	</pattern>
	<pattern id="IssuingLabelMustBeProvided">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release">
			<assert test="ReleaseDetailsByTerritory/LabelName">
				Information about the issuing Label shall be communicated
			</assert>
		</rule>
	</pattern>
	<pattern id="AtLeastOneGenre">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release">
			<assert test="ReleaseDetailsByTerritory/Genre/GenreText[string-length(normalize-space(text())) &gt; 0]">
				At least one Genre shall be provided
			</assert>
		</rule>
	</pattern>
	<pattern id="HasGridOrIcpn">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType != 'TrackRelease' and ReleaseType != 'VideoTrackRelease']">
			<assert test="ReleaseId/GRid[string-length(normalize-space(text())) &gt; 0] | ReleaseId/ICPN[string-length(normalize-space(text())) &gt; 0]">
				The Release shall be identified by either a GRid or by an ICPN
			</assert>
		</rule>
	</pattern>
	<pattern id="PrimaryResourcesIdentifiedByISRC">
		<rule context="//ResourceGroupContentItem/ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']">
			<assert test="//ResourceReference[text() = current()]/../*/ISRC[string-length(normalize-space(text())) &gt; 0]">
				Primary Resources shall be identified with an ISRC
			</assert>
		</rule>
	</pattern>
	<pattern id="SecondaryResourcesIdentifiedByProprietaryId">
		<rule context="//ResourceGroupContentItem/ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']">
			<assert test="//ResourceReference[text() = current()]/../*/ProprietaryId[string-length(normalize-space(text())) &gt; 0]">
				Secondary Resources shall be identified by a ProprietaryId
			</assert>
		</rule>
	</pattern>
</schema>