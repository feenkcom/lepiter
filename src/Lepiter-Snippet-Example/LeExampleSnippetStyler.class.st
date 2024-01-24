Class {
	#name : #LeExampleSnippetStyler,
	#superclass : #GtCoderAstStyler,
	#traits : 'TLeAnnotationParseNodeVisitor',
	#classTraits : 'TLeAnnotationParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-Example-Snippet'
}

{ #category : #'api - styling' }
LeExampleSnippetStyler >> style: aText ast: theAst [
	text := aText.
	[ self accept: theAst ]
		ensure: [ text := nil ]
]

{ #category : #generated }
LeExampleSnippetStyler >> visitArgument: anArgument [
	self
		attributes: { BlTextForegroundAttribute color: Color veryVeryDarkGray }
		from: anArgument name startPosition
		to: anArgument name stopPosition.
]

{ #category : #generated }
LeExampleSnippetStyler >> visitCodeExpandedArgument: aCodeExpandedArgument [
	self visitArgument: aCodeExpandedArgument.
	
	self
		attributes: { BlTextForegroundAttribute color: Color red muchDarker }
		from: aCodeExpandedArgument value startPosition
		to: aCodeExpandedArgument value stopPosition
]

{ #category : #visiting }
LeExampleSnippetStyler >> visitErrorToken: anErrorToken [
	self
		attributes: { BlTextForegroundAttribute color: Color red }
		from: anErrorToken startPosition
		to: anErrorToken stopPosition
]

{ #category : #generated }
LeExampleSnippetStyler >> visitMethodNameArgument: aMethodNameArgument [
	self
		attributes: { BlTextForegroundAttribute color: Color blue muchDarker }
		from: aMethodNameArgument value startPosition
		to: aMethodNameArgument value stopPosition.
	
	self
		attributes: { BlTextForegroundAttribute color: Color black }
		from: aMethodNameArgument gtGt startPosition
		to: aMethodNameArgument gtGt stopPosition.
	
	self
		attributes: { BlTextForegroundAttribute color: Color magenta muchDarker }
		from: aMethodNameArgument selector startPosition
		to: aMethodNameArgument selector stopPosition
]

{ #category : #generated }
LeExampleSnippetStyler >> visitNoCodeArgument: aNoCodeArgument [
	self visitArgument: aNoCodeArgument.

	self
		attributes: { BlTextForegroundAttribute color: Color red muchDarker }
		from: aNoCodeArgument value startPosition
		to: aNoCodeArgument value stopPosition
]

{ #category : #generated }
LeExampleSnippetStyler >> visitPreviewExpandedArgument: aPreviewExpandedArgument [
	self visitArgument: aPreviewExpandedArgument.

	self
		attributes: { BlTextForegroundAttribute color: Color red muchDarker }
		from: aPreviewExpandedArgument value startPosition
		to: aPreviewExpandedArgument value stopPosition
]

{ #category : #generated }
LeExampleSnippetStyler >> visitPreviewHeightArgument: aPreviewHeightArgument [
	self visitArgument: aPreviewHeightArgument.

	self
		attributes: { BlTextForegroundAttribute color: Color red muchDarker }
		from: aPreviewHeightArgument value startPosition
		to: aPreviewHeightArgument value stopPosition
]

{ #category : #generated }
LeExampleSnippetStyler >> visitPreviewSelectArgument: aPreviewSelectArgument [
	self visitArgument: aPreviewSelectArgument.

	self
		attributes: { BlTextForegroundAttribute color: Color magenta muchDarker }
		from: aPreviewSelectArgument value startPosition
		to: aPreviewSelectArgument value stopPosition.
]

{ #category : #generated }
LeExampleSnippetStyler >> visitPreviewShowArgument: aPreviewShowArgument [
	self visitArgument: aPreviewShowArgument.

	self
		attributes: { BlTextForegroundAttribute color: Color magenta muchDarker }
		from: aPreviewShowArgument value startPosition
		to: aPreviewShowArgument value stopPosition.
]

{ #category : #visiting }
LeExampleSnippetStyler >> visitSmaCCError: aSmaCCError [	
	aSmaCCError
		nodesDo: [ :eachNode | self acceptNode: eachNode ]
		andTokensDo: [ :eachToken | ]
		includeErrors: true.
	aSmaCCError dismissedTokens do: [ :eachToken | self visitErrorToken: eachToken ].
	aSmaCCError errorToken ifNotNil: [ :eachToken | self visitErrorToken: eachToken ]
]
