Class {
	#name : #LeObjectReferenceAnnotationParserExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #examples }
LeObjectReferenceAnnotationParserExamples >> parseAllAttributes [
	<gtExample>
	<return: #LeObjectReferenceAnnotationNode>
	| anAst |
	anAst := LeObjectReferenceAnnotationParser
				parse: '24493a4a-289b-4c9f-b8d6-f905333846f3|label=#printString|expanded=true|fallbackLabelString=''fallback''|show=#gtItemsFor:|height=250'.
	self assert: anAst notNil.
	self assert: anAst items size equals: 6.
	self assert: anAst uuid equals: '24493a4a-289b-4c9f-b8d6-f905333846f3'.
	self assert: anAst labelSelector equals: 'printString'.
	self assert: anAst expandedValue equals: true.
	self assert: anAst fallbackLabelString equals: 'fallback'.
	self assert: anAst showSelector equals: 'gtItemsFor:'.
	self assert: anAst heightValue equals: 250.
	^anAst
]

{ #category : #running }
LeObjectReferenceAnnotationParserExamples >> parseFullAnnotation [
	<gtExample>
	<return: #LeObjectReferenceAnnotationNode>
	| anAst |
	anAst := LeObjectReferenceAnnotationParser
				parse: 'id=24493a4a-289b-4c9f-b8d6-f905333846f3|label=#printString|expanded=true'.
	self assert: anAst notNil.
	self assert: anAst items size equals: 3.
	self assert: anAst uuid equals: '24493a4a-289b-4c9f-b8d6-f905333846f3'.
	self assert: anAst labelSelector equals: 'printString'.
	self assert: anAst expandedValue equals: true.
	^anAst
]

{ #category : #running }
LeObjectReferenceAnnotationParserExamples >> parseNamedUuid [
	<gtExample>
	<return: #LeObjectReferenceAnnotationNode>
	| anAst |
	anAst := LeObjectReferenceAnnotationParser
				parse: 'id=24493a4a-289b-4c9f-b8d6-f905333846f3'.
	self assert: anAst notNil.
	self assert: anAst items size equals: 1.
	self assert: anAst uuid equals: '24493a4a-289b-4c9f-b8d6-f905333846f3'.
	^anAst
]

{ #category : #running }
LeObjectReferenceAnnotationParserExamples >> parseUuid [
	<gtExample>
	<return: #LeObjectReferenceAnnotationNode>
	| anAst |
	anAst := LeObjectReferenceAnnotationParser
				parse: '24493a4a-289b-4c9f-b8d6-f905333846f3'.
	self assert: anAst notNil.
	self assert: anAst items size equals: 1.
	self assert: anAst uuid equals: '24493a4a-289b-4c9f-b8d6-f905333846f3'.
	^anAst
]

{ #category : #running }
LeObjectReferenceAnnotationParserExamples >> parseUuidWithExpanded [
	<gtExample>
	<return: #LeObjectReferenceAnnotationNode>
	| anAst |
	anAst := LeObjectReferenceAnnotationParser
				parse: 'id=24493a4a-289b-4c9f-b8d6-f905333846f3|expanded=true'.
	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst uuid equals: '24493a4a-289b-4c9f-b8d6-f905333846f3'.
	self assert: anAst expandedValue equals: true.
	^anAst
]

{ #category : #running }
LeObjectReferenceAnnotationParserExamples >> parseUuidWithExpandedFalse [
	<gtExample>
	<return: #LeObjectReferenceAnnotationNode>
	| anAst |
	anAst := LeObjectReferenceAnnotationParser
				parse: 'id=24493a4a-289b-4c9f-b8d6-f905333846f3|expanded=false'.
	self assert: anAst notNil.
	self assert: anAst expandedValue equals: false.
	^anAst
]

{ #category : #examples }
LeObjectReferenceAnnotationParserExamples >> parseUuidWithFallbackLabel [
	<gtExample>
	<return: #LeObjectReferenceAnnotationNode>
	| anAst |
	anAst := LeObjectReferenceAnnotationParser
				parse: 'id=24493a4a-289b-4c9f-b8d6-f905333846f3|fallbackLabelString=''some Name'''.
	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst uuid equals: '24493a4a-289b-4c9f-b8d6-f905333846f3'.
	self assert: anAst hasFallbackLabelSpecified.
	self assert: anAst fallbackLabelString equals: 'some Name'.
	^anAst
]

{ #category : #running }
LeObjectReferenceAnnotationParserExamples >> parseUuidWithHeight [
	<gtExample>
	<return: #LeObjectReferenceAnnotationNode>
	| anAst |
	anAst := LeObjectReferenceAnnotationParser
				parse: '24493a4a-289b-4c9f-b8d6-f905333846f3|height=300'.
	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst uuid equals: '24493a4a-289b-4c9f-b8d6-f905333846f3'.
	self assert: anAst hasHeightSpecified.
	self assert: anAst heightValue equals: 300.
	^anAst
]

{ #category : #running }
LeObjectReferenceAnnotationParserExamples >> parseUuidWithLabel [
	<gtExample>
	<return: #LeObjectReferenceAnnotationNode>
	| anAst |
	anAst := LeObjectReferenceAnnotationParser
				parse: 'id=24493a4a-289b-4c9f-b8d6-f905333846f3|label=#gtDisplayString'.
	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst uuid equals: '24493a4a-289b-4c9f-b8d6-f905333846f3'.
	self assert: anAst labelSelector equals: 'gtDisplayString'.
	^anAst
]

{ #category : #running }
LeObjectReferenceAnnotationParserExamples >> parseUuidWithShow [
	<gtExample>
	<return: #LeObjectReferenceAnnotationNode>
	| anAst |
	anAst := LeObjectReferenceAnnotationParser
				parse: '24493a4a-289b-4c9f-b8d6-f905333846f3|show=#gtItemsFor:'.
	self assert: anAst notNil.
	self assert: anAst items size equals: 2.
	self assert: anAst uuid equals: '24493a4a-289b-4c9f-b8d6-f905333846f3'.
	self assert: anAst hasShowSpecified.
	self assert: anAst showSelector equals: 'gtItemsFor:'.
	^anAst
]
