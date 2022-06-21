Class {
	#name : #LeBasicEditSnippetCommand,
	#superclass : #LeSnippetCommand,
	#instVars : [
		'snippetState'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #utils }
LeBasicEditSnippetCommand >> createCommandResult [
	^ LeEditSnippetCommandExecutionResult forCommand: self
]

{ #category : #converting }
LeBasicEditSnippetCommand >> createCommandSpecification [
	^ LeEditSnippetCommandSpecification new 
		commandUid: self uid;
		contentUid: self targetSnippetUid;
		snippetState: self snippetState
]

{ #category : #execution }
LeBasicEditSnippetCommand >> execute [
	| previousSnippetState | 
	previousSnippetState := self extractCurrentSnippetState.
	
	self snippetState applyOn: self targetSnippet.
	
	^ self createCommandResult
		previousSnippetState: previousSnippetState
	
]

{ #category : #utils }
LeBasicEditSnippetCommand >> extractCurrentSnippetState [
	| previousSnippetState |
	previousSnippetState := LeGenericSnippetState new.
	
	self snippetState attributeNames do: [ :anAttributeName |
		previousSnippetState 
			attributeNamed: anAttributeName 
			setValue: (self targetSnippet perform: anAttributeName) ].
	
	^ previousSnippetState
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
LeBasicEditSnippetCommand >> snippetState [

	^ snippetState
]
