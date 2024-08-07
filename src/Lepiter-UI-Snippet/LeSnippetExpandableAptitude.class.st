"
# Expandable snippet container look
Adds support of an optional snippet toolbar which appears below the snippet content when it gets focus.
The snippet toolbar is taken into account when calculating the height of a snippet, which means that even if the toolbar is not visible it still occupies an empty space, which may introduce a visual gap between snippets.

"
Class {
	#name : #LeSnippetExpandableAptitude,
	#superclass : #LeSnippetWithToolbarAptitude,
	#category : #'Lepiter-UI-Snippet-Looks'
}

{ #category : #private }
LeSnippetExpandableAptitude >> visuallyFocus [
	super visuallyFocus.

	snippetContainer effect: (BlGaussianShadowEffect
		color: (BrGlamorousColors primaryBorderColor)
		width: 2
		offset: 0 @ 1).
	snippetContainer background: Color white
]

{ #category : #private }
LeSnippetExpandableAptitude >> visuallyHover [
	super visuallyHover.

	snippetContainer effect: (BlGaussianShadowEffect
		color: (BrGlamorousColors defaultShadowColor)
		width: 2
		offset: 0 @ 1).
	snippetContainer background: Color white
]

{ #category : #private }
LeSnippetExpandableAptitude >> visuallyUnfocusAndUnhover [
	super visuallyUnfocusAndUnhover.

	snippetContainer effect: BlNullEffect new.
	snippetContainer background: Color transparent
]
