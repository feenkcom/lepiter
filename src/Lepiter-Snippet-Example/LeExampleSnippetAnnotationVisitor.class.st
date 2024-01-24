Class {
	#name : #LeExampleSnippetAnnotationVisitor,
	#superclass : #Object,
	#traits : 'TLeAnnotationParseNodeVisitor',
	#classTraits : 'TLeAnnotationParseNodeVisitor classTrait',
	#instVars : [
		'exampleSnippet'
	],
	#category : #'Lepiter-Snippet-Example-Snippet'
}

{ #category : #accessing }
LeExampleSnippetAnnotationVisitor >> exampleSnippet [
	^ exampleSnippet
]

{ #category : #accessing }
LeExampleSnippetAnnotationVisitor >> exampleSnippet: anObject [
	exampleSnippet := anObject
]

{ #category : #generated }
LeExampleSnippetAnnotationVisitor >> visitCodeExpandedArgument: aCodeExpandedArgument [
	aCodeExpandedArgument hasValidBooleanValue
		ifFalse: [ ^ self ].

	self exampleSnippet codeExpanded: aCodeExpandedArgument booleanValue
]

{ #category : #generated }
LeExampleSnippetAnnotationVisitor >> visitMethodNameArgument: aMethodNameArgument [
	| anExampleBehaviorName |

	anExampleBehaviorName := aMethodNameArgument value source asString.
	aMethodNameArgument classToken ifNotNil: [
		anExampleBehaviorName := anExampleBehaviorName, ' ', aMethodNameArgument classToken source asString ].

	self exampleSnippet exampleBehaviorName: anExampleBehaviorName asSymbol.
	self exampleSnippet exampleSelector: aMethodNameArgument methodName asSymbol
]

{ #category : #generated }
LeExampleSnippetAnnotationVisitor >> visitNoCodeArgument: aNoCodeArgument [
	aNoCodeArgument hasValidBooleanValue
		ifFalse: [ ^ self ].

	self exampleSnippet noCode: aNoCodeArgument booleanValue
]

{ #category : #generated }
LeExampleSnippetAnnotationVisitor >> visitPreviewExpandedArgument: aPreviewExpandedArgument [
	aPreviewExpandedArgument hasValidBooleanValue
		ifFalse: [ ^ self ].
	
	self exampleSnippet previewExpanded: aPreviewExpandedArgument booleanValue
]

{ #category : #generated }
LeExampleSnippetAnnotationVisitor >> visitPreviewHeightArgument: aPreviewHeightArgument [
	self exampleSnippet previewHeight: aPreviewHeightArgument integerValue
]

{ #category : #generated }
LeExampleSnippetAnnotationVisitor >> visitPreviewSelectArgument: aPreviewSelectArgument [
	self exampleSnippet previewSelectSelector: aPreviewSelectArgument selectorValue
]

{ #category : #generated }
LeExampleSnippetAnnotationVisitor >> visitPreviewShowArgument: aPreviewShowArgument [
	self exampleSnippet previewShowSelector: aPreviewShowArgument selectorValue
]
