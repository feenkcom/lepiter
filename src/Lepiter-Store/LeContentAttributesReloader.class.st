Class {
	#name : #LeContentAttributesReloader,
	#superclass : #Object,
	#instVars : [
		'targetContent',
		'hasChanges'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #'instance creation' }
LeContentAttributesReloader class >> forContent: aContent [
	^ self new
		targetContent: aContent
]

{ #category : #assertions }
LeContentAttributesReloader >> assertCanUpdateFomContent: aContent [
	self assert: [ self targetContent notNil ].
	self assert: [ aContent notNil ].
	self assert: [ self targetContent class = aContent class ].
	self assert: [ self targetContent uid = aContent uid ].
]

{ #category : #'accessing - mappings' }
LeContentAttributesReloader >> commonMetadataAttributeMappings [
	| ignoredAttributes |
	ignoredAttributes := self ignoredAttributes.
	^ LeContent leJsonV4AttributeMapping 
		reject: [ :aMapping |
			ignoredAttributes includes: aMapping key ]
]

{ #category : #accessing }
LeContentAttributesReloader >> hasChanges [
	^ hasChanges ifNil: [ false ]
]

{ #category : #'accessing - mappings' }
LeContentAttributesReloader >> ignoredAttributes [
	^ #(children uid)
]

{ #category : #'accessing - mappings' }
LeContentAttributesReloader >> relevantAttributeMappings [
	| ignoredAttributes |
	ignoredAttributes := self ignoredAttributes.
	^ self targetContent class leJsonV4AttributeMapping 
		reject: [ :aMapping |
			ignoredAttributes includes: aMapping key ]
]

{ #category : #actions }
LeContentAttributesReloader >> reloadCommonMetadataFromContent: aContent [
	"Reload only the common attributes defined inside the mappings.
	These are the attributes common among all snippets or pages"
	| attributeMapping |
	self assertCanUpdateFomContent: aContent.
	
	attributeMapping := self commonMetadataAttributeMappings.
	self 
		updateForMappings: attributeMapping 
		fromContent: aContent
]

{ #category : #actions }
LeContentAttributesReloader >> reloadFromContent: aSnippet [
	"Reload all the relavant attributes of the content defined inside the mappings."
	| attributeMapping |
	self assertCanUpdateFomContent: aSnippet.
	
	hasChanges := false.
	attributeMapping := self relevantAttributeMappings.
	self 
		updateForMappings: attributeMapping 
		fromContent: aSnippet
]

{ #category : #accessing }
LeContentAttributesReloader >> targetContent [
	^ targetContent
]

{ #category : #accessing }
LeContentAttributesReloader >> targetContent: aContent [
	targetContent := aContent
]

{ #category : #update }
LeContentAttributesReloader >> updateAttributeForMapping: aMapping fromContent: aContent [
	| attributeName attributeOldValue attributeNewValue |
	self assert: [ aMapping key isSymbol ].
	
	attributeName := aMapping key.
	attributeOldValue := self targetContent perform: attributeName.
	attributeNewValue := aContent perform: attributeName.
	attributeOldValue = attributeNewValue ifFalse: [
		hasChanges := true.
		self targetContent 
			perform: attributeName asMutator 
			with: attributeNewValue ].
]

{ #category : #update }
LeContentAttributesReloader >> updateForMappings: attributeMapping  fromContent: aContent [
	hasChanges := false.
	attributeMapping do: [ :aMapping |
		self 
			updateAttributeForMapping: aMapping
			fromContent: aContent ]
]
