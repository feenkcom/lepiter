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

{ #category : #adding }
LeGenericSnippetState >> attributeNamed: anAttributeName setValue: aValue [
	self addAttribute: (LeGenericSnippetStateAttribute new
		attributeName: anAttributeName;
		attributeValue: aValue)
]

{ #category : #accessing }
LeGenericSnippetState >> attributeNames [
	^ attributesByName values collect: [ :anAttribute | anAttribute attributeName ]
]

{ #category : #'initialization - utils' }
LeGenericSnippetState >> extractFromSnippet: aSnippet [ 
	
	aSnippet class leJsonV4AttributeMapping do: [ :assoc |
		self addAttribute: (LeGenericSnippetStateAttribute 
			named: assoc key fromSnippet: aSnippet) ]
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
