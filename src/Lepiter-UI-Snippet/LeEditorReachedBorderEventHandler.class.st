Class {
	#name : #LeEditorReachedBorderEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'snippetElement'
	],
	#category : 'Lepiter-UI-Snippet-! Views'
}

{ #category : #'api - accessing' }
LeEditorReachedBorderEventHandler >> eventsToHandle [
	^ { BrTextEditorCursorReachedBoundaryEvent }
]

{ #category : #'api - event managing' }
LeEditorReachedBorderEventHandler >> handleEvent: anEvent [
	anEvent isTop
		ifTrue: [ anEvent consumed: self snippetViewModel focusPreviousSnippet ].
	anEvent isBottom
		ifTrue: [ anEvent consumed: self snippetViewModel focusNextSnippet ]
]

{ #category : #accessing }
LeEditorReachedBorderEventHandler >> snippetElement [
	^ snippetElement
]

{ #category : #accessing }
LeEditorReachedBorderEventHandler >> snippetElement: anObject [
	snippetElement := anObject
]

{ #category : #accessing }
LeEditorReachedBorderEventHandler >> snippetViewModel [
	^ self snippetElement snippetViewModel
]
