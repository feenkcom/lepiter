Class {
	#name : #LeNotePlaygroundStencil,
	#superclass : #BrStencil,
	#category : #'Lepiter-Playground'
}

{ #category : #converting }
LeNotePlaygroundStencil >> asPreviewElement [
	^ (LePlayground newOn: LePlayground newBasicNotePage)
		padding: (BlInsets all: 10)
]

{ #category : #'api - instantiation' }
LeNotePlaygroundStencil >> create [
	^ LePlayground createWithNotePage
]

{ #category : #printing }
LeNotePlaygroundStencil >> gtDisplayOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #'gt-extensions' }
LeNotePlaygroundStencil >> gtSpotterActDefaultFrom: aSpotterElement [
	| aSpace |

	aSpace := BlSpace new.
	aSpace title: self name.
	aSpace icon: self icon.
	aSpace extent: 1200@600.
	aSpace addChild: self asElement.
	aSpace withHalos.
	aSpotterElement showSpace: aSpace
]

{ #category : #accessing }
LeNotePlaygroundStencil >> icon [
	^ LeIcons lepiterIcon
]

{ #category : #accessing }
LeNotePlaygroundStencil >> name [
	^ 'Note'
]
