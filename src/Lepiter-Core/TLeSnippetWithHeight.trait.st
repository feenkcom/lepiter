"
# Snippet with height
Should be used by vertically resizable snippets whose height should be preserved in a database.

Users of the {{gtClass:TLeSnippetWithHeight}} must initialize the `height` with a sensible default value.
The height is rounded to the closest integer

"
Trait {
	#name : #TLeSnippetWithHeight,
	#instVars : [
		'height'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #'api - height' }
TLeSnippetWithHeight >> hasHeight [
	<return: #Boolean>

	^ height notNil
]

{ #category : #'api - height' }
TLeSnippetWithHeight >> height [
	<return: #Number>

	^ height
]

{ #category : #'api - height' }
TLeSnippetWithHeight >> height: aNewHeight [
	| aRoundedHeight |
	
	aRoundedHeight := aNewHeight rounded.
	(self height closeTo: aRoundedHeight)
		ifTrue: [ ^ self ].

	height := aRoundedHeight.
	self notifyHeightChanged.
]

{ #category : #'api - height' }
TLeSnippetWithHeight >> notifyHeightChanged [
	self notifyAnnouncement: (LeSnippetHeightChanged new
		source: self;
		snippet: self;
		height: self height)
]
