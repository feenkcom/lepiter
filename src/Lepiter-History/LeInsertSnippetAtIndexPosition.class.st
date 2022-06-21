Class {
	#name : #LeInsertSnippetAtIndexPosition,
	#superclass : #LeInsertSnippetPosition,
	#instVars : [
		'index'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeInsertSnippetAtIndexPosition >> index [

	^ index
]

{ #category : #accessing }
LeInsertSnippetAtIndexPosition >> index: anObject [

	index := anObject
]

{ #category : #action }
LeInsertSnippetAtIndexPosition >> insertChildSnippet: aChildSnippet intoParent: aParentContent [
	
	self assert: [ self index notNil ].
	
	aParentContent hasChildren ifFalse: [ 
		aParentContent addSnippet: aChildSnippet.
		^ self ].
	self index = 1 ifTrue: [ 
		aParentContent addFirstSnippet: aChildSnippet.
		^ self ].
	
	^ aParentContent 
		addSnippet: aChildSnippet 
		after: (aParentContent children at: self index - 1)
]
