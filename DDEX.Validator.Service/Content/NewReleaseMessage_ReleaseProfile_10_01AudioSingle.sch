<s:schema xmlns:xs="http://www.w3.org/2001/XMLSchema"
          xmlns:s="http://purl.oclc.org/dsdl/schematron"
          queryBinding="xslt2">
   <s:title>Schematron Release Profile for 01 Audio Single (version 1.0) for the NewReleaseMessage.</s:title>
   <s:p>© 2006-2012 Digital Data Exchange, LLC (DDEX)</s:p>

   <s:pattern id="MultiProfile_MessageSchemaVersionId">
      <s:rule context="*:NewReleaseMessage">
         <s:assert test="@MessageSchemaVersionId = 'ern/341'" role="warning">ERROR regarding  Audio Single data: the MessageSchemaVersionId should be 3.4.1 ('ern/341') (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_PrimaryResourcesMustBeSequenced">
      <s:rule context="*:NewReleaseMessage/ReleaseList/Release/*/ResourceGroup/ResourceGroup/ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]">
         <s:assert test="SequenceNumber" role="error">ERROR regarding  Audio Single data: track bundle resource groups should be sequenced (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_SecondaryResourcesMustNotBeSequenced">
      <s:rule context="ResourceGroup/ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']]">
         <s:report test="SequenceNumber" role="error">ERROR regarding  Audio Single data: secondary Resources (e.g. cover images) content items shall not be sequenced (Release Profile 01, v1.0).</s:report>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_PrimaryResourcesMustBeSequencedWithinTheirGroup">
      <s:rule context="*:NewReleaseMessage/ReleaseList/Release/ReleaseDetailsByTerritory/ResourceGroup/ResourceGroup">
         <s:assert test="descendant::ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource'] and SequenceNumber = '1']"
                   role="error">ERROR regarding  Audio Single data: all Primary Resources should be sequenced in the context of their track bundle ResourceGroup (i.e. the sequence restarts with the next track bundle) (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_SoundRecordingMustHaveReferenceTitle">
      <s:rule context="*:NewReleaseMessage/ResourceList/SoundRecording">
         <s:assert test="count(ReferenceTitle[string-length(normalize-space(TitleText)) &gt; 0]) = 1"
                   role="error">ERROR regarding  Audio Single data: a Single ReferenceTitle must be provided for each SoundRecording (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_VideoMustHaveReferenceTitle">
      <s:rule context="*:NewReleaseMessage/ResourceList/Video">
         <s:assert test="count(ReferenceTitle[string-length(normalize-space(TitleText)) &gt; 0]) = 1"
                   role="error">ERROR regarding  Audio Single data: a Single ReferenceTitle must be provided for each Video (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_SingleFormalTitlePerTerritory">
      <s:rule context="*:NewReleaseMessage/ReleaseList/Release/ReleaseDetailsByTerritory[1]">
         <s:assert test="Title[@TitleType='FormalTitle'][string-length(normalize-space(TitleText)) &gt; 0]"
                   role="error">ERROR regarding  Audio Single data: at least one Title of type FormalTitle shall be provided for the default Worldwide ReleaseDetailsByTerritory section (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_SingleDisplayTitlePerTerritory">
      <s:rule context="*:NewReleaseMessage/ReleaseList/Release/ReleaseDetailsByTerritory[1]">
         <s:assert test="Title[@TitleType='DisplayTitle'][string-length(normalize-space(TitleText)) &gt; 0]"
                   role="error">ERROR regarding  Audio Single data: at least one Title of type DisplayTitle shall be provided for the default Worldwide ReleaseDetailsByTerritory section (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_DisplayArtistMustBeProvided">
      <s:rule context="*:NewReleaseMessage/ReleaseList/Release">
         <s:assert test="ReleaseDetailsByTerritory/DisplayArtist" role="error">ERROR regarding  Audio Single data: at least one DisplayArtist shall be communicated (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_ParentalWarningTypeMustBeProvided">
      <s:rule context="*:NewReleaseMessage">
         <s:assert test="//ParentalWarningType[string-length(normalize-space(text())) &gt; 0]"
                   role="error">ERROR regarding  Audio Single data: the appropriate ParentalWarningType shall be provided (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_PLineMustBeProvided">
      <s:rule context="*:NewReleaseMessage/ReleaseList/Release">
         <s:assert test="PLine" role="error">ERROR regarding  Audio Single data: a PLine shall be provided (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_LabelNameMustBeProvided">
      <s:rule context="*:NewReleaseMessage/ReleaseList/Release">
         <s:assert test="ReleaseDetailsByTerritory/LabelName" role="error">ERROR regarding  Audio Single data: information about the issuing Label shall be communicated (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_GenreMustBeProvided">
      <s:rule context="*:NewReleaseMessage/ReleaseList/Release">
         <s:assert test="ReleaseDetailsByTerritory/Genre/GenreText[string-length(normalize-space(text())) &gt; 0]"
                   role="error">ERROR regarding  Audio Single data: at least one Genre shall be provided (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_MustHaveGridOrICPN">
      <s:rule context="*:NewReleaseMessage/ReleaseList/Release[ReleaseType != 'TrackRelease' and ReleaseType != 'VideoTrackRelease']">
         <s:assert test="ReleaseId/GRid[string-length(normalize-space(text())) &gt; 0] | ReleaseId/ICPN[string-length(normalize-space(text())) &gt; 0]"
                   role="error">ERROR regarding  Audio Single data: the Release shall be identified by either a GRid or by an ICPN (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_PrimarySoundRecordingMustHaveISRC">
      <s:rule context="//ResourceGroupContentItem[ResourceType = 'SoundRecording']/ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']">
         <s:assert test="//ResourceReference[text() = current()]/../*/ISRC[string-length(normalize-space(text())) &gt; 0]"
                   role="error">ERROR regarding  Audio Single data: primary SoundRecording Resources shall be identified with an ISRC (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_PrimaryVideoMustHaveISRC">
      <s:rule context="//ResourceGroupContentItem[ResourceType = 'Video']/ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']">
         <s:assert test="//ResourceReference[text() = current()]/../*/ISRC[string-length(normalize-space(text())) &gt; 0]"
                   role="warning">WARNING regarding  Audio Single data: primary Video Resources should be identified with an ISRC (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_SecondaryResourceMustHaveProprietaryId">
      <s:rule context="//ResourceGroupContentItem/ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']">
         <s:assert test="//ResourceReference[text() = current()]/../*/ProprietaryId[string-length(normalize-space(text())) &gt; 0]"
                   role="error">ERROR regarding  Audio Single data: secondary Resources shall be identified by a ProprietaryId (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_MustContainComponentRelease">
      <s:rule context="*:NewReleaseMessage/ReleaseList/Release[1]/descendant::ResourceGroupContentItem[ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]">
         <s:assert test="//Release[ReleaseType[(text() = 'TrackRelease') or (text() = 'VideoTrackRelease')]]/ReleaseResourceReferenceList/ReleaseResourceReference = ./ReleaseResourceReference"
                   role="error">ERROR regarding  Audio Single data: one component release should be supplied per primary resource referenced on the Main release, regardless of whether there are any deals available for the component release (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="AudioSingle_ReleaseProfileVersionId">
      <s:rule context="*:NewReleaseMessage">
         <s:assert test="@ReleaseProfileVersionId = 'CommonReleaseTypes/10/AudioSingle'"
                   role="error">ERROR regarding  Audio Single data: the ReleaseProfileVersionId should be 'CommonReleaseTypes/10/AudioSingle' (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="AudioSingle_MustContainOneSoundRecording">
      <s:rule context="*:NewReleaseMessage/ResourceList">
         <s:assert test="count(SoundRecording) = 1" role="error">ERROR regarding  Audio Single data: an Audio Single must contain one (and only one) SoundRecording (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="AudioSingle_MustContainMusicalWorkSoundRecording">
      <s:rule context="*:NewReleaseMessage/ResourceList">
         <s:assert test="SoundRecording/SoundRecordingType[text() = 'MusicalWorkSoundRecording']"
                   role="error">ERROR regarding  Audio Single data: an Audio Single must contain one SoundRecording of type MusicalWorkSoundRecording (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_MustContainOneImage">
      <s:rule context="*:NewReleaseMessage/ResourceList">
         <s:assert test="count(Image) = 1" role="error">ERROR regarding  Audio Single data: a <s:value-of select="../ReleaseList/Release/ReleaseType"/> must contain one (and only one) Image (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="MultiProfile_MustContainFrontCoverImage">
      <s:rule context="*:NewReleaseMessage/ResourceList">
         <s:assert test="Image/ImageType[text() = 'FrontCoverImage']" role="error">ERROR regarding  Audio Single data: a <s:value-of select="../ReleaseList/Release/ReleaseType"/> must contain one Image of type FrontCoverImage (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="AudioSingle_MustContainTwoReleases">
      <s:rule context="*:NewReleaseMessage/ReleaseList">
         <s:assert test="count(Release) = 2" role="error">ERROR regarding  Audio Single data: an Audio Single must contain two releases (a Single and a TrackRelease) (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="AudioSingle_MustContainSingleRelease">
      <s:rule context="*:NewReleaseMessage/ReleaseList">
         <s:assert test="Release/ReleaseType[text() = 'Single']" role="error">ERROR regarding  Audio Single data: an Audio Single must contain one Single release (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="AudioSingle_MustContainTrackRelease">
      <s:rule context="*:NewReleaseMessage/ReleaseList">
         <s:assert test="Release/ReleaseType[text() = 'TrackRelease']" role="error">ERROR regarding  Audio Single data: an Audio Single must contain one TrackRelease (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="AudioSingle_MustContainSoundRecordingResourceGroup">
      <s:rule context="*:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Single'] | *:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Album']">
         <s:assert test="descendant::ResourceGroupContentItem[ResourceType = 'SoundRecording' and ReleaseResourceReference[@ReleaseResourceType = 'PrimaryResource']]"
                   role="error">ERROR regarding  Audio Single data: a Single must contain at least one ResourceGroupContentItem of type SoundRecording, marked as a PrimaryResource (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>

   <s:pattern id="AudioSingle_MustContainImageResourceGroup">
      <s:rule context="*:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Single'] | *:NewReleaseMessage/ReleaseList/Release[ReleaseType = 'Album']">
         <s:assert test="descendant::ResourceGroupContentItem[ResourceType = 'Image' and ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']]"
                   role="error">ERROR regarding  Audio Single data: an Single must contain at least one ResourceGroupContentItem of type Image, marked as a SecondaryResource (Release Profile 01, v1.0).</s:assert>
      </s:rule>
   </s:pattern>
</s:schema>