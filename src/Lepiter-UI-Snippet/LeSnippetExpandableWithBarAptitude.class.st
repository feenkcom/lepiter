"
# Expandable snippet look with a left gray side bar
Adds a decoration - a gray vertical bar to the left from the snippet content to visually mark the actual space occupied by the content of a snippet. When a snippet receives focus the toolbar appears and the left vertical bar extends to accomodate the hight of a toolbar.

"
Class {
	#name : #LeSnippetExpandableWithBarAptitude,
	#superclass : #LeSnippetExpandableAptitude,
	#instVars : [
		'snippetExpander'
	],
	#category : #'Lepiter-UI-Snippet-Looks'
}

{ #category : #private }
LeSnippetExpandableWithBarAptitude >> hideActions [
	super hideActions.
	
	snippetExpander constraintsDo: [ :c | c grid vertical span: 1 ].
	snippetExpander background: BrGlamorousColors lightBorderColor
]

{ #category : #initialization }
LeSnippetExpandableWithBarAptitude >> initializeSnippetContainer [
	snippetContainer := BlElement new
		layout: (BlGridLayout horizontal columnCount: 2);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		clipChildren: false;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	
	self initializeSnippetExpander.
	snippetContainer addChild: snippetExpander
]

{ #category : #initialization }
LeSnippetExpandableWithBarAptitude >> initializeSnippetExpander [
	snippetExpander := BlElement new
		constraintsDo: [ :c |
			c horizontal exact: 8.
			c vertical matchParent ];
		background: Color veryLightGray;
		geometry: (BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new topLeft: 4; topRight: 0; bottomRight: 0; bottomLeft: 4))
]

{ #category : #private }
LeSnippetExpandableWithBarAptitude >> showActions [
	super showActions.

	snippetExpander constraintsDo: [ :c | c grid vertical span: 2 ].
	snippetExpander background: (BrGlamorousColors primaryBorderColor alpha: 0.4) gtOpaqueColorOnWhite
]
