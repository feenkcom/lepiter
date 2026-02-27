Class {
	#name : #LeFileReferenceArgumentNode,
	#superclass : #LeFileReferenceParseNode,
	#instVars : [
		'name',
		'equals'
	],
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #generated }
LeFileReferenceArgumentNode >> acceptVisitor: aFileReferenceParseVisitor [
	^ aFileReferenceParseVisitor visitFileReferenceArgument: self
]

{ #category : #generated }
LeFileReferenceArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LeFileReferenceArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #generated }
LeFileReferenceArgumentNode >> name [
	^ name
]

{ #category : #generated }
LeFileReferenceArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #accessing }
LeFileReferenceArgumentNode >> nameString [
	| token |
	token := self name.
	^ token isNil
		ifTrue: [ nil ]
		ifFalse: [ token value ]
]

{ #category : #accessing }
LeFileReferenceArgumentNode >> normalizedValue [
	| raw |
	raw := self valueString.
	raw isNil ifTrue: [ ^ nil ].
	(raw size >= 2 and: [ raw first = $" and: [ raw last = $" ] ])
		ifFalse: [ ^ raw ].
	^ ((raw copyFrom: 2 to: raw size - 1) copyReplaceAll: '""' with: '"')
]

{ #category : #generated }
LeFileReferenceArgumentNode >> tokenVariables [
	^ #(#name #equals)
]

{ #category : #accessing }
LeFileReferenceArgumentNode >> valueString [
	| token |
	token := self value.
	^ token isNil
		ifTrue: [ nil ]
		ifFalse: [ token value ]
]
