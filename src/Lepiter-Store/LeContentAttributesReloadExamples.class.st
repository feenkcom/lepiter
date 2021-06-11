Class {
	#name : #LeContentAttributesReloadExamples,
	#superclass : #Object,
	#category : #'Lepiter-Store-Examples'
}

{ #category : #'as yet unclassified' }
LeContentAttributesReloadExamples >> attributeReloadedForTextSnippet [
	<gtExample>
	| textSnippet attributesReloader |
	textSnippet := LeTextSnippet string: '1+1'.
	attributesReloader := LeContentAttributesReloader forContent: textSnippet.
	
	self assert: attributesReloader hasChanges not.
	
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
