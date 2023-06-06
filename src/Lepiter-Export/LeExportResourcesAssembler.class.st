Class {
	#name : #LeExportResourcesAssembler,
	#superclass : #Object,
	#traits : 'TLeExportResourcesAssembler + TLeExportResourceVisitor',
	#classTraits : 'TLeExportResourcesAssembler classTrait + TLeExportResourceVisitor classTrait',
	#instVars : [
		'resources',
		'condition'
	],
	#category : #'Lepiter-Export-Resources - Builders'
}

{ #category : #'api - building' }
LeExportResourcesAssembler >> assemble [
	"Assemble all non-ready resources"

	resources do: [ :each | 
		(condition canAssemble: each) ifTrue: [ 
			each acceptVisitor: self ] ]
]

{ #category : #'api - initialization' }
LeExportResourcesAssembler >> condition: aTLeExportAssembleResourceCondition [
	self
		assert: [ aTLeExportAssembleResourceCondition isNotNil ]
		description: [ 'Resource condition must be non-nil' ].

	condition := aTLeExportAssembleResourceCondition
]

{ #category : #'gt - extensions' }
LeExportResourcesAssembler >> gtResourcesFor: aView [
	<gtView>
	resources ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Resources';
		priority: 15;
		object: [ resources ];
		view: #gtResourcesFor:
]

{ #category : #initialization }
LeExportResourcesAssembler >> initialize [
	super initialize.
	
	condition := LeExportResourceReadyCondition new.
]

{ #category : #'api - initialization' }
LeExportResourcesAssembler >> resources: aLeExportResources [
	self
		assert: [ aLeExportResources isNotNil ]
		description: [ 'Resources must be non-nil' ].
	self
		assert: [ resources isNil ]
		description: [ 'Resources must be initialized only once' ].
	
	resources := aLeExportResources
]

{ #category : #visiting }
LeExportResourcesAssembler >> visitExportElementSnippetResource: aResource [
	| aSnippetElement anExporter |
	
	aResource reference exists ifTrue: [
		"Do not compute twice"
		aResource beReadyState.
		^ self
	].
	
	aResource beAssemblingState.
	
	"Prepare element"
	aSnippetElement := aResource element.
	
	"Export"
	anExporter := LeElementToPngExporter new
		element: aSnippetElement;
		fileReference: aResource reference;
		height: aResource height;
		export.
		
	aSnippetElement snippetElement exception ifNotNil: [ :anException | 
		aResource reference exists
			ifFalse: [ aResource beAssemblingException: anException ]
			ifTrue: [ aResource beAssemblingInadequateOutput: anException ].
		^ self ].
		
	aResource reference exists ifTrue: [
		aResource beReadyState.
		^ self
	].
	
	"Export failure"
	aResource beProblemMessage: 'Problem during export'
]

{ #category : #visiting }
LeExportResourcesAssembler >> visitExportExampleSnippetResource: aResource [
	| aMethod anExample anExporter |
	aResource reference exists ifTrue: [
		"Do not compute twice"
		aResource beReadyState.
		^ self
	].
	
	aResource beAssemblingState.
	
	aMethod := aResource snippet referencedExample compiledMethod.
	
	aMethod ifNil: [ 
		aResource beProblemMessage: ('Compiled method does not exist {1}'
			format: { aResource snippet referencedExample }).
		^ self
	].
	
	anExample := aMethod gtExample.
	
	anExample ifNil: [ 
		aResource beProblemMessage: ('Compiled method is not an example {1}'
			format: { aResource snippet referencedExample }).
		^ self
	].
	
	"Export"
	anExporter := LeExampleToPngExporter new
		fileReference: aResource reference;
		example: anExample ;
		height: aResource height;
		previewSelector: aResource previewShowSelector;
		withScripter;
		export.
		
	aResource reference exists ifTrue: [
		aResource beReadyState.
		^ self
	].
	
	"Export failure"
	aResource beProblemMessage: 'Problem during export'
]

{ #category : #visiting }
LeExportResourcesAssembler >> visitExportSlideResource: aResource [
	| anElement anExporter |
	aResource reference exists ifTrue: [
		"Do not compute twice"
		aResource beReadyState.
		^ self
	].
	
	aResource beAssemblingState.
	
	"Prepare slide element"
	[
		anElement := aResource slide asElement
	] on: Error do: [ :anException | 
		aResource beAssemblingException: anException.
		^ self
	].
	
	"Export"
	anExporter := LeElementToPngExporter new
		element: anElement;
		fileReference: aResource reference;
		height: aResource height;
		export.
	
	aResource reference exists ifTrue: [
		aResource beReadyState.
		^ self
	].
	
	"Export failure"
	aResource beProblemMessage: 'Problem during export'
]

{ #category : #visiting }
LeExportResourcesAssembler >> visitExportSnippetElementResource: aResource [
	| aSnippetElement anExporter |
	aResource reference exists ifTrue: [
		"Do not compute twice"
		aResource beReadyState.
		^ self
	].
	
	aResource beAssemblingState.
	
	"Prepare element"
	aSnippetElement := aResource element.
	
	"Export"
	anExporter := LeElementToPngExporter new
		element: aSnippetElement;
		fileReference: aResource reference;
		height: aResource height;
		export.
		
	aResource reference exists ifTrue: [
		aResource beReadyState.
		^ self
	].
	
	"Export failure"
	aResource beProblemMessage: 'Problem during export'
]
