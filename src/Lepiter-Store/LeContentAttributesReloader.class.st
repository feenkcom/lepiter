Class {
	#name : #LeContentAttributesReloader,
	#superclass : #Object,
	#instVars : [
		'targetContent',
		'changedAttributes'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #'instance creation' }
LeContentAttributesReloader class >> forContent: aContent [
	^ self new
		targetContent: aContent
]

{ #category : #update }
LeContentAttributesReloader >> addChangedAttribute: anAttributeName [
	changedAttributes add: anAttributeName
]

{ #category : #'accessing - mappings' }
LeContentAttributesReloader >> allContentAttributeMappings [
	^ self targetContent class leJsonV4AttributeMapping 
]

{ #category : #assertions }
LeContentAttributesReloader >> assertCanUpdateFromContent: aContent [
	self assert: [ self targetContent notNil ].
	self assert: [ aContent notNil ].
	self assert: [ self targetContent class = aContent class ].
	self assert: [ self targetContent uid = aContent uid ].
]

{ #category : #accessing }
LeContentAttributesReloader >> changedAttributes [
	^ changedAttributes ifNil: [ #() ]
]

{ #category : #accessing }
LeContentAttributesReloader >> commonAttributeNames [
	^ LeContent leJsonV4AttributeMapping 
		collect: [ :aMapping |
			aMapping key ]
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
LeContentAttributesReloader >> gtViewUpdateStatusFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Update status';
		items: [ self allContentAttributeMappings ];
		column: 'Attribute' text: [ :anAttributeMapping |
			anAttributeMapping key ];	
		column: 'Status' text: [ :anAttributeMapping |
			self updateStatusForAttributeNamed: anAttributeMapping key  ]
]

{ #category : #accessing }
LeContentAttributesReloader >> hasChanges [
	^ changedAttributes notNil and: [ 
		changedAttributes notEmpty ]
]

{ #category : #'accessing - mappings' }
LeContentAttributesReloader >> ignoredAttributes [
	^ #(children uid)
]

{ #category : #'accessing - mappings' }
LeContentAttributesReloader >> relevantAttributeMappings [
	| ignoredAttributes |
	ignoredAttributes := self ignoredAttributes.
	^ self allContentAttributeMappings
		reject: [ :aMapping |
			ignoredAttributes includes: aMapping key ]
]

{ #category : #actions }
LeContentAttributesReloader >> reloadCommonMetadataFromContent: aContent [
	"Reload only the common attributes defined inside the mappings.
	These are the attributes common among all snippets or pages."
	| attributeMapping |
	self assertCanUpdateFromContent: aContent.
	
	attributeMapping := self commonMetadataAttributeMappings.
	self 
		updateForMappings: attributeMapping 
		fromContent: aContent
]

{ #category : #actions }
LeContentAttributesReloader >> reloadFromContent: aSnippet [
	"Reload all the relavant attributes of the content defined inside the mappings."
	| attributeMapping |
	self assertCanUpdateFromContent: aSnippet.
	
	attributeMapping := self relevantAttributeMappings.
	self 
		updateForMappings: attributeMapping 
		fromContent: aSnippet
]

{ #category : #update }
LeContentAttributesReloader >> resetChangedAttributes [
	changedAttributes := OrderedCollection new.
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
		self addChangedAttribute: attributeName.
		self targetContent 
			perform: attributeName asMutator 
			with: attributeNewValue ].
]

{ #category : #update }
LeContentAttributesReloader >> updateCommonMetadataMappingsIn: attributeMapping  fromContent: aContent [
	| commonAttributeNames commonMappings |
	commonAttributeNames := self commonAttributeNames.
	commonMappings := attributeMapping select: [ :each |
		commonAttributeNames includes: each key ].
	
	commonMappings do: [ :aMapping |
		self 
			updateAttributeForMapping: aMapping
			fromContent: aContent ]
]

{ #category : #update }
LeContentAttributesReloader >> updateForMappings: attributeMapping  fromContent: aContent [
	self resetChangedAttributes.
	
	self updateSpecificMappingsIn: attributeMapping  fromContent: aContent.
	self updateCommonMetadataMappingsIn: attributeMapping  fromContent: aContent.
]

{ #category : #update }
LeContentAttributesReloader >> updateSpecificMappingsIn: attributeMapping  fromContent: aContent [
	| commonAttributeNames specificMappings |
	commonAttributeNames := self commonAttributeNames.
	specificMappings := attributeMapping reject: [ :each |
		commonAttributeNames includes: each key ].
	
	specificMappings do: [ :aMapping |
		self 
			updateAttributeForMapping: aMapping
			fromContent: aContent ]
]

{ #category : #accessing }
LeContentAttributesReloader >> updateStatusForAttributeNamed: anAttributeName [
	(self ignoredAttributes includes:  anAttributeName) 
		ifTrue: [ ^ 'Ignored' asRopedText foreground: Color gray ].
	(self changedAttributes includes:  anAttributeName) 
		ifTrue: [ ^ 'Changed' asRopedText foreground: Color red muchDarker ].
	^ 'Equal' asRopedText foreground: Color green muchDarker
]
