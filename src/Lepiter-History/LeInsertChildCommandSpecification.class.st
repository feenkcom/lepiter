Class {
	#name : #LeInsertChildCommandSpecification,
	#superclass : #LeCommandSpecification,
	#instVars : [
		'insertPosition',
		'snippetTypeName',
		'snippetState'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeInsertChildCommandSpecification >> insertPosition [

	^ insertPosition
]

{ #category : #accessing }
LeInsertChildCommandSpecification >> insertPosition: anObject [

	insertPosition := anObject
]

{ #category : #accessing }
LeInsertChildCommandSpecification >> snippetState [

	^ snippetState
]

{ #category : #accessing }
LeInsertChildCommandSpecification >> snippetState: anObject [

	snippetState := anObject
]

{ #category : #accessing }
LeInsertChildCommandSpecification >> snippetTypeName [

	^ snippetTypeName
]

{ #category : #accessing }
LeInsertChildCommandSpecification >> snippetTypeName: anObject [

	snippetTypeName := anObject
]
