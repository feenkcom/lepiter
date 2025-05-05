Class {
	#name : #LePictureSnippetAttributeReloadedExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Picture-Examples'
}

{ #category : #examples }
LePictureSnippetAttributeReloadedExamples >> attributesReloaderForPictureSnippet [
	<gtExample>
	<return: #LeContentAttributesReloader>
	| snippet attributesReloader |
	snippet := LePictureSnippet new urlString: 'https://domain.com/picture.jpg'.
	attributesReloader := LeContentAttributesReloader forContent: snippet.

	self assert: attributesReloader hasChanges not.

	^ attributesReloader
]

{ #category : #examples }
LePictureSnippetAttributeReloadedExamples >> correctMappingsForPictureSnippet [
	<gtExample>
	<return: #LeContentAttributesReloader>
	| attributesReloader attributeMappings |
	attributesReloader := self attributesReloaderForPictureSnippet.
	attributeMappings := attributesReloader relevantAttributeMappings.

	self assert: attributeMappings size equals: 8.
	self
		assert: (attributeMappings collect: #key) sorted asArray
		equals: #(caption createEmail createTime editEmail editTime previewHeight reference urlString).

	^ attributesReloader
]

{ #category : #utils }
LePictureSnippetAttributeReloadedExamples >> newPictureSnippetWithMetadataFrom: aSnippet [
	| newSnippet |
	newSnippet := LePictureSnippet new.
	newSnippet 
		createEmail: aSnippet createEmail;
		createTime: aSnippet createTime;
		editEmail: aSnippet editEmail;
		editTime: aSnippet editTime.
	^ newSnippet
]

{ #category : #examples }
LePictureSnippetAttributeReloadedExamples >> reloadPictureSnippetWithChangedUrl [
	<gtExample>
	<return: #LeContentAttributesReloader>
	| attributesReloader originalSnippet changedSnippet |
	attributesReloader := self attributesReloaderForPictureSnippet.
	originalSnippet := attributesReloader targetContent.
	changedSnippet := self newPictureSnippetWithMetadataFrom: originalSnippet.

	changedSnippet urlString: 'https://domain.com/picture2.jpg'.
	attributesReloader reloadFromContent: changedSnippet.

	self assert: attributesReloader hasChanges.
	self assert: attributesReloader changedAttributes size equals: 1.
	self assert: attributesReloader changedAttributes asArray equals: #(urlString).
	self
		assert: originalSnippet urlString
		equals: 'https://domain.com/picture2.jpg'.
	self assert: originalSnippet createEmail equals: changedSnippet createEmail.
	self assert: originalSnippet createTime equals: changedSnippet createTime.
	self assert: originalSnippet editEmail equals: changedSnippet editEmail.
	self assert: originalSnippet editTime equals: changedSnippet editTime.

	^ attributesReloader
]

{ #category : #examples }
LePictureSnippetAttributeReloadedExamples >> reloadPictureSnippetWithNoChange [
	<gtExample>
	<return: #LeContentAttributesReloader>
	| attributesReloader originalSnippet changedSnippet |
	attributesReloader := self attributesReloaderForPictureSnippet.
	originalSnippet := attributesReloader targetContent.
	changedSnippet := originalSnippet.

	attributesReloader reloadFromContent: originalSnippet.

	self assert: attributesReloader hasChanges not.
	self assert: originalSnippet urlString equals: 'https://domain.com/picture.jpg'.
	self assert: originalSnippet createEmail equals: changedSnippet createEmail.
	self assert: originalSnippet createTime equals: changedSnippet createTime.
	self assert: originalSnippet editEmail equals: changedSnippet editEmail.
	self assert: originalSnippet editTime equals: changedSnippet editTime.

	^ attributesReloader
]
