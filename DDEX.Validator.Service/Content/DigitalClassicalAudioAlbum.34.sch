<schema xmlns="http://purl.oclc.org/dsdl/schematron">
	<ns prefix="ernm" uri="http://ddex.net/xml/ern/34" />	
	
	<title>Digital Classical Audio Album</title> 

<!-- Single | TrackRelease Specific Rules -->

	<pattern name="MustContainAtLeastOneSoundRecording">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="SoundRecording">
				A Digital Classical Audio Album must contain at least one SoundRecording
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainMusicalWorkSoundRecording">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="SoundRecording/SoundRecordingType[text() = 'MusicalWorkSoundRecording']">
				A Digital Classical Audio Album must contain at least one SoundRecording of type MusicalWorkSoundRecording
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainOneImage">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="count(Image) = 1">
				A Digital Classical Audio Album must contain one (and only one) Image
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainFrontCoverImage">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="Image/ImageType[text() = 'FrontCoverImage']">
				A Digital Classical Audio Album must contain one Image of type FrontCoverImage
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainAnAlbumOrSingleRelease">
		<rule context="ernm:NewReleaseMessage/ReleaseList">
			<assert test="Release/ReleaseType[text() = 'Album']">
				A Digital Classical Audio Album must contain one Album release
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainOneTrackRelease">
		<rule context="ernm:NewReleaseMessage/ReleaseList">
			<assert test="Release/ReleaseType[text() = 'TrackRelease']">
				A Digital Classical Audio Album must contain at least one TrackRelease
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainOneSoundRecordingResourceGroup">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Single'] | ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Album']">
			<assert test="descendant::ResourceGroupContentItem[ResourceType = 'SoundRecording' and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]">
				An Album must contain at least one ResourceGroupContentItem of type SoundRecording, marked as a PrimaryResource
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainOneImageResourceGroup">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Single'] | ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Album']">
			<assert test="descendant::ResourceGroupContentItem[ResourceType = 'Image' and ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']]">
				An Album must contain at least one ResourceGroupContentItem of type Image, marked as a SecondaryResource
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainSequencedTrackBundle">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release/*/ResourceGroup/ResourceGroup/ResourceGroupContentItem[ResourceType = 'SoundRecording' and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]">
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