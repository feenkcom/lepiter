"
A Markdown table row retaining its original source token and ordered cells.
"
Class {
	#name : #LeTableRowNode,
	#superclass : #LeContentNode,
	#instVars : [
		'leftPipe',
		'cells',
		'pipes',
		'rightPipe'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeTableRowNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitTableRow: self
]

{ #category : #accessing }
LeTableRowNode >> cells [
	^ cells
]

{ #category : #accessing }
LeTableRowNode >> cells: aCollection [
	cells := aCollection.
	self setParents: aCollection to: self
]

{ #category : #generated }
LeTableRowNode >> compositeNodeVariables [
	^ #(cells)
]

{ #category : #generated }
LeTableRowNode >> compositeTokenVariables [
	^ #(#pipes)
]

{ #category : #'generated-initialize-release' }
LeTableRowNode >> initialize [
	super initialize.
	cells := OrderedCollection new: 2.
	pipes := OrderedCollection new: 2.
]

{ #category : #generated }
LeTableRowNode >> leftPipe [
	^ leftPipe
]

{ #category : #generated }
LeTableRowNode >> leftPipe: aSmaCCToken [
	leftPipe := aSmaCCToken
]

{ #category : #generated }
LeTableRowNode >> pipes [
	^ pipes
]

{ #category : #generated }
LeTableRowNode >> pipes: anOrderedCollection [
	pipes := anOrderedCollection
]

{ #category : #generated }
LeTableRowNode >> rightPipe [
	^ rightPipe
]

{ #category : #generated }
LeTableRowNode >> rightPipe: aSmaCCToken [
	rightPipe := aSmaCCToken
]

{ #category : #generated }
LeTableRowNode >> tokenVariables [
	^ #(#leftPipe #rightPipe)
]
