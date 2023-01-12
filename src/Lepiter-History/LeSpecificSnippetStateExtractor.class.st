Class {
	#name : #LeSpecificSnippetStateExtractor,
	#superclass : #LeSnippetStateExtractor,
	#category : #'Lepiter-History-State'
}

{ #category : #accessing }
LeSpecificSnippetStateExtractor >> commonMetadataAttributeMappings [
	| fixedAttributes |
	
	fixedAttributes := self fixedAttributeNames.
	^ LeContent leJsonV4AttributeMapping 
		reject: [ :aMapping |
			fixedAttributes includes: aMapping key ]
]

{ #category : #accessing }
LeSpecificSnippetStateExtractor >> commonMetadataAttributeNames [
	^ self commonMetadataAttributeMappings 
		collect: [ :aMapping |
			aMapping key ]
]

{ #category : #accessing }
LeSpecificSnippetStateExtractor >> ignoredAttributeNames [
	^ self fixedAttributeNames, self commonMetadataAttributeNames
]
