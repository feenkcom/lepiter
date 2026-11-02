"
The delimiter row of a Markdown table. Its cells specify column alignment.
"
Class {
	#name : #LeTableSeparatorNode,
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
LeTableSeparatorNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitTableSeparator: self
]

{ #category : #generated }
LeTableSeparatorNode >> cells [
	^ cells
]

{ #category : #generated }
LeTableSeparatorNode >> cells: anOrderedCollection [
	self setParents: self cells to: nil.
	cells := anOrderedCollection.
	self setParents: self cells to: self
]

{ #category : #generated }
LeTableSeparatorNode >> compositeNodeVariables [
	^ #(#cells)
]

{ #category : #generated }
LeTableSeparatorNode >> compositeTokenVariables [
	^ #(#pipes)
]

{ #category : #'generated-initialize-release' }
LeTableSeparatorNode >> initialize [
	super initialize.
	cells := OrderedCollection new: 2.
	pipes := OrderedCollection new: 2.
]

{ #category : #generated }
LeTableSeparatorNode >> leftPipe [
	^ leftPipe
]

{ #category : #generated }
LeTableSeparatorNode >> leftPipe: aSmaCCToken [
	leftPipe := aSmaCCToken
]

{ #category : #generated }
LeTableSeparatorNode >> pipes [
	^ pipes
]

{ #category : #generated }
LeTableSeparatorNode >> pipes: anOrderedCollection [
	pipes := anOrderedCollection
]

{ #category : #generated }
LeTableSeparatorNode >> rightPipe [
	^ rightPipe
]

{ #category : #generated }
LeTableSeparatorNode >> rightPipe: aSmaCCToken [
	rightPipe := aSmaCCToken
]

{ #category : #generated }
LeTableSeparatorNode >> tokenVariables [
	^ #(#leftPipe #rightPipe)
]
