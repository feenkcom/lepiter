Class {
	#name : #LeContentCompositeCommandSpecification,
	#superclass : #LeCommandSpecification,
	#instVars : [
		'label'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #printing }
LeContentCompositeCommandSpecification >> descriptionOn: aStream [ 
	aStream 
		<< self label;
		<< ', '.
	super descriptionOn: aStream.
]

{ #category : #accessing }
LeContentCompositeCommandSpecification >> label [

	^ label
]

{ #category : #accessing }
LeContentCompositeCommandSpecification >> label: anObject [

	label := anObject
]
