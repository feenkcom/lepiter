Class {
	#name : #LePictureArgumentNode,
	#superclass : #LePictureParseNode,
	#instVars : [
		'value',
		'name',
		'equals'
	],
	#category : #'Lepiter-Snippet-Picture-Annotations'
}

{ #category : #generated }
LePictureArgumentNode >> acceptVisitor: aPictureParseVisitor [
	^ aPictureParseVisitor visitPictureArgument: self
]

{ #category : #generated }
LePictureArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LePictureArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #generated }
LePictureArgumentNode >> name [
	^ name
]

{ #category : #generated }
LePictureArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LePictureArgumentNode >> tokenVariables [
	^ #(#value #name #equals)
]

{ #category : #generated }
LePictureArgumentNode >> value [
	^ value
]

{ #category : #generated }
LePictureArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
