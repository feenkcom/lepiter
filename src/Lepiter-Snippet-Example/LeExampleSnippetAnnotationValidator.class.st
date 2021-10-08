Class {
	#name : #LeExampleSnippetAnnotationValidator,
	#superclass : #Object,
	#traits : 'TLeAnnotationParseNodeVisitor',
	#classTraits : 'TLeAnnotationParseNodeVisitor classTrait',
	#instVars : [
		'isValid'
	],
	#category : 'Lepiter-Snippet-Example-Snippet'
}

{ #category : #initialization }
LeExampleSnippetAnnotationValidator >> initialize [
	super initialize.
	
	isValid := true
]

{ #category : #accessing }
LeExampleSnippetAnnotationValidator >> isValid [
	^ isValid
]

{ #category : #accessing }
LeExampleSnippetAnnotationValidator >> validate: anAst [
	isValid := true.
	self accept: anAst.
	^ self isValid
]

{ #category : #visiting }
LeExampleSnippetAnnotationValidator >> visitCodeExpandedArgument: aCodeExpandedArgument [
	isValid := isValid and: [ aCodeExpandedArgument hasValidBooleanValue ]
]

{ #category : #generated }
LeExampleSnippetAnnotationValidator >> visitNoCodeArgument: aNoCodeArgument [
	isValid := isValid and: [ aNoCodeArgument hasValidBooleanValue ]
]

{ #category : #generated }
LeExampleSnippetAnnotationValidator >> visitPreviewExpandedArgument: aPreviewExpandedArgument [
	isValid := isValid and: [ aPreviewExpandedArgument hasValidBooleanValue ]
]
