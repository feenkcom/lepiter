Class {
	#name : #LeContentAttributesReloadExamples,
	#superclass : #Object,
	#category : #'Lepiter-Store-Examples'
}

{ #category : #examples }
LeContentAttributesReloadExamples >> attributeReloadedForTextSnippet [
	<gtExample>
	<return: #LeContentAttributesReloader>
	| textSnippet attributesReloader |
	textSnippet := LeTextSnippet string: 'some text'.
	attributesReloader := LeContentAttributesReloader forContent: textSnippet.

	self assert: attributesReloader hasChanges not.

	^ attributesReloader
]

{ #category : #examples }
LeContentAttributesReloadExamples >> correctMappingsForTextSnippet [
	<gtExample>
	<return: #LeContentAttributesReloader>
	| attributesReloader attributeMappings |
	attributesReloader := self attributeReloadedForTextSnippet.
	attributeMappings := attributesReloader relevantAttributeMappings.

	self assert: attributeMappings size equals: 6.
	self
		assert: (attributeMappings collect: #key) sorted asArray
		equals: #(createEmail createTime editEmail editTime paragraphStyle string).

	^ attributesReloader
]

{ #category : #utiks }
LeContentAttributesReloadExamples >> newTextSnippetWithMetadataFrom: aSnippet [
	| newSnippet |
	newSnippet := LeTextSnippet new.
	newSnippet 
		createEmail: aSnippet createEmail;
		createTime: aSnippet createTime;
		editEmail: aSnippet editEmail;
		editTime: aSnippet editTime.
	^ newSnippet
]

{ #category : #examples }
LeContentAttributesReloadExamples >> reloadTextSnippetWithTextCode [
	<gtExample>
	<return: #LeTextSnippet>
	| originalSnippet changedSnippet |
	originalSnippet := LeTextSnippet string: 'some text'.
	changedSnippet := self newTextSnippetWithMetadataFrom: originalSnippet.
	changedSnippet updateString: 'some other text'.

	originalSnippet reloadFromContent: changedSnippet.

	self assert: originalSnippet string equals: 'some other text'.
	self assert: originalSnippet createEmail equals: changedSnippet createEmail.
	self assert: originalSnippet createTime equals: changedSnippet createTime.
	self assert: originalSnippet editEmail equals: changedSnippet editEmail.
	self assert: originalSnippet editTime equals: changedSnippet editTime.

	^ changedSnippet
]
