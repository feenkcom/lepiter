Class {
	#name : #LeExportResourceAssembler,
	#superclass : #Object,
	#traits : 'TExportResourceVisitor',
	#classTraits : 'TExportResourceVisitor classTrait',
	#instVars : [
		'context'
	],
	#category : #'Lepiter-HTML-! New - Support'
}

{ #category : #'api - building' }
LeExportResourceAssembler >> assemble [
	context resources do: [ :each | 
		each state isReady ifFalse: [ 
			each acceptVisitor: self ] ]
]

{ #category : #'api - initialization' }
LeExportResourceAssembler >> context: aLeHtmlContext [
	self
		assert: [ aLeHtmlContext isNotNil ]
		description: [ 'Context must be non-nil' ].
	self
		assert: [ context isNil ]
		description: [ 'Context must be initialized only once' ].
	
	context := aLeHtmlContext
]

{ #category : #'private - building' }
LeExportResourceAssembler >> newSnippetElementFor: aSnippet [
	"Prepare snippet element"

	| aViewModel aSnippetElement |
	aViewModel := aSnippet asSnippetViewModel.
	aSnippetElement := aViewModel snippetView asElement.
	aSnippetElement snippetViewModel: aViewModel.

	^ aSnippetElement
]

{ #category : #visiting }
LeExportResourceAssembler >> visitExportElementSnippetResource: aResource [
	| aSnippetElement anExporter |
	
	aResource reference exists ifTrue: [
		"Do not compute twice"
		aResource beReadyState.
		^ self
	].
	
	aResource beAssemblingState.
	
	"Prepare element"
	aSnippetElement := self newSnippetElementFor: aResource snippet.
	
	"Export"
	anExporter := LeElementToPngExporter new
		element: aSnippetElement;
		fileReference: aResource reference;
		height: aResource height;
		export.
		
	aSnippetElement snippetElement exception ifNotNil: [ :anException | 
		aResource beAssemblingException: anException.
		^ self ].
		
	aResource reference exists ifTrue: [
		aResource beReadyState.
		^ self
	].
	
	"Export failure"
	aResource beProblemMessage: 'Problem during export'
]
