"
# Expandable snippet look with a left gray side bar
Adds a decoration - a gray vertical bar to the left from the snippet content to visually mark the actual space occupied by the content of a snippet. When a snippet receives focus the toolbar appears and the left vertical bar extends to accomodate the hight of a toolbar.

"
Class {
	#name : #LeSnippetExpandableWithBarAptitude,
	#superclass : #LeSnippetExpandableAptitude,
	#instVars : [
		'snippetExpander',
		'contentContainer'
	],
	#category : #'Lepiter-UI-Snippet-Looks'
}

{ #category : #accessing }
LeSnippetExpandableWithBarAptitude >> contentContainer [
	^ contentContainer
]

{ #category : #accessing }
LeSnippetExpandableWithBarAptitude >> decorationBarWidth: aNumber [
	snippetExpander width: aNumber
]

{ #category : #initialization }
LeSnippetExpandableWithBarAptitude >> initializeSnippetContainer [
	contentContainer := BrVerticalPane new
		hMatchParent;
		clipChildren: false;
		vFitContent.

	snippetContainer := BrHorizontalPane new
		hMatchParent;
		vFitContent;
		clipChildren: false;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		addAptitude: (BrLayoutResizerAptitude new inherit: contentContainer).
	
	self initializeSnippetExpander.
	snippetContainer addChild: snippetExpander.
	snippetContainer addChild: contentContainer.
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
LeSnippetExpandableWithBarAptitude >> visuallyFocus [
	super visuallyFocus.

	snippetExpander background: (BrGlamorousColors primaryBorderColor ) gtOpaqueColorOnWhite
]

{ #category : #private }
LeSnippetExpandableWithBarAptitude >> visuallyHover [
	super visuallyHover.

	snippetExpander background: BrGlamorousColors lightBorderColor
]

{ #category : #private }
LeSnippetExpandableWithBarAptitude >> visuallyUnfocusAndUnhover [
	super visuallyUnfocusAndUnhover.

	snippetExpander background: BrGlamorousColors lightBorderColor
]
