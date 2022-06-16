Class {
	#name : #LePageEditCommand,
	#superclass : #Object,
	#instVars : [
		'targetPageUid'
	],
	#category : #'Lepiter-History'
}

{ #category : #printing }
LePageEditCommand >> description [
	^ String streamContents: [ :aStream |
		self descriptionOn: aStream ]
]

{ #category : #printing }
LePageEditCommand >> descriptionOn: aStream [
]

{ #category : #accessing }
LePageEditCommand >> targetPageUid [

	^ targetPageUid
]

{ #category : #accessing }
LePageEditCommand >> targetPageUid: anObject [

	targetPageUid := anObject
]
