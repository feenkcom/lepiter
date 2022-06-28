Class {
	#name : #LeGenericSnippetState,
	#superclass : #LeBasicSnippetState,
	#instVars : [
		'attributesByName'
	],
	#category : #'Lepiter-History-State'
}

{ #category : #'instance creation' }
LeGenericSnippetState class >> fromSnippet: aSnippet [ 
	^ self new 
		extractFromSnippet: aSnippet
]

{ #category : #'instance creation' }
LeGenericSnippetState class >> fromSnippet: aSnippet basedOn: aTargetState [
	^ self new 
		extractFromSnippet: aSnippet
		basedOn: aTargetState
]

{ #category : #adding }
LeGenericSnippetState >> addAttribute: aStateAttribute [ 
	attributesByName 
		at: aStateAttribute attributeName 
		put: aStateAttribute
]

{ #category : #updating }
LeGenericSnippetState >> applyOn: aSnippet [ 
	attributesByName do: [ :anAttribute |
		anAttribute applyOn: aSnippet ]
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

{ #category : #'initialization - utils' }
LeGenericSnippetState >> extractFromSnippet: aSnippet [ 
	
	self 
		extractFromSnippet: aSnippet 
		basedOn: self class new
]

{ #category : #'initialization - utils' }
LeGenericSnippetState >> extractFromSnippet: aSnippet basedOn: aTargetState [
	| ignoredAttributes |
	ignoredAttributes := #(children).
	
	aSnippet class leJsonV4AttributeMapping 
		reject: [ :assoc | ignoredAttributes includes: assoc key ]
		thenDo: [ :assoc |
			| attributeName attributeType | 
			attributeName := assoc key.
			attributeType := (aTargetState hasAttributeNamed: attributeName)
				ifTrue: [ (aTargetState attributeNamed: attributeName) class ] 
				ifFalse: [ LeGenericSnippetStateAttribute ].
			self addAttribute: (attributeType 
				named: attributeName fromSnippet: aSnippet) ]
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
LeGenericSnippetState >> uid: anUid [ 
	self addAttribute: (LeGenericSnippetStateAttribute new
		attributeName: #uid;
		attributeValue: anUid)
]

{ #category : #accessing }
LeGenericSnippetState >> valueForAttributeNamed: anAttributeName [ 
	^ (attributesByName at: anAttributeName) attributeValue
]
