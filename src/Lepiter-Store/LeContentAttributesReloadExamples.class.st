Class {
	#name : #LeContentAttributesReloadExamples,
	#superclass : #Object,
	#category : #'Lepiter-Store-Examples'
}

{ #category : #'as yet unclassified' }
LeContentAttributesReloadExamples >> attributeReloadedForTextSnippet [
	<gtExample>
	| textSnippet attributesReloader |
	textSnippet := LeTextSnippet string: 'some text'.
	attributesReloader := LeContentAttributesReloader forContent: textSnippet.
	
	self assert: attributesReloader hasChanges not.
	
	^ attributesReloader
	
]

{ #category : #'as yet unclassified' }
LeContentAttributesReloadExamples >> attributesReloaderForPharoSnippet [
	<gtExample>
	| textSnippet attributesReloader |
	textSnippet := LePharoSnippet code: '1+1'.
	attributesReloader := LeContentAttributesReloader forContent: textSnippet.
	
	self assert: attributesReloader hasChanges not.
	
	^ attributesReloader
]

{ #category : #'as yet unclassified' }
LeContentAttributesReloadExamples >> correctMappingsForPharoSnippet [
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

{ #category : #'as yet unclassified' }
LeContentAttributesReloadExamples >> correctMappingsForTextSnippet [
	<gtExample>
	| attributesReloader attributeMappings |
	attributesReloader := self attributeReloadedForTextSnippet.
	attributeMappings := attributesReloader relevantAttributeMappings.
	
	self assert: attributeMappings size equals: 6.
	self 
		assert: (attributeMappings collect: #key) sorted asArray 
		equals: #(createEmail createTime editEmail editTime paragraphStyle string).
	
	^ attributesReloader
]

{ #category : #'as yet unclassified' }
LeContentAttributesReloadExamples >> reloadPharoSnippetWithChangedCode [
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
