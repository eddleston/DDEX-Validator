<schema xmlns="http://purl.oclc.org/dsdl/schematron">
	<ns prefix="ernm" uri="http://ddex.net/xml/2011/ern-main/33" />	
	
	<title>Digital Boxed Set</title> 

	<pattern id="MustContainOneImage">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="Image">
				A Digital Boxed Set must contain at least one Image
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainFrontCoverImage">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="Image/ImageType[text() = 'FrontCoverImage']">
				A Digital Boxed Set must contain at least one Image of type FrontCoverImage
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainADigitalBoxedSetRelease">
		<rule context="ernm:NewReleaseMessage/ReleaseList">
			<assert test="Release/ReleaseType[text() = 'DigitalBoxedSet']">
				A Digital Boxed Set must contain one DigitalBoxedSet release
			</assert>
		</rule>
	</pattern>
	<pattern id="MustContainAComponentRelease">
		<rule context="ernm:NewReleaseMessage/ReleaseList">
			<assert test="Release/ReleaseType[text() = 'TrackRelease'] | Release/ReleaseType[text() = 'VideoTrackRelease']">
				A Digital Boxed Set must contain at least one component release (TrackRelease or VideoTrackRelease)
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
	<include href="AllReleaseProfiles.33.sch#SoundRecordingMustHaveReferenceTitle" />
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