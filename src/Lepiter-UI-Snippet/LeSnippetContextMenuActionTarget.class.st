Class {
	#name : #LeSnippetContextMenuActionTarget,
	#superclass : #LeSnippetActionTarget,
	#category : 'Lepiter-UI-Snippet-! View Models'
}

{ #category : #comparing }
LeSnippetContextMenuActionTarget >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #comparing }
LeSnippetContextMenuActionTarget >> hash [
	^ self class hash
]
