Class {
	#name : #LeCompositeCommandSpecification,
	#superclass : #LeCommandSpecification,
	#instVars : [
		'label'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeCompositeCommandSpecification >> label [

	^ label
]

{ #category : #accessing }
LeCompositeCommandSpecification >> label: anObject [

	label := anObject
]

{ #category : #printing }
LeCompositeCommandSpecification >> printOn: aStream [ 
	super printOn: aStream.
	aStream parenthesize: [ 
		aStream << self label ]
]
