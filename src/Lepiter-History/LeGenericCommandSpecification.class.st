Class {
	#name : #LeGenericCommandSpecification,
	#superclass : #LeCommandSpecification,
	#category : #'Lepiter-History-Commands'
}

{ #category : #printing }
LeGenericCommandSpecification >> printOn: aStream [ 
	super printOn: aStream.
	aStream parenthesize: [ 
		aStream << self commandTypeName ]
]
