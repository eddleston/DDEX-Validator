<schema xmlns="http://purl.oclc.org/dsdl/schematron">
	<ns prefix="ernm" uri="http://ddex.net/xml/2011/ern-main/33" />	
	
	<title>Single Resource Release</title> 

<!-- Single | TrackRelease Specific Rules -->

	<pattern name="MustContainOneSoundRecording">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="count(descendant::ResourceReference) = 1">
				A Single Resource Release must contain one (and only one) Resource
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainOneSingleRelease">
		<rule context="ernm:NewReleaseMessage/ReleaseList">
			<assert test="Release/ReleaseType[text() = 'SingleResourceRelease']">
				A Single Resource Release must contain one SingleResourceRelease release
			</assert>
		</rule>
	</pattern>
	<pattern name="MustNotContainSecondaryResource">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release">
			<assert test="not(descendant::ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']])">
				A Single Resource Release must not contain any Secondary Resources
			</assert>
		</rule>
	</pattern>
	<pattern name="MustNotContainReleaseResourceStructure">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release">
			<assert test="not(descendant::ResourceGroup)">
				A Single Resource Release must not contain a release resource structure
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