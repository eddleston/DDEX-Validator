<schema xmlns="http://purl.oclc.org/dsdl/schematron">
	<ns prefix="ernm" uri="http://ddex.net/xml/2011/ern-main/33" />	
	
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

	<!-- include common Release Profile rules -->
	<include href="AllReleaseProfiles.33.sch#SoundRecordingMustHaveReferenceTitle" />
	<include href="AllReleaseProfiles.33.sch#VideoMustHaveReferenceTitle" />
	<include href="AllReleaseProfiles.33.sch#SingleFormalTitlePerTerritory" />
	<include href="AllReleaseProfiles.33.sch#SingleDisplayTitlePerTerritory" />
	<include href="AllReleaseProfiles.33.sch#AtLeastOneDisplayArtist" />
	<include href="AllReleaseProfiles.33.sch#ParentalWarningMustBeSet" />
	<include href="AllReleaseProfiles.33.sch#PLineMustBeProvided" />
	<include href="AllReleaseProfiles.33.sch#IssuingLabelMustBeProvided" />
	<include href="AllReleaseProfiles.33.sch#AtLeastOneGenre" />
	<include href="AllReleaseProfiles.33.sch#HasGridOrIcpn" />
	<include href="AllReleaseProfiles.33.sch#PrimaryResourcesIdentifiedByISRC" />
	<include href="AllReleaseProfiles.33.sch#SecondaryResourcesIdentifiedByProprietaryId" />
	<include href="AllReleaseProfiles.33.sch#MustContainOneComponentRelease" />
</schema>