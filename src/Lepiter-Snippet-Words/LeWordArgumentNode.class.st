Class {
	#name : #LeWordArgumentNode,
	#superclass : #LeWordParseNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'Lepiter-Snippet-Words-Annotations'
}

{ #category : #generated }
LeWordArgumentNode >> acceptVisitor: aWordParseVisitor [
	^ aWordParseVisitor visitWordArgument: self
]

{ #category : #generated }
LeWordArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LeWordArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #generated }
LeWordArgumentNode >> name [
	^ name
]

{ #category : #generated }
LeWordArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LeWordArgumentNode >> tokenVariables [
	^ #(#name #equals #value)
]

{ #category : #generated }
LeWordArgumentNode >> value [
	^ value
]

{ #category : #generated }
LeWordArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
