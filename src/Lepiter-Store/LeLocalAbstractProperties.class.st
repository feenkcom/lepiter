Class {
	#name : #LeLocalAbstractProperties,
	#superclass : #Object,
	#category : 'Lepiter-Store-LocalJSON-Store'
}

{ #category : #'api - testing' }
LeLocalAbstractProperties >> exists [
	"Return true if a property exists, e.g., a local file that stores the properties"
	<return: #Boolean>
	^ self subclassResponsibility
]

{ #category : #'api - testing' }
LeLocalAbstractProperties >> isNull [

	^ true
]

{ #category : #'api - adding / removing' }
LeLocalAbstractProperties >> updateProperty: propertyName value: aString [
	self subclassResponsibility
]
