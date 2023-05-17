Class {
	#name : #LeInsertChildCommandSpecification,
	#superclass : #LeCommandSpecification,
	#instVars : [
		'insertPath',
		'snippetTypeName',
		'initialSnippetState'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #'gt - extensions' }
LeInsertChildCommandSpecification >> gtViewInitialStateAttributesFor: aView [ 
	<gtView>
	
	^ aView forward 
		title: 'Initial state';
		object: [ initialSnippetState ];
		view: #gtViewStateAttributesFor:
]

{ #category : #accessing }
LeInsertChildCommandSpecification >> initialSnippetState [

	^ initialSnippetState
]

{ #category : #accessing }
LeInsertChildCommandSpecification >> initialSnippetState: anObject [

	initialSnippetState := anObject
]

{ #category : #accessing }
LeInsertChildCommandSpecification >> insertPath [

	^ insertPath
]

{ #category : #accessing }
LeInsertChildCommandSpecification >> insertPath: aSnippetPath [

	insertPath := aSnippetPath
]

{ #category : #accessing }
LeInsertChildCommandSpecification >> snippetTypeName [

	^ snippetTypeName
]

{ #category : #accessing }
LeInsertChildCommandSpecification >> snippetTypeName: anObject [

	snippetTypeName := anObject
]
