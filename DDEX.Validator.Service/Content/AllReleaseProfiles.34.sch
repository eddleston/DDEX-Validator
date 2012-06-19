<schema xmlns="http://purl.oclc.org/dsdl/schematron">
	<ns prefix="ernm" uri="http://ddex.net/xml/ern/34" />	

	<title>Release Profile Common Rules</title> 

	<pattern id="SoundRecordingMustHaveReferenceTitle">
		<rule context="ernm:NewReleaseMessage/ResourceList/SoundRecording">
			<assert test="count(ReferenceTitle[string-length(normalize-space(TitleText)) &gt; 0]) = 1">
				A Single ReferenceTitle must be provided for each SoundRecording
			</assert>
		</rule>
	</pattern>
	<pattern id="VideoMustHaveReferenceTitle">
		<rule context="ernm:NewReleaseMessage/ResourceList/Video">
			<assert test="count(ReferenceTitle[string-length(normalize-space(TitleText)) &gt; 0]) = 1">
				A Single ReferenceTitle must be provided for each Video
			</assert>
		</rule>
	</pattern>
	<pattern id="SingleFormalTitlePerTerritory">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release/ReleaseDetailsByTerritory[1]">
			<assert test="Title[@TitleType='FormalTitle'][string-length(normalize-space(TitleText)) &gt; 0]">
				At least one Title of type FormalTitle shall be provided for the default Worldwide ReleaseDetailsByTerritory section
			</assert>
		</rule>
	</pattern>
	<pattern id="SingleDisplayTitlePerTerritory">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release/ReleaseDetailsByTerritory[1]">
			<assert test="Title[@TitleType='DisplayTitle'][string-length(normalize-space(TitleText)) &gt; 0]">
				At least one Title of type DisplayTitle shall be provided for the default Worldwide ReleaseDetailsByTerritory section
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
		<rule context="//ResourceGroupContentItem[ResourceType = 'SoundRecording']/ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']">
			<assert test="//ResourceReference[text() = current()]/../*/ISRC[string-length(normalize-space(text())) &gt; 0]">
				Primary SoundRecording Resources shall be identified with an ISRC
			</assert>
		</rule>
	</pattern>
  <pattern id="PrimaryVideoResourcesIdentifiedByISRC">
    <rule context="//ResourceGroupContentItem[ResourceType = 'Video']/ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']">
      <assert flag="warning" test="//ResourceReference[text() = current()]/../*/ISRC[string-length(normalize-space(text())) &gt; 0]">
        Primary Video Resources should be identified with an ISRC
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
	<pattern id="MustContainOneComponentRelease">
		<rule context="ernm:NewReleaseMessage/ReleaseList/Release[1]/descendant::ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]">
			<assert test="//Release[ReleaseType[(text() = 'TrackRelease') or (text() = 'VideoTrackRelease')]]/ReleaseResourceReferenceList/ReleaseResourceReference = ./ReleaseResourceReference"> <!---->
				One component release should be supplied per primary resource referenced on the Main release, regardless of whether there are any deals available for the component release
			</assert>
		</rule>
	</pattern>
</schema>