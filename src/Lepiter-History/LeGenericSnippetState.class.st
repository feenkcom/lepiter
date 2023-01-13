Class {
	#name : #LeGenericSnippetState,
	#superclass : #LeBasicSnippetState,
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
	attributesByName 
		at: aStateAttribute attributeName 
		put: aStateAttribute
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

{ #category : #accessing }
LeGenericSnippetState >> attributeNamed: anAttributeName [
	^ attributesByName at: anAttributeName
]

{ #category : #adding }
LeGenericSnippetState >> attributeNamed: anAttributeName setValue: aValue [
	self addAttribute: (LeGenericSnippetStateAttribute new
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
