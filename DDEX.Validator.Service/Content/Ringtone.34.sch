<schema xmlns="http://purl.oclc.org/dsdl/schematron">
	<ns prefix="ernm" uri="http://ddex.net/xml/ern/34" />	
	
	<title>Ringtone</title> 

	<pattern name="MustContainRingtoneClipSoundRecording">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="SoundRecording/SoundRecordingType[text() = 'RingtoneClip']">
				A Ringtone must contain one SoundRecording of type RingtoneClip
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainAComponentRelease">
		<rule context="ernm:NewReleaseMessage/ReleaseList">
			<assert test="Release/ReleaseType[text() = 'RingtoneRelease']">
				A Ringtone must contain one RingtoneRelease release
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainOneVideoResourceGroup">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release">
			<assert test="descendant::ResourceGroupContentItem[(ResourceType = 'Video' or ResourceType = 'SoundRecording') and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]">
				A Ringtone must contain at least one ResourceGroupContentItem of type Video or SoundRecording, marked as a PrimaryResource
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainARelatedReleaseOfTypeIsReleaseFromRelease">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release">
			<assert test="descendant::RelatedRelease[ReleaseRelationshipType = 'IsReleaseFromRelease']">
				A Ringtone must contain a RelatedRelease of type IsReleaseFromRelease
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
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release[ReleaseType='Bundle']/ReleaseDetailsByTerritory/ResourceGroup/ResourceGroup">
			<assert test="descendant::ResourceGroupContentItem[(ResourceType = 'Video' or ResourceType = 'SoundRecording') and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource'] and SequenceNumber = '1']">
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