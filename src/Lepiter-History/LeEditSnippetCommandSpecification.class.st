Class {
	#name : #LeEditSnippetCommandSpecification,
	#superclass : #LeCommandSpecification,
	#instVars : [
		'snippetState'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #'gt - extensions' }
LeEditSnippetCommandSpecification >> gtViewStateAttributesFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'State Changes';
		object: [ snippetState ];
		view: #gtViewStateAttributesFor:
]

{ #category : #accessing }
LeEditSnippetCommandSpecification >> snippetState [

	^ snippetState
]

{ #category : #accessing }
LeEditSnippetCommandSpecification >> snippetState: aSnippetState [

	snippetState := aSnippetState
]
