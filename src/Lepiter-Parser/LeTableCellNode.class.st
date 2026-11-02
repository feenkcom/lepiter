"
A Markdown table cell containing inline content and its original source range.
"
Class {
	#name : #LeTableCellNode,
	#superclass : #LeContentNode,
	#instVars : [
		'parts'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeTableCellNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitTableCell: self
]

{ #category : #accessing }
LeTableCellNode >> alignment [
	^ #default
]

{ #category : #generated }
LeTableCellNode >> compositeNodeVariables [
	^ #(parts)
]

{ #category : #accessing }
LeTableCellNode >> contentSource [
	^ String streamContents: [ :stream | parts do: [ :each | stream nextPutAll: each source ] ]
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
	| originalParents |
	"Generated setters used during a deep copy may detach the original
	children of embedded annotations. Preserve those parent links while
	building an independently parented copy of this cell."
	originalParents := OrderedCollection new.
	self allNodesDo: [ :node | originalParents add: node -> node parent ].
	[ super postCopy ] ensure: [
		originalParents do: [ :association | association key parent: association value ] ].
	self fixParentPointers
]

{ #category : #accessing }
LeTableCellNode >> text [
	"Inline cells have parts rather than a single source token."
	^ nil
]
