"
! Expandable snippet container look
Adds support of an optional snippet toolbar which appears below the snippet content when it gets focus.
The snippet toolbar is taken into account when calculating the height of a snippet, which means that even if the toolbar is not visible it still occupies an empty space, which may introduce a visual gap between snippets.
"
Class {
	#name : #LeSnippetExpandableAptitude,
	#superclass : #LeSnippetAptitude,
	#instVars : [
		'toolbarContainer',
		'toolbarElement'
	],
	#category : #'Lepiter-UI-Snippet-Looks'
}

{ #category : #private }
LeSnippetExpandableAptitude >> hideActions [
	super hideActions.

	toolbarContainer constraintsDo: [ :c | c grid horizontal span: 2 ].
	toolbarContainer visibility: BlVisibility hidden.
	
	snippetContainer effect: BlNullEffect new.
	snippetContainer background: Color transparent
]

{ #category : #initialization }
LeSnippetExpandableAptitude >> initialize [
	super initialize.

	toolbarElement := BlElement new size: 0@0.

	self addChangeAddChildAs: #(snippetContainer toolbarContainer) with: [ toolbarContainer ].
	self addChangeAddChildAs: #(toolbarContainer toolbar) with: [ toolbarElement ].
]

{ #category : #initialization }
LeSnippetExpandableAptitude >> initializeElements [
	super initializeElements.
	
	self initializeToolbarContainer
]

{ #category : #initialization }
LeSnippetExpandableAptitude >> initializeSnippetContainer [
	snippetContainer := BlElement new
		layout: (BlLinearLayout vertical);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		clipChildren: false;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4)
]

{ #category : #initialization }
LeSnippetExpandableAptitude >> initializeToolbarContainer [
	toolbarContainer := BrHorizontalPane new
		preventMouseEvents;
		hMatchParent;
		vFitContent;
		alignBottomLeft;
		padding: (BlInsets top: 0 left: 3 bottom: 3 right: 3);
		constraintsDo: [ :c | c grid horizontal span: 2 ]
]

{ #category : #private }
LeSnippetExpandableAptitude >> showActions [
	super showActions.

	toolbarContainer constraintsDo: [ :c | c grid horizontal span: 1 ].
	toolbarContainer visibility: BlVisibility visible.

	snippetContainer effect: (BlGaussianShadowEffect
		color: (BrGlamorousColors primaryBorderColor alpha: 0.5)
		width: 2
		offset: 0 @ 1).
	snippetContainer background: Color white
]

{ #category : #accessing }
LeSnippetExpandableAptitude >> snippetToolbar: anElementOrNil [
	toolbarElement := anElementOrNil ifNil: [ BlElement new size: 0@0 ].
	anElementOrNil ifNil: [ toolbarContainer := BlElement new size: 0@0 ]
]
