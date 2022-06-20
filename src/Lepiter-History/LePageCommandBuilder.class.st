Class {
	#name : #LePageCommandBuilder,
	#superclass : #LeCommandBuilder,
	#category : #'Lepiter-History'
}

{ #category : #accessing }
LePageCommandBuilder >> targetPage [
	^ self targetContent
]
