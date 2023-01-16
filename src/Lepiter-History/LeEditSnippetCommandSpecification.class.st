Class {
	#name : #LeEditSnippetCommandSpecification,
	#superclass : #LeCommandSpecification,
	#instVars : [
		'snippetState'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #transformation }
LeEditSnippetCommandSpecification >> asSpecificationForLogStorage [
	"In case the state stored in the specification should be transformed,
	create a new specification with the transformed state."
	
	^ self snippetState shouldTransformForLogStorage
		ifTrue: [ self copyWithTransformedState]
		ifFalse: [ super asSpecificationForLogStorage ]
]

{ #category : #copying }
LeEditSnippetCommandSpecification >> copyWithTransformedState [
	| transformedState |
	
	transformedState := self snippetState asStateForLogStorage.
	^ self copy
		snippetState: transformedState;
		yourself
]

{ #category : #'gt - extensions' }
LeEditSnippetCommandSpecification >> gtViewStateAttributesFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'State Changes';
		priority: 15;
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
