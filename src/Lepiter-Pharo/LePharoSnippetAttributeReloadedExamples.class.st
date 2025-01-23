Class {
	#name : #LePharoSnippetAttributeReloadedExamples,
	#superclass : #Object,
	#category : #'Lepiter-Pharo-Examples'
}

{ #category : #examples }
LePharoSnippetAttributeReloadedExamples >> attributesReloaderForPharoSnippet [
	<gtExample>
	| pharoSnippet attributesReloader |
	pharoSnippet := LePharoSnippet code: '1+1'.
	attributesReloader := LeContentAttributesReloader forContent: pharoSnippet.
	
	self assert: attributesReloader hasChanges not.
	
	^ attributesReloader
	
]

{ #category : #examples }
LePharoSnippetAttributeReloadedExamples >> correctMappingsForPharoSnippet [
	<gtExample>
	| attributesReloader attributeMappings |
	attributesReloader := self attributesReloaderForPharoSnippet.
	attributeMappings := attributesReloader relevantAttributeMappings.
	
	self assert: attributeMappings size equals: 5.
	self 
		assert: (attributeMappings collect: #key) sorted asArray 
		equals: #(code createEmail createTime editEmail editTime).
	
	^ attributesReloader
]

{ #category : #utils }
LePharoSnippetAttributeReloadedExamples >> newPharoSnippetWithMetadataFrom: aSnippet [
	| newSnippet |
	newSnippet := LePharoSnippet new.
	newSnippet 
		createEmail: aSnippet createEmail;
		createTime: aSnippet createTime;
		editEmail: aSnippet editEmail;
		editTime: aSnippet editTime.
	^ newSnippet
]

{ #category : #examples }
LePharoSnippetAttributeReloadedExamples >> reloadPharoSnippetWithChangedCode [
	<gtExample>
	| attributesReloader originalSnippet changedSnippet |
	attributesReloader := self attributesReloaderForPharoSnippet.
	originalSnippet := attributesReloader targetContent.
	changedSnippet := self newPharoSnippetWithMetadataFrom: originalSnippet.
	
	changedSnippet code: '1+41'.
	attributesReloader reloadFromContent: changedSnippet.
	
	self assert: attributesReloader hasChanges.
	self assert: attributesReloader changedAttributes size equals: 1.
	self assert: attributesReloader changedAttributes asArray equals: #(code).
	self assert: originalSnippet code equals: '1+41'.
	self assert: originalSnippet createEmail equals: changedSnippet createEmail.
	self assert: originalSnippet createTime equals: changedSnippet createTime.
	self assert: originalSnippet editEmail equals: changedSnippet editEmail.
	self assert: originalSnippet editTime equals: changedSnippet editTime.
	
	^ attributesReloader
]

{ #category : #examples }
LePharoSnippetAttributeReloadedExamples >> reloadPharoSnippetWithChangedCodeAndEditTime [
	<gtExample>
	| attributesReloader originalSnippet changedSnippet database |
	attributesReloader := self attributesReloaderForPharoSnippet.
	originalSnippet := attributesReloader targetContent.
	database := LeDatabase new.
	originalSnippet database: database.
	changedSnippet := self newPharoSnippetWithMetadataFrom: originalSnippet.
	changedSnippet database: database.
	
	changedSnippet code: '1+41'.
	attributesReloader reloadFromContent: changedSnippet.
	
	self assert: attributesReloader hasChanges.
	self assert: attributesReloader changedAttributes size equals: 2.
	self assert: attributesReloader changedAttributes asArray equals: #(code editTime).
	self assert: originalSnippet code equals: '1+41'.
	self assert: originalSnippet createEmail equals: changedSnippet createEmail.
	self assert: originalSnippet createTime equals: changedSnippet createTime.
	self assert: originalSnippet editEmail equals: changedSnippet editEmail.
	self assert: originalSnippet editTime equals: changedSnippet editTime.
	
	^ attributesReloader
]

{ #category : #examples }
LePharoSnippetAttributeReloadedExamples >> reloadPharoSnippetWithNoChange [
	<gtExample>
	| attributesReloader originalSnippet changedSnippet |
	attributesReloader := self attributesReloaderForPharoSnippet.
	originalSnippet := attributesReloader targetContent.
	changedSnippet := originalSnippet.
	
	attributesReloader reloadFromContent: originalSnippet.
	
	self assert: attributesReloader hasChanges not.
	self assert: originalSnippet code equals: '1+1'.
	self assert: originalSnippet createEmail equals: changedSnippet createEmail.
	self assert: originalSnippet createTime equals: changedSnippet createTime.
	self assert: originalSnippet editEmail equals: changedSnippet editEmail.
	self assert: originalSnippet editTime equals: changedSnippet editTime.
	
	^ attributesReloader
]
