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
		title: 'Extracted State';
		priority: 10;
		object: [ self extractState ];
		view: #gtViewStateAttributesFor:
]

{ #category : #'gt - extensions' }
LeSnippetStateExtractor >> gtViewIgnoredAttributesFor: aView [
	<gtView>
	
	^ aView list 
		title: 'Ignored Attributes';
		priority: 50;
		items: [ self ignoredAttributeNames ]
]

{ #category : #'gt - extensions' }
LeSnippetStateExtractor >> gtViewSelectedAttributesFor: aView [
	<gtView>
	
	^ aView list 
		title: 'Selected Attributes';
		priority: 40;
		items: [ self selectedAttributeNames ]
]

{ #category : #accessing }
LeSnippetStateExtractor >> ignoredAttributeNames [
	^ self subclassResponsibility
]

{ #category : #selecting }
LeSnippetStateExtractor >> selectedAttributeNames [
	^ (self targetSnippet class leJsonV4AttributeMapping
		collect: [ :assoc | assoc key ])
		copyWithoutAll: self ignoredAttributeNames 
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
