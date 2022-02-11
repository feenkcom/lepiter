Class {
	#name : #LeDailyNoteTreeNodeModel,
	#superclass : #Object,
	#instVars : [
		'dailyNote',
		'pageTreeNodeModels'
	],
	#category : 'Lepiter-UI-Page-Tree-Nodes'
}

{ #category : #'instance creation' }
LeDailyNoteTreeNodeModel class >> forDailyNote: aDailyNote [
	^ self new
		dailyNote: aDailyNote
]

{ #category : #accessing }
LeDailyNoteTreeNodeModel class >> treeNodeInfoElementClass [
	^ LeDailyNoteInfoElement 
]

{ #category : #comparing }
LeDailyNoteTreeNodeModel >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self dailyNote = anObject dailyNote
]

{ #category : #converting }
LeDailyNoteTreeNodeModel >> asNodeViewModel [
	^ LeDailyNodeViewModel new 
			dailyNoteModel: self dailyNote
]

{ #category : #accessing }
LeDailyNoteTreeNodeModel >> childPageNodes [
	^ self pageTreeNodeModels
]

{ #category : #accessing }
LeDailyNoteTreeNodeModel >> dailyNote [
	^ dailyNote
]

{ #category : #accessing }
LeDailyNoteTreeNodeModel >> dailyNote: anObject [
	dailyNote := anObject
]

{ #category : #comparing }
LeDailyNoteTreeNodeModel >> hash [
	^ self class hash bitXor: [ 
		self dailyNote hash ]
]

{ #category : #testing }
LeDailyNoteTreeNodeModel >> isForPage [
	^ false
]

{ #category : #accessing }
LeDailyNoteTreeNodeModel >> nodeEntity [
	^ self dailyNote
]

{ #category : #accessing }
LeDailyNoteTreeNodeModel >> pageTreeNodeModels [
	^ pageTreeNodeModels ifNil: [ 
		self dailyNote children collect: [ :aPage |
			LePageTreeNodeModel forPage: aPage ] ]
]
