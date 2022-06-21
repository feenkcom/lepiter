Class {
	#name : #LeContentCommand,
	#superclass : #Object,
	#instVars : [
		'uid',
		'targetContent'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #printing }
LeContentCommand >> description [
	^ String streamContents: [ :aStream |
		self descriptionOn: aStream ]
]

{ #category : #printing }
LeContentCommand >> descriptionOn: aStream [
	self subclassResponsibility
]

{ #category : #execution }
LeContentCommand >> execute [
	self subclassResponsibility
]

{ #category : #initialization }
LeContentCommand >> initialize [ 
	super initialize.
	uid := LeUID new uid: UUID new.
]

{ #category : #accessing }
LeContentCommand >> targetContent [

	^ targetContent
]

{ #category : #accessing }
LeContentCommand >> targetContent: aLeContent [

	targetContent := aLeContent
]

{ #category : #accessing }
LeContentCommand >> uid [ 
	^ uid
]
