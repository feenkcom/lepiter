Class {
	#name : #LePageTreeNodeModel,
	#superclass : #Object,
	#instVars : [
		'page'
	],
	#category : 'Lepiter-UI-Page-Tree-Nodes'
}

{ #category : #'instance creation' }
LePageTreeNodeModel class >> forPage: aPage [
	^ self new
		page: aPage
]

{ #category : #accessing }
LePageTreeNodeModel class >> treeNodeInfoElementClass [
	^ LePageTitleAndSummaryElement 
]

{ #category : #comparing }
LePageTreeNodeModel >> = anObject [
	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self page = anObject page
]

{ #category : #converting }
LePageTreeNodeModel >> asNodeViewModel [
	^ self page asContentUIModel
]

{ #category : #accessing }
LePageTreeNodeModel >> childPageNodes [
	^ #()
]

{ #category : #comparing }
LePageTreeNodeModel >> hash [
	^ self class hash bitXor: [ 
		self page hash ]
]

{ #category : #testing }
LePageTreeNodeModel >> isForPage [
	^ true
]

{ #category : #accessing }
LePageTreeNodeModel >> nodeEntity [
	^ self page
]

{ #category : #accessing }
LePageTreeNodeModel >> page [
	^ page
]

{ #category : #accessing }
LePageTreeNodeModel >> page: anObject [
	page := anObject
]
