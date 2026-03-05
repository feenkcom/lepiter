"
Abstract node for gtPragma annotation arguments.
"
Class {
	#name : #LePragmaArgumentNode,
	#superclass : #LePragmaParseNode,
	#instVars : [
		'value',
		'name',
		'equals'
	],
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #generated }
LePragmaArgumentNode >> acceptVisitor: aPragmaParseVisitor [
	^ aPragmaParseVisitor visitPragmaArgument: self
]

{ #category : #generated }
LePragmaArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LePragmaArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #generated }
LePragmaArgumentNode >> name [
	^ name
]

{ #category : #generated }
LePragmaArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #accessing }
LePragmaArgumentNode >> nameString [
	| token |
	token := self name.
	^ token isNil
		ifTrue: [ nil ]
		ifFalse: [ token value ]
]

{ #category : #accessing }
LePragmaArgumentNode >> normalizedValue [
	| raw |
	raw := self valueString.
	raw isNil ifTrue: [ ^ nil ].
	(raw size >= 2 and: [ raw first = $" and: [ raw last = $" ] ])
		ifFalse: [ ^ raw ].
	^ ((raw copyFrom: 2 to: raw size - 1) copyReplaceAll: '""' with: '"')
]

{ #category : #generated }
LePragmaArgumentNode >> tokenVariables [
	^ #(#value #name #equals)
]

{ #category : #generated }
LePragmaArgumentNode >> value [
	^ value
]

{ #category : #generated }
LePragmaArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]

{ #category : #accessing }
LePragmaArgumentNode >> valueString [
	| token |
	token := self value.
	^ token isNil
		ifTrue: [ nil ]
		ifFalse: [ token value ]
]
