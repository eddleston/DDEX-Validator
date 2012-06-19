<schema xmlns="http://purl.oclc.org/dsdl/schematron">
	<ns prefix="ernm" uri="http://ddex.net/xml/2011/ern-main/33" />	
	
	<title>Longform Video</title> 

	<pattern name="MustContainAtLeastOneVideo">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="Video">
				A Longform Video must contain at least one Video
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainMusicalWorkSoundRecording">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="Video/VideoType[text() = 'LongFormMusicalWorkVideo'] | Video/VideoType[text() = 'ConcertVideo'] | Video/VideoType[text() = 'Documentary']">
				A Longform Video must contain at least one Video of type LongFormMusicalWorkVideo or ConcertVideo or Documentary
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainOneImage">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="Image">
				A Longform Video must contain at least one Image
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainFrontCoverImage">
		<rule context="ernm:NewReleaseMessage/ResourceList">
			<assert test="Image/ImageType[text() = 'FrontCoverImage']">
				A Longform Video must contain one Image of type FrontCoverImage
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainALongFormMusicalWorkVideoRelease">
		<rule context="ernm:NewReleaseMessage/ReleaseList">
			<assert test="Release/ReleaseType[text() = 'LongFormMusicalWorkVideoRelease']">
				A Longform Video must contain one LongFormMusicalWorkVideoRelease
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainNoOtherReleases">
		<rule context="ernm:NewReleaseMessage/ReleaseList">
			<assert test="count(Release) = 1">
				A Longform Video must only contain one Release
			</assert>
		</rule>
	</pattern>
	<pattern name="PrimaryResourcesHaveCorrespondingCueSheet">
		<rule context="//ResourceGroupContentItem/ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']">
			<assert test="//ResourceReference[text() = current()]/../*/VideoCueSheetReference[string-length(normalize-space(text())) &gt; 0]">
				Each primary Longform video resource should have a corresponding CueSheet referenced using the VideoCueSheetReference on the resource
			</assert>
		</rule>
	</pattern>
	<pattern name="CueSheetConsistsOfOneToManyCues">
		<rule context="CueSheet">
			<assert test="Cue">
				Each CueSheet will consist of 1 to many Cues
			</assert>
		</rule>
	</pattern>
	<pattern name="CuesShouldHaveStartTimeAndDuration">
		<rule context="Cue">
			<assert test="StartTime[string-length(normalize-space(text())) &gt; 0]">
				Each Cue should have a StartTime
			</assert>
			<assert test="Duration[string-length(normalize-space(text())) &gt; 0]">
				Each Cue should have a Duration
			</assert>
		</rule>
	</pattern>
	<pattern name="CuesShouldContainISRCOrISWC">
		<rule context="Cue">
			<assert test="ReferencedCreationId/ISRC[string-length(normalize-space(text())) &gt; 0] | ReferencedCreationId/ISWC[string-length(normalize-space(text())) &gt; 0]">
				Each Cue should have an ISRC or an ISWC
			</assert>
		</rule>
	</pattern>
	<pattern name="CuesShouldHaveOneFormalTitle">
		<rule context="Cue">
			<assert test="count(ReferencedCreationTitle[@TitleType='FormalTitle']/TitleText[string-length(normalize-space(text())) &gt; 0]) = 1">
				Each Cue should have one and only one ReferencedCreationTitle of type FormalTitle
			</assert>
		</rule>
	</pattern>
	<pattern name="CuesShouldHaveADisplayTitle">
		<rule context="Cue">
			<assert test="ReferencedCreationTitle[@TitleType='DisplayTitle']/TitleText[string-length(normalize-space(text())) &gt; 0]">
				Each Cue should have a ReferencedCreationTitle of type DisplayTitle
			</assert>
		</rule>
	</pattern>
	<pattern name="CuesShouldHaveAContributor">
		<rule context="Cue">
			<assert test="ReferencedCreationContributor">
				Each Cue should have a ReferencedCreationContributor
			</assert>
		</rule>
	</pattern>
	<pattern name="CuesShouldHaveAContributor">
		<rule context="Cue">
			<assert test="ReferencedCreationContributor">
				Each Cue should have a ReferencedCreationContributor
			</assert>
		</rule>
	</pattern>
	<pattern name="CuesShouldHaveMusicalContent">
		<rule context="Cue">
			<assert test="HasMusicalContent[lower-case(text()) = 'true']">
				Each Cue should have a HasMusicalContent flag = True
			</assert>
		</rule>
	</pattern>
	<pattern name="CuesShouldHavePLine">
		<rule context="Cue">
			<assert test="PLine">
				Each Cue should have a PLine
			</assert>
		</rule>
	</pattern>
	<pattern name="CuesShouldHaveCLine">
		<rule context="Cue">
			<assert test="CLine">
				Each Cue should have a CLine
			</assert>
		</rule>
	</pattern>
	<pattern name="CollectionItemsShouldBeVideoChapter">
		<rule context="Collection">
			<assert test="CollectionType[text() = 'VideoChapter']">
				Each Collection item should have the CollectionType VideoChapter
			</assert>
		</rule>
	</pattern>
	<pattern name="CollectionItemsShouldHaveProprietaryId">
		<rule context="Collection">
			<assert test="CollectionId/ProprietaryId[string-length(normalize-space(text())) &gt; 0]">
				Each Collection item should have a Proprietary CollectionId
			</assert>
		</rule>
	</pattern>
	<pattern name="CollectionItemsShouldHaveOneTitle">
		<rule context="Collection">
			<assert test="Title">
				Each Collection item should have a Title
			</assert>
		</rule>
	</pattern>
	<pattern name="CollectionItemsShouldHaveIsCompleteFlag">
		<rule context="Collection">
			<assert test="IsComplete[lower-case(text()) = 'true']">
				Each Collection item should have an IsComplete flag = True
			</assert>
		</rule>
	</pattern>
	<pattern name="CollectionItemsShouldReferenceAPrimaryVideo">
		<rule context="Collection/CollectionResourceReferenceList/*/CollectionResourceReference">
			<assert test="//ResourceGroupContentItem/ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource' and text() = current()]">
				Each Collection item should have a CollectionResourceReferenceList containing one reference to the Video representing the primary resource on the Longform release
			</assert>
		</rule>
	</pattern>
	<pattern name="PrimaryVideoResourceShouldHaveASoundRecordingCollectionReferenceForEachVideoChapter">
		<rule context="Video[ResourceReference = //ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]/VideoCollectionReferenceList/SoundRecordingCollectionReference/SoundRecordingCollectionReference">
			<assert test="//Collection[CollectionType='VideoChapter' and CollectionReference[text() = current()]]/CollectionResourceReferenceList/*/CollectionResourceReference[text() = current()/../../../ResourceReference]">
				The primary Video resource should have a SoundRecordingCollectionReference for each VideoChapter collection item
			</assert>
		</rule>
	</pattern>
	<pattern name="SoundRecordingCollectionReferencesOnThePrimaryVideoResourceShouldHaveStartTime">
		<rule context="Video[ResourceReference = //ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]/VideoCollectionReferenceList/SoundRecordingCollectionReference">
			<assert test="StartTime[string-length(normalize-space(text())) &gt; 0]">
				Each SoundRecordingCollectionReference on the primary Video resource should have a StartTime indicating the chapter start time on the Video
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainOneVideoResourceGroup">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release">
			<assert test="descendant::ResourceGroupContentItem[ResourceType = 'Video' and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]">
				A Longform Video must contain at least one ResourceGroupContentItem of type Video, marked as a PrimaryResource
			</assert>
		</rule>
	</pattern>
	<pattern name="MustContainOneImageResourceGroup">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release">
			<assert test="descendant::ResourceGroupContentItem[ResourceType = 'Image' and ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']]">
				A Longform Video must contain at least one ResourceGroupContentItem of type Image, marked as a SecondaryResource
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