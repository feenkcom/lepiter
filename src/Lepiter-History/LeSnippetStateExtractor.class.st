Class {
	#name : #LeSnippetStateExtractor,
	#superclass : #Object,
	#instVars : [
		'targetSnippet'
	],
	#category : #'Lepiter-History-State'
}

{ #category : #'instace creation' }
LeSnippetStateExtractor class >> forSnippet: aSnippet [
	^ self new 
		targetSnippet:  aSnippet
]

{ #category : #action }
LeSnippetStateExtractor class >> fromSnippet: aSnippet [
	^ (self forSnippet: aSnippet) 
		extractState
]

{ #category : #accessing }
LeSnippetStateExtractor >> commonMetadataAttributeMappings [
	| fixedAttributes |
	
	fixedAttributes := self fixedAttributeNames.
	^ LeContent leJsonV4AttributeMapping 
		reject: [ :aMapping |
			fixedAttributes includes: aMapping key ]
]

{ #category : #accessing }
LeSnippetStateExtractor >> commonMetadataAttributeNames [
	^ self commonMetadataAttributeMappings 
		collect: [ :aMapping |
			aMapping key ]
]

{ #category : #actions }
LeSnippetStateExtractor >> extractState [
	| state |
	state := LeGenericSnippetState new.
	
	self selectedAttributes do: [ :anAttribute |
		anAttribute initializeValueFromSnippet:  self targetSnippet.
		state addAttribute: anAttribute ].
			
	^  state
]

{ #category : #accessing }
LeSnippetStateExtractor >> fixedAttributeNames [
	^ #(uid children).
]

{ #category : #'gt - extensions' }
LeSnippetStateExtractor >> gtViewExtractedStateFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Extracted state';
		priority: 10;
		object: [ self extractState ];
		view: #gtViewStateAttributesFor:
]

{ #category : #'gt - extensions' }
LeSnippetStateExtractor >> gtViewIgnoredAttributesFor: aView [
	<gtView>
	
	^ aView list 
		title: 'Ignored attributes';
		priority: 50;
		items: [ self ignoredAttributeNames ]
]

{ #category : #'gt - extensions' }
LeSnippetStateExtractor >> gtViewSelectedAttributesFor: aView [
	<gtView>
	
	^ aView list 
		title: 'Selected attributes';
		priority: 40;
		items: [ self selectedAttributes ]
]

{ #category : #accessing }
LeSnippetStateExtractor >> ignoredAttributeNames [
	^ self subclassResponsibility
]

{ #category : #selecting }
LeSnippetStateExtractor >> selectedAttributes [
	| ignoredAttributeNames |
	ignoredAttributeNames := self ignoredAttributeNames.
	^ self targetSnippet class stateAttributes	
		reject: [ :anAttribute |
			ignoredAttributeNames includes:  anAttribute attributeName ]
]

{ #category : #accessing }
LeSnippetStateExtractor >> targetSnippet [
	^ targetSnippet
]

{ #category : #accessing }
LeSnippetStateExtractor >> targetSnippet: anObject [
	targetSnippet := anObject
]
