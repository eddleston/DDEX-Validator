<!-- 
	(c) 2012 Digital Data Exchange, LLC (DDEX)
	This file forms part of the DDEX Standard defining Release Profiles for Common Release Types
	
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
	<ns prefix="ernm" uri="http://ddex.net/xml/ern/34" />	
	
	<title>Video Single</title> 

	<pattern id="MustContainOneVideo">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="count(Video) = 1">
				A Video Single must contain one (and only one) Video
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainShortFormMusicalWorkVideo">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="Video/VideoType[text() = 'ShortFormMusicalWorkVideo']">
				A Video Single must contain one Video of type ShortFormMusicalWorkVideo
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainOneImage">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="count(Image) = 1">
				A Video Single must contain one (and only one) Image
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainFrontCoverImage">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="Image/ImageType[text() = 'VideoScreenCapture']">
				A Video Single must contain one Image of type VideoScreenCapture
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainTwoReleases">
		<rule context="ernm:NewReleaseMessage/ReleaseList">
			<assert test="count(Release) = 2">
				A Video Single must contain two releases (a VideoSingle and a VideoTrackRelease)
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainOneSingleRelease">
		<rule context="ernm:NewReleaseMessage/ReleaseList">
			<assert test="Release/ReleaseType[text() = 'VideoSingle']">
				A Video Single must contain one VideoSingle release
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainOneTrackRelease">
		<rule context="ernm:NewReleaseMessage/ReleaseList">
			<assert test="Release/ReleaseType[text() = 'VideoTrackRelease']">
				A Video Single must contain one VideoTrackRelease
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainARelatedReleaseOfTypeIsEquivalentToAudio">
		<rule context="ernm:NewReleaseMessage/ReleaseList">
			<assert test="descendant::RelatedRelease[ReleaseRelationshipType = 'IsEquivalentToAudio']">
				A Video Single must contain a RelatedRelease of type IsEquivalentToAudio
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainOneVideoResourceGroupContentItem">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'VideoSingle']">
			<assert test="descendant::ResourceGroupContentItem[ResourceType = 'Video' and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]">
				A Video Single must contain at least one ResourceGroupContentItem of type Video, marked as a PrimaryResource
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainOneImageResourceGroupContentItem">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'VideoSingle']">
			<assert test="descendant::ResourceGroupContentItem[ResourceType = 'Video' and LinkedReleaseResourceReference[@LinkDescription = 'VideoScreenCapture']]">
				An Single must contain at least one ResourceGroupContentItem of type Image, marked as a VideoScreenCapture
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
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release/ReleaseDetailsByTerritory/ResourceGroup/ResourceGroup">
			<assert test="descendant::ResourceGroupContentItem[ResourceType = 'Video' and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource'] and SequenceNumber = '1']">
				All Primary Resources should be sequenced in the context of their track bundle ResourceGroup (i.e. the sequence restarts with the next track bundle)
			</assert>
		</rule>
	</pattern>

<!-- Release Profile Rules -->

	<pattern id="SoundRecordingMustHaveReferenceTitle">
		<rule context="ernm:NewReleaseMessage/ResourceList/Video">
			<assert test="count(ReferenceTitle[TitleText != '']) = 1">
				A Single ReferenceTitle must be provided for each Video
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