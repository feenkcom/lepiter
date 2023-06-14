Class {
	#name : #LeUuidValidator,
	#superclass : #Object,
	#category : #'Lepiter-BasicServer'
}

{ #category : #testing }
LeUuidValidator class >> isValid: aString [
	^ '[0-9a-f]{8}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{4}\-[0-9a-f]{12}' asRegex matches: aString
]
