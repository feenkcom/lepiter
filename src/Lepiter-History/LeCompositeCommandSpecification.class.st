Class {
	#name : #LeCompositeCommandSpecification,
	#superclass : #LeCommandSpecification,
	#instVars : [
		'label'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #printing }
LeCompositeCommandSpecification >> descriptionOn: aStream [ 
	aStream 
		<< self label;
		<< ', '.
	super descriptionOn: aStream.
]

{ #category : #accessing }
LeCompositeCommandSpecification >> label [

	^ label
]

{ #category : #accessing }
LeCompositeCommandSpecification >> label: anObject [

	label := anObject
]
