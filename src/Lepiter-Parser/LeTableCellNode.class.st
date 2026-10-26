"
A Markdown table cell containing inline content and its original source range.
"
Class {
	#name : #LeTableCellNode,
	#superclass : #LeContentNode,
	#instVars : [
		'parts',
		'text'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeTableCellNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitTableCell: self
]

{ #category : #accessing }
LeTableCellNode >> alignment [
	| value |
	value := text value trimBoth.
	^ (value beginsWith: ':')
		ifTrue: [ (value endsWith: ':') ifTrue: [ #center ] ifFalse: [ #left ] ]
		ifFalse: [ (value endsWith: ':') ifTrue: [ #right ] ifFalse: [ #default ] ]
]

{ #category : #generated }
LeTableCellNode >> compositeNodeVariables [
	^ #(parts)
]

{ #category : #accessing }
LeTableCellNode >> contentSource [
	^ text ifNotNil: [ text value ] ifNil: [ String streamContents: [ :stream | parts do: [ :each | stream nextPutAll: each source ] ] ]
]

{ #category : #'generated-initialize-release' }
LeTableCellNode >> initialize [
	super initialize.
	parts := OrderedCollection new: 2.
]

{ #category : #accessing }
LeTableCellNode >> parts [
	^ parts
]

{ #category : #accessing }
LeTableCellNode >> parts: aCollection [
	parts := aCollection.
	self setParents: aCollection to: self
]

{ #category : #copying }
LeTableCellNode >> postCopy [
	super postCopy.
	attributes := attributes ifNotNil: [ attributes copy ]
]

{ #category : #accessing }
LeTableCellNode >> text [
	^ text
]

{ #category : #accessing }
LeTableCellNode >> text: aToken [
	text := aToken
]

{ #category : #generated }
LeTableCellNode >> tokenVariables [
	^ #(text)
]
