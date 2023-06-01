Class {
	#name : #LeExportResourceAssembler2,
	#superclass : #Object,
	#traits : 'TLeExportResourceVisitor',
	#classTraits : 'TLeExportResourceVisitor classTrait',
	#instVars : [
		'context'
	],
	#category : #'Lepiter-HTML-! New - Support'
}

{ #category : #'api - building' }
LeExportResourceAssembler2 >> assemble [
	context resources do: [ :each | 
		each state isReady ifFalse: [ 
			each acceptVisitor: self ] ]
]

{ #category : #'api - initialization' }
LeExportResourceAssembler2 >> context: aLeHtmlContext [
	self
		assert: [ aLeHtmlContext isNotNil ]
		description: [ 'Context must be non-nil' ].
	self
		assert: [ context isNil ]
		description: [ 'Context must be initialized only once' ].
	
	context := aLeHtmlContext
]

{ #category : #'gt - extensions' }
LeExportResourceAssembler2 >> gtResourcesFor: aView [
	<gtView>
	context ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Resources';
		priority: 15;
		object: [ context ];
		view: #gtResourcesFor:
]

{ #category : #'private - building' }
LeExportResourceAssembler2 >> newSnippetElementFor: aSnippet [
	"Prepare snippet element"

	| aViewModel aSnippetElement |
	aViewModel := aSnippet asSnippetViewModel.
	aSnippetElement := aViewModel snippetView asElement.
	aSnippetElement snippetViewModel: aViewModel.

	^ aSnippetElement
]

{ #category : #visiting }
LeExportResourceAssembler2 >> visitExportElementSnippetResource: aResource [
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
