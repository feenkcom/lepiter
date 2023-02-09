Class {
	#name : #LeGenericCommandSpecification,
	#superclass : #LeCommandSpecification,
	#instVars : [
		'attributesByName'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeGenericCommandSpecification >> attributeAt: anAttributeName [
	^ attributesByName at: anAttributeName
]

{ #category : #accessing }
LeGenericCommandSpecification >> attributeAt: anAttributeName put: anAttributeValue [
	attributesByName at: anAttributeName put: anAttributeValue
]

{ #category : #accessing }
LeGenericCommandSpecification >> attributes [
	^ attributesByName values
]

{ #category : #accessing }
LeGenericCommandSpecification >> gtCommonAttributes [
	^ super gtCommonAttributes , attributesByName associations
]

{ #category : #initialization }
LeGenericCommandSpecification >> initialize [ 
	super initialize.
	attributesByName := OrderedDictionary new.
]
