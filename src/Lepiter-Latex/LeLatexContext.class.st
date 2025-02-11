Class {
	#name : #LeLatexContext,
	#superclass : #Object,
	#instVars : [
		'writeStream'
	],
	#category : #'Lepiter-Latex-Visitors'
}

{ #category : #accessing }
LeLatexContext >> contents [
	^ writeStream contents
]

{ #category : #'initialization ' }
LeLatexContext >> initialize [
	super initialize.
	writeStream := '' writeStream
]

{ #category : #writing }
LeLatexContext >> putText: aString [
	self writeStream nextPutAll: aString
]

{ #category : #accessing }
LeLatexContext >> writeStream [
	^ writeStream
]

{ #category : #accessing }
LeLatexContext >> writeStream: anObject [
	writeStream := anObject
]
