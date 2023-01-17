Class {
	#name : #LeGenericSnippetState,
	#superclass : #Object,
	#instVars : [
		'attributesByName'
	],
	#category : #'Lepiter-History-State'
}

{ #category : #comparing }
LeGenericSnippetState >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	
	^ attributesByName = anObject attributesByName
]

{ #category : #adding }
LeGenericSnippetState >> addAttribute: aStateAttribute [
	self assert: [ aStateAttribute notNil ].
	self assert: [ 
		(attributesByName  includesKey: aStateAttribute attributeName) not ].
	 
	self setAttribute: aStateAttribute.
]

{ #category : #adding }
LeGenericSnippetState >> appendState: aSnippetState [
	self assert: [ aSnippetState notNil ].
	
	aSnippetState attributesDo: [ :anAttribute |
		self addAttribute:  anAttribute ].
]

{ #category : #updating }
LeGenericSnippetState >> applyAttributes: aCollectionOfAttributeNames on: aSnippet [
	aCollectionOfAttributeNames do: [ :anAttributeName |
		(attributesByName at: anAttributeName) applyOn:  aSnippet ]
]

{ #category : #updating }
LeGenericSnippetState >> applyCommonMetadataOn: aSnippet [ 
	self 
		applyAttributes: self commonMetadataAttributeNamesInState 
		on: aSnippet
]

{ #category : #updating }
LeGenericSnippetState >> applyOn: aSnippet [ 
	"When applying the state of a snippet we apply first the 
	specific attributes, and afterwards the common metadata. 
	Ideally the order should not mater, however some snippets
	update metadata when specific attributes are set. On restoring
	the full state of a snippet we should then restore metadata 
	as the last action."
	
	self applySpecificAttributesOn: aSnippet.
	self applyCommonMetadataOn: aSnippet.
]

{ #category : #updating }
LeGenericSnippetState >> applySpecificAttributesOn: aSnippet [ 
	self 
		applyAttributes: self specificAttributeNamesInState 
		on: aSnippet
]

{ #category : #transformation }
LeGenericSnippetState >> asStateForLogStorage [
	| newState |
	
	newState := self species new.
	attributesByName valuesDo: [ :anAttribute |
		newState addAttribute: anAttribute asAttributeForLogStorage ].
	
	^ newState
]

{ #category : #accessing }
LeGenericSnippetState >> attributeNamed: anAttributeName [
	^ attributesByName at: anAttributeName
]

{ #category : #adding }
LeGenericSnippetState >> attributeNamed: anAttributeName setValue: aValue [
	self setAttribute: (LeGenericSnippetStateAttribute new
		attributeName: anAttributeName;
		attributeValue: aValue)
]

{ #category : #accessing }
LeGenericSnippetState >> attributeNames [
	^ self attributes collect: [ :anAttribute | 
		anAttribute attributeName ]
]

{ #category : #accessing }
LeGenericSnippetState >> attributes [
	^ attributesByName values
]

{ #category : #accessing }
LeGenericSnippetState >> attributesByName [
	^ attributesByName
]

{ #category : #accessing }
LeGenericSnippetState >> attributesCount [
	^ attributesByName size
]

{ #category : #enumerating }
LeGenericSnippetState >> attributesDo: aBlock [
	attributesByName valuesDo: aBlock
]

{ #category : #accessing }
LeGenericSnippetState >> commonAttributeNames [
	^ LeContent leJsonV4AttributeMapping 
		collect: [ :aMapping |
			aMapping key ]
]

{ #category : #accessing }
LeGenericSnippetState >> commonMetadataAttributeNamesInState [
	^ self attributeNames intersection: self commonAttributeNames
]

{ #category : #'gt - extensions' }
LeGenericSnippetState >> gtViewStateAttributesFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Attributes';
		items: [ attributesByName values ];
		column: 'Attribute' text: [ :anAttribute | anAttribute attributeName ];
		column: 'Value' text: [ :anAttribute | anAttribute attributeValue ];
		column: 'Type' text: [ :anAttribute | anAttribute className ]
]

{ #category : #testing }
LeGenericSnippetState >> hasAttributeNamed: aName [ 
	^ attributesByName includesKey: aName
]

{ #category : #testing }
LeGenericSnippetState >> hasAttributes [
	^ attributesByName notEmpty
]

{ #category : #comparing }
LeGenericSnippetState >> hash [ 
	
	^ attributesByName hash
]

{ #category : #initialization }
LeGenericSnippetState >> initialize [ 
	super initialize.
	attributesByName := OrderedDictionary new.
]

{ #category : #printing }
LeGenericSnippetState >> printOn: aStream [ 
	super printOn: aStream .
	aStream parenthesize: [ 
		aStream print: attributesByName size. 
		aStream << (attributesByName size =  1
			ifTrue: [ ' attribute' ]
			ifFalse: [ ' attributes' ]) ]
]

{ #category : #adding }
LeGenericSnippetState >> setAttribute: aStateAttribute [
	self assert: [ aStateAttribute notNil ].
	 
	attributesByName 
		at: aStateAttribute attributeName 
		put: aStateAttribute
]

{ #category : #'testing - transformation' }
LeGenericSnippetState >> shouldTransformForLogStorage [
	^ self attributes anySatisfy: [ :anAttribute |
		anAttribute shouldTransformForLogStorage]
]

{ #category : #accessing }
LeGenericSnippetState >> specificAttributeNamesInState [
	^ self attributeNames copyWithoutAll: self commonAttributeNames
]

{ #category : #accessing }
LeGenericSnippetState >> uid: anUid [ 
	self addAttribute: (LeGenericSnippetStateAttribute new
		attributeName: #uid;
		attributeValue: anUid)
]

{ #category : #accessing }
LeGenericSnippetState >> valueForAttributeNamed: anAttributeName [ 
	^ (attributesByName at: anAttributeName) attributeValue
]
