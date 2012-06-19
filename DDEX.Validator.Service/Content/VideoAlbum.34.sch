<schema xmlns="http://purl.oclc.org/dsdl/schematron">
	<ns prefix="ernm" uri="http://ddex.net/xml/ern/34" />	
	
	<title>Video Album</title> 

	<pattern name="MustContainAtLeastOneVideo">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="Video">
				A Video Album must contain at least one Video
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainShortFormMusicalWorkVideo">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="Video/VideoType[text() = 'ShortFormMusicalWorkVideo']">
				A Video Album must contain at least one Video of type ShortFormMusicalWorkVideo
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainOneImage">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="Image">
				A Video Album must contain at least one Image
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainFrontCoverImage">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="Image/ImageType[text() = 'FrontCoverImage']">
				A Video Album must contain one Image of type FrontCoverImage
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainAnAlbumOrSingleRelease">
		<rule context="ernm:NewReleaseMessage/ReleaseList">
			<assert test="Release/ReleaseType[text() = 'VideoAlbum']">
				A Video Album must contain one VideoAlbum release
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainOneTrackRelease">
		<rule context="ernm:NewReleaseMessage/ReleaseList">
			<assert test="Release/ReleaseType[text() = 'VideoTrackRelease']">
				A Video Album must contain at least one VideoTrackRelease
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainOneSoundRecordingResourceGroup">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'VideoAlbum']">
			<assert test="descendant::ResourceGroupContentItem[ResourceType = 'Video' and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]">
				A Video Album must contain at least one ResourceGroupContentItem of type Video, marked as a PrimaryResource
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainOneImageResourceGroup">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'VideoAlbum']">
			<assert test="descendant::ResourceGroupContentItem[ResourceType = 'Image' and ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']]">
				A Video Album must contain at least one ResourceGroupContentItem of type Image, marked as a SecondaryResource
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainSequencedTrackBundle">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release/*/ResourceGroup/ResourceGroup/ResourceGroupContentItem[ResourceType = 'Video' and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]">
			<assert test="SequenceNumber">
				Track bundle resource groups should be sequenced
			</assert>
		</rule>
	</pattern>
	<pattern name="SecondaryResourcesMustNotBeSequenced">
		<rule context="ResourceGroup/ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']]">
			<report test="SequenceNumber">
				Secondary Resources (e.g. cover images) content items shall not be sequenced
			</report>
		</rule>
	</pattern>
	<pattern name="PrimaryResourcesShouldBeSequencedWithinTheirBundleResourceGroup">
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