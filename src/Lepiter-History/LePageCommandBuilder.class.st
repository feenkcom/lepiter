Class {
	#name : #LePageCommandBuilder,
	#superclass : #LeCommandBuilder,
	#category : #'Lepiter-History-Builders'
}

{ #category : #accessing }
LePageCommandBuilder >> targetPage [
	^ self targetContent
]
