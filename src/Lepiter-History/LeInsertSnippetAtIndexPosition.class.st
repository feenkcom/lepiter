Class {
	#name : #LeInsertSnippetAtIndexPosition,
	#superclass : #LeInsertSnippetPosition,
	#instVars : [
		'index'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #printing }
LeInsertSnippetAtIndexPosition >> descriptionOn: aStream [
	aStream 
		<< 'At index: ';
		print: self index
]

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
	
	aParentContent 
		addSnippet: aChildSnippet 
		after: (aParentContent children at: self index - 1)
]

{ #category : #printing }
LeInsertSnippetAtIndexPosition >> printOn: aStream [
	super printOn: aStream.
	aStream parenthesize: [ 
		aStream  
			<< 'index: ';
			print: self index ]
]
