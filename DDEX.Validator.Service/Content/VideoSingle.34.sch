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
				A Single must contain exactly 2 releases (one main release and one component release)
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
				A Single must contain at least one ResourceGroupContentItem of type Image, marked as a VideoScreenCapture
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

	<!-- include common Release Profile rules -->
	<include href="AllReleaseProfiles.34.sch#VideoMustHaveReferenceTitle" />
	<include href="AllReleaseProfiles.34.sch#SingleFormalTitlePerTerritory" />
	<include href="AllReleaseProfiles.34.sch#SingleDisplayTitlePerTerritory" />
	<include href="AllReleaseProfiles.34.sch#AtLeastOneDisplayArtist" />
	<include href="AllReleaseProfiles.34.sch#ParentalWarningMustBeSet" />
	<include href="AllReleaseProfiles.34.sch#PLineMustBeProvided" />
	<include href="AllReleaseProfiles.34.sch#IssuingLabelMustBeProvided" />
	<include href="AllReleaseProfiles.34.sch#AtLeastOneGenre" />
	<include href="AllReleaseProfiles.34.sch#HasGridOrIcpn" />
	<include href="AllReleaseProfiles.34.sch#PrimaryResourcesIdentifiedByISRC" />
  <include href="AllReleaseProfiles.34.sch#PrimaryVideoResourcesIdentifiedByISRC" />
  <include href="AllReleaseProfiles.34.sch#SecondaryResourcesIdentifiedByProprietaryId" />
	<include href="AllReleaseProfiles.34.sch#MustContainOneComponentRelease" />
</schema>