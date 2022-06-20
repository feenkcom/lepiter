Class {
	#name : #LeBasicEditSnippetCommand,
	#superclass : #LeSnippetCommand,
	#instVars : [
		'snippetState',
		'previousSnippetState'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #execution }
LeBasicEditSnippetCommand >> execute [
	self savePreviousSnippetState.
	self snippetState applyOn: self targetSnippet.
]

{ #category : #'gt - extensions' }
LeBasicEditSnippetCommand >> gtViewLiveDiffFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Current State Diff';
		items: [ self snippetState attributeNames
			collect: [ :anAttribute |
				{ 
					anAttribute . 
					self snippetState valueForAttributeNamed: anAttribute.
					self targetContent perform: anAttribute } ] ];
		column: 'Attribute' text: [ :array | array first ];
		column: 'New Value' text: [ :array | array second ];
		column: 'Previous Value' text: [ :array | array third ]
]

{ #category : #'gt - extensions' }
LeBasicEditSnippetCommand >> gtViewNewStateAttributesFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'New State';
		object: [ snippetState ];
		view: #gtViewStateAttributesFor:
]

{ #category : #initialization }
LeBasicEditSnippetCommand >> initialize [ 
	super initialize.
	snippetState := LeGenericSnippetState new.
]

{ #category : #accessing }
LeBasicEditSnippetCommand >> previousSnippetState [

	^ previousSnippetState
]

{ #category : #utils }
LeBasicEditSnippetCommand >> savePreviousSnippetState [
	previousSnippetState := LeGenericSnippetState new.
	self snippetState attributeNames do: [ :anAttributeName |
		previousSnippetState 
			attributeNamed: anAttributeName 
			setValue: (self targetSnippet perform: anAttributeName) ]
]

{ #category : #accessing }
LeBasicEditSnippetCommand >> snippetState [

	^ snippetState
]
