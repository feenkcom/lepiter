Class {
	#name : #LeSnippetView,
	#superclass : #BrStencil,
	#instVars : [
		'snippetElementClass',
		'needsEmbellishments',
		'needsContentDecorationBar',
		'desiredSnippetWidth'
	],
	#category : #'Lepiter-UI-Snippet-! Views'
}

{ #category : #accessing }
LeSnippetView class >> contentPaddingLeft [
	^ 5
]

{ #category : #comparing }
LeSnippetView >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ snippetElementClass = anObject snippetElementClass
]

{ #category : #accessing }
LeSnippetView >> beDocumentWidth [
	self desiredSnippetWidth: LeSnippetDocumentWidth new
]

{ #category : #accessing }
LeSnippetView >> beFullWidth [
	self desiredSnippetWidth: LeSnippetFullWidth new
]

{ #category : #accessing }
LeSnippetView >> beParagraphWidth [
	self desiredSnippetWidth: LeSnippetParagraphWidth new
]

{ #category : #'private - accessing' }
LeSnippetView >> contentPaddingLeft [
	^ self class contentPaddingLeft
]

{ #category : #'api - instantiation' }
LeSnippetView >> create [
	<return: #Object>
	| aSnippetElement aSnippetLook anExtraLeftMargin aSnippetElementContainer |

	aSnippetElement := self snippetElementClass new.

	self needsEmbellishments
		ifFalse: [
			aSnippetElement snippetContent
				ifNotNil: [ :aSnippetContent |
					aSnippetElement addAptitude: (LeSnippetWithoutEmbellishmentsAptitude new
						snippetContent: aSnippetContent) ].
			^ aSnippetElement ].

	aSnippetLook := self newSnippetElementLook.

	anExtraLeftMargin := self needsContentDecorationBar
		ifTrue: [ self contentPaddingLeft ]
		ifFalse: [ 0 ].
	aSnippetLook margin: (BlInsets top: 3 left: anExtraLeftMargin bottom: 3 right: 0).

	aSnippetLook snippetContent: aSnippetElement snippetContent.

	self needsContentDecorationBar
		ifFalse: [ aSnippetElement alignContentLeftBy: self contentPaddingLeft ].

	aSnippetElement clipChildren: false.
	aSnippetLook snippetToolbar: aSnippetElement snippetToolbar.
	aSnippetLook sidebarStencil: (LeSnippetSidebarStencil new snippetElement: aSnippetElement).

	aSnippetElement addAptitude: aSnippetLook.
	aSnippetElement id: LeSnippetElementId.

	aSnippetElementContainer := LeSnippetContainerElement new.
	aSnippetElementContainer snippetElement: aSnippetElement.
	aSnippetElementContainer snippetMaxWidth: self desiredSnippetWidth maxWidth.

	^ aSnippetElementContainer
]

{ #category : #'private - accessing' }
LeSnippetView >> decorationBarWidth [
	^ 8
]

{ #category : #accessing }
LeSnippetView >> desiredSnippetWidth [
	^ desiredSnippetWidth
]

{ #category : #accessing }
LeSnippetView >> desiredSnippetWidth: anObject [
	desiredSnippetWidth := anObject
]

{ #category : #comparing }
LeSnippetView >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ snippetElementClass hash
]

{ #category : #initialization }
LeSnippetView >> initialize [
	super initialize.
	
	needsEmbellishments := true.
	needsContentDecorationBar := false.
	desiredSnippetWidth := LeSnippetFullWidth new
]

{ #category : #accessing }
LeSnippetView >> needsContentDecorationBar [
	^ needsContentDecorationBar
]

{ #category : #accessing }
LeSnippetView >> needsContentDecorationBar: anObject [
	needsContentDecorationBar := anObject
]

{ #category : #accessing }
LeSnippetView >> needsEmbellishments [
	^ needsEmbellishments
]

{ #category : #accessing }
LeSnippetView >> needsEmbellishments: anObject [
	needsEmbellishments := anObject
]

{ #category : #'api - instantiation' }
LeSnippetView >> newSnippetElementLook [
	^ self needsContentDecorationBar
		ifFalse: [ LeSnippetExpandableAptitude new ]
		ifTrue: [ LeSnippetExpandableWithBarAptitude new decorationBarWidth: self decorationBarWidth ]
]

{ #category : #printing }
LeSnippetView >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' of: ';
		print: snippetElementClass
]

{ #category : #accessing }
LeSnippetView >> snippetElementClass [
	^ snippetElementClass
]

{ #category : #accessing }
LeSnippetView >> snippetElementClass: anObject [
	snippetElementClass := anObject
]
