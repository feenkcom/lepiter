Class {
	#name : #LeLepiterToolStencil,
	#superclass : #BrStencil,
	#instVars : [
		'knowledgeBase'
	],
	#category : #'Lepiter-Tool-Stencils'
}

{ #category : #converting }
LeLepiterToolStencil >> asPreviewElement [
	^ BlElement new
		background: Color white
]

{ #category : #'api - instantiation' }
LeLepiterToolStencil >> create [
	^ LeHomeDatabasesElement new 
		databaseViewModel: self currentKnowledgeBase asContentUIModel;
		padding: (BlInsets all: 20);
		background: BlTheme default default backdropBackground
]

{ #category : #'api - instantiation' }
LeLepiterToolStencil >> currentKnowledgeBase [
	^ self knowledgeBase ifNil: [
		LeDatabasesRegistry uniqueInstance currentLoadedDefaultLogicalDatabase ]
]

{ #category : #printing }
LeLepiterToolStencil >> gtDisplayOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #'gt-extensions' }
LeLepiterToolStencil >> gtSpotterActDefaultFrom: aSpotterElement [
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
LeLepiterToolStencil >> icon [
	^ LeIcons lepiterIcon
]

{ #category : #accessing }
LeLepiterToolStencil >> knowledgeBase [
	^ knowledgeBase
]

{ #category : #accessing }
LeLepiterToolStencil >> knowledgeBase: aKnowledgeBase [
	knowledgeBase := aKnowledgeBase
]

{ #category : #accessing }
LeLepiterToolStencil >> name [
	^ 'Lepiter'
]
