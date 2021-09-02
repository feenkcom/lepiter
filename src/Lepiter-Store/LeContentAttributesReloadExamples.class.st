Class {
	#name : 'LeContentAttributesReloadExamples',
	#superclass : 'Object',
	#category : 'Lepiter-Store-Examples'
}

{ #category : 'examples' }
LeContentAttributesReloadExamples >> attributeReloadedForTextSnippet [
	<gtExample>
	| textSnippet attributesReloader |
	textSnippet := LeTextSnippet string: 'some text'.
	attributesReloader := LeContentAttributesReloader forContent: textSnippet.
	
	self assert: attributesReloader hasChanges not.
	
	^ attributesReloader
	
]

{ #category : 'examples' }
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
