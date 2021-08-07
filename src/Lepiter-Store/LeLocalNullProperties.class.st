Class {
	#name : #LeLocalNullProperties,
	#superclass : #LeLocalAbstractProperties,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : 'Lepiter-Store-LocalJSON-Store'
}

{ #category : #'api - testing' }
LeLocalNullProperties >> exists [
	^ false
]

{ #category : #'api - adding / removing' }
LeLocalNullProperties >> updateProperty: propertyName value: aString [
	"do nothing"
]
