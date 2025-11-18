Class {
	#name : #LeUnknownObjectForTestingResolver,
	#superclass : #LeUnknownObjectResolver,
	#category : #'Lepiter-Store-Examples'
}

{ #category : #accessing }
LeUnknownObjectForTestingResolver class >> attributeKey [
	^ #unknownKeyForTesting
]

{ #category : #action }
LeUnknownObjectForTestingResolver >> resolveUnknownObject: anUnknownObject [
	^ LeUnknownObjectForTesting forUnknownParsedObject: anUnknownObject 
]
