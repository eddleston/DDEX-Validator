<schema xmlns="http://purl.oclc.org/dsdl/schematron">
	<ns prefix="ernm" uri="http://ddex.net/xml/ern/34" />	

	<title>Audio Single</title> 

<!-- Single | TrackRelease Specific Rules -->

	<pattern id="MustContainOneSoundRecording">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="count(SoundRecording) = 1">
				An Audio Single must contain one (and only one) SoundRecording
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainMusicalWorkSoundRecording">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="SoundRecording/SoundRecordingType[text() = 'MusicalWorkSoundRecording']">
				An Audio Single must contain one SoundRecording of type MusicalWorkSoundRecording
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainOneImage">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="count(Image) = 1">
				An Audio Single must contain one (and only one) Image
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainFrontCoverImage">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="Image/ImageType[text() = 'FrontCoverImage']">
				An Audio Single must contain one Image of type FrontCoverImage
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
			<assert test="Release/ReleaseType[text() = 'Single']">
				An Audio Single must contain one Single release
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainOneTrackRelease">
		<rule context="ernm:NewReleaseMessage/ReleaseList">
			<assert test="Release/ReleaseType[text() = 'TrackRelease']">
				An Audio Single must contain one TrackRelease
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainOneSoundRecordingResourceGroup">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Single'] | ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Album']">
			<assert test="descendant::ResourceGroupContentItem[ResourceType = 'SoundRecording' and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]">
				A Single must contain at least one ResourceGroupContentItem of type SoundRecording, marked as a PrimaryResource
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainOneImageResourceGroup">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Single'] | ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Album']">
			<assert test="descendant::ResourceGroupContentItem[ResourceType = 'Image' and ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']]">
				An Single must contain at least one ResourceGroupContentItem of type Image, marked as a SecondaryResource
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainSequencedTrackBundle">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release/*/ResourceGroup/ResourceGroup/ResourceGroupContentItem[ResourceType = 'SoundRecording' and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]">
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
			<assert test="descendant::ResourceGroupContentItem[ResourceType = 'SoundRecording' and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource'] and SequenceNumber = '1']">
				All Primary Resources should be sequenced in the context of their track bundle ResourceGroup (i.e. the sequence restarts with the next track bundle)
			</assert>
		</rule>
	</pattern>

	<!-- include common Release Profile rules -->
	<include href="AllReleaseProfiles.34.sch#SoundRecordingMustHaveReferenceTitle" />
	<include href="AllReleaseProfiles.34.sch#SingleFormalTitlePerTerritory" />
	<include href="AllReleaseProfiles.34.sch#SingleDisplayTitlePerTerritory" />
	<include href="AllReleaseProfiles.34.sch#AtLeastOneDisplayArtist" />
	<include href="AllReleaseProfiles.34.sch#ParentalWarningMustBeSet" />
	<include href="AllReleaseProfiles.34.sch#PLineMustBeProvided" />
	<include href="AllReleaseProfiles.34.sch#IssuingLabelMustBeProvided" />
	<include href="AllReleaseProfiles.34.sch#AtLeastOneGenre" />
	<include href="AllReleaseProfiles.34.sch#HasGridOrIcpn" />
	<include href="AllReleaseProfiles.34.sch#PrimaryResourcesIdentifiedByISRC" />
	<include href="AllReleaseProfiles.34.sch#SecondaryResourcesIdentifiedByProprietaryId" />
	<include href="AllReleaseProfiles.34.sch#MustContainOneComponentRelease" />
</schema>