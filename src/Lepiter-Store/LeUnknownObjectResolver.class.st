Class {
	#name : #LeUnknownObjectResolver,
	#superclass : #Object,
	#category : #'Lepiter-Store-JsonV4'
}

{ #category : #accessing }
LeUnknownObjectResolver class >> attributeKey [
	^ nil
]

{ #category : #action }
LeUnknownObjectResolver class >> resolveUnknownObject: anUnknownObject [
	^ self new resolveUnknownObject: anUnknownObject
]

{ #category : #action }
LeUnknownObjectResolver >> resolveUnknownObject: anUnknownObject [
	self subclassResponsibility
]
