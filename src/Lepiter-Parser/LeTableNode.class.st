"
A Markdown table with a header, a delimiter row and body rows. Cell content uses the Lepiter inline AST.
"
Class {
	#name : #LeTableNode,
	#superclass : #LeContentNode,
	#instVars : [
		'header',
		'headerEol',
		'separator',
		'eols',
		'rows'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeTableNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitTable: self
]

{ #category : #accessing }
LeTableNode >> alignments [
	^ self separator cells collect: #alignment
]

{ #category : #generated }
LeTableNode >> compositeNodeVariables [
	^ #(#rows)
]

{ #category : #generated }
LeTableNode >> compositeTokenVariables [
	^ #(#eols)
]

{ #category : #generated }
LeTableNode >> eols [
	^ eols
]

{ #category : #generated }
LeTableNode >> eols: anOrderedCollection [
	eols := anOrderedCollection
]

{ #category : #accessing }
LeTableNode >> header [
	^ header
]

{ #category : #accessing }
LeTableNode >> header: aNode [
	header := aNode.
	self setParent: aNode to: self
]

{ #category : #generated }
LeTableNode >> headerEol [
	^ headerEol
]

{ #category : #generated }
LeTableNode >> headerEol: aSmaCCToken [
	headerEol := aSmaCCToken
]

{ #category : #'generated-initialize-release' }
LeTableNode >> initialize [
	super initialize.
	eols := OrderedCollection new: 2.
	rows := OrderedCollection new: 2.
]

{ #category : #generated }
LeTableNode >> nodeVariables [
	^ #(#header #separator)
]

{ #category : #accessing }
LeTableNode >> rows [
	^ rows
]

{ #category : #accessing }
LeTableNode >> rows: aCollection [
	rows := aCollection.
	self setParents: aCollection to: self
]

{ #category : #accessing }
LeTableNode >> separator [
	^ separator
]

{ #category : #accessing }
LeTableNode >> separator: aNode [
	separator := aNode.
	self setParent: aNode to: self
]

{ #category : #generated }
LeTableNode >> tokenVariables [
	^ #(#headerEol)
]
