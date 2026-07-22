Class {
	#name : #LeSnippetWithToolbarAptitude,
	#superclass : #LeSnippetAptitude,
	#instVars : [
		'toolbarContainer',
		'toolbarElement'
	],
	#category : #'Lepiter-UI-Snippet-Looks'
}

{ #category : #private }
LeSnippetWithToolbarAptitude >> hideActions [
	super hideActions.

	toolbarContainer constraintsDo: [ :c | c grid horizontal span: 2 ].
	toolbarContainer visibility: BlVisibility hidden
]

{ #category : #initialization }
LeSnippetWithToolbarAptitude >> initialize [
	super initialize.

	toolbarElement := BlElement new size: 0@0.
	
	self
		addChange:
			(BrLookChange new
				up: [ :e | self contentContainer addChild: toolbarContainer as: #toolbarContainer ];
				down: [ :e | self contentContainer removeChild: toolbarContainer ];
				yourself).

	self addChangeAddChildAs: #(toolbarContainer toolbar) with: [ toolbarElement ].
]

{ #category : #initialization }
LeSnippetWithToolbarAptitude >> initializeElements [
	super initializeElements.
	
	self initializeToolbarContainer
]

{ #category : #initialization }
LeSnippetWithToolbarAptitude >> initializeSnippetContainer [
	snippetContainer := BlElement new
		layout: (BlLinearLayout vertical);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		clipChildren: false;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4)
]

{ #category : #initialization }
LeSnippetWithToolbarAptitude >> initializeToolbarContainer [
	toolbarContainer := BrHorizontalPane new
		preventMouseEvents;
		hMatchParent;
		vFitContent;
		alignBottomLeft;
		padding: (BlInsets top: 0 left: 3 bottom: 3 right: 3);
		constraintsDo: [ :c | c grid horizontal span: 2 ]
]

{ #category : #private }
LeSnippetWithToolbarAptitude >> showActions [
	super showActions.

	toolbarContainer constraintsDo: [ :c | c grid horizontal span: 1 ].
	toolbarContainer visibility: BlVisibility visible
]

{ #category : #accessing }
LeSnippetWithToolbarAptitude >> snippetToolbar: anElementOrNil [
	toolbarElement := anElementOrNil ifNil: [ BlElement new size: 0@0 ].
	anElementOrNil ifNil: [ toolbarContainer := BlElement new size: 0@0 ]
]
