Class {
	#name : #LeContentAttributesReloadExamples,
	#superclass : #Object,
	#category : #'Lepiter-Store-Examples'
}

{ #category : #examples }
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
