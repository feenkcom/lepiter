Class {
	#name : #LeExportSpecificationUtility,
	#superclass : #Object,
	#category : #'Lepiter-Export-Specification - Support'
}

{ #category : #'api - building' }
LeExportSpecificationUtility class >> distanceFromSubclass: aSubclass toSuperclass: aSuperclass [
	"Return a inheritance distance between a superclass and its subclass."
	
	<return: #Integer>
	| aClass aDistance |
	self
		assert: [ aSubclass isClass ]
		description: [ 'Subclass must be a class: {1}' format: {aSubclass} ].
	self
		assert: [ aSuperclass isClass ]
		description: [ 'Superclass must be a class: {1}' format: {aSuperclass} ].
		
	aClass := aSubclass.
	aDistance := 0.
	[aClass == nil] whileFalse: [ 
		aSuperclass == aClass ifTrue: [ ^ aDistance ].
		aDistance := aDistance + 1.
		aClass := aClass superclass ].
		
	self 
		assert: [ aClass isNotNil ]
		description: [ 'The subclass `{1}` must (indirectly) inherit from the superclass `{2}`' format: { aSubclass. aSuperclass } ].
		
	^ aDistance
]
