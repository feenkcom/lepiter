Class {
	#name : #LeInsertChildCommandSpecification,
	#superclass : #LeCommandSpecification,
	#instVars : [
		'insertPosition',
		'snippetTypeName',
		'initialSnippetState'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeInsertChildCommandSpecification >> initialSnippetState [

	^ initialSnippetState
]

{ #category : #accessing }
LeInsertChildCommandSpecification >> initialSnippetState: anObject [

	initialSnippetState := anObject
]

{ #category : #accessing }
LeInsertChildCommandSpecification >> insertPosition [

	^ insertPosition
]

{ #category : #accessing }
LeInsertChildCommandSpecification >> insertPosition: anObject [

	insertPosition := anObject
]

{ #category : #accessing }
LeInsertChildCommandSpecification >> snippetTypeName [

	^ snippetTypeName
]

{ #category : #accessing }
LeInsertChildCommandSpecification >> snippetTypeName: anObject [

	snippetTypeName := anObject
]
