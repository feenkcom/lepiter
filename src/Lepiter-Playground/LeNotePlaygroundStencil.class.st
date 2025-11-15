Class {
	#name : #LeNotePlaygroundStencil,
	#superclass : #BrStencil,
	#instVars : [
		'knowledgeBase'
	],
	#category : #'Lepiter-Playground'
}

{ #category : #converting }
LeNotePlaygroundStencil >> asPreviewElement [
	| notePage toolElement |
	notePage := LePlayground newBasicNotePage.
	toolElement := notePage asLepiterPagePhlowToolWithoutFocus 
		asElementDo: [ :e | e ].
	
	^ toolElement
		padding: (BlInsets all: 10)
]

{ #category : #'api - instantiation' }
LeNotePlaygroundStencil >> create [
	^ LePlayground createWithNotePageInKnowledgeBase: self currentKnowledgeBase
]

{ #category : #'api - instantiation' }
LeNotePlaygroundStencil >> currentKnowledgeBase [
	^ self knowledgeBase ifNil: [
		LeDatabasesRegistry uniqueInstance currentLoadedDefaultLogicalDatabase ]
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
	aSpace withCommonSettings.
	aSpotterElement showSpace: aSpace
]

{ #category : #accessing }
LeNotePlaygroundStencil >> icon [
	^ LeIcons lepiterIcon
]

{ #category : #accessing }
LeNotePlaygroundStencil >> knowledgeBase [
	^ knowledgeBase
]

{ #category : #accessing }
LeNotePlaygroundStencil >> knowledgeBase: aKnowledgeBase [
	knowledgeBase := aKnowledgeBase
]

{ #category : #accessing }
LeNotePlaygroundStencil >> name [
	^ 'Note'
]
