Class {
	#name : #LeSymbolAnnotationNode,
	#superclass : #LeSymbolParseNode,
	#instVars : [
		'symbol'
	],
	#category : #'Lepiter-Snippet-Symbol'
}

{ #category : #generated }
LeSymbolAnnotationNode >> acceptVisitor: aSymbolParseVisitor [
	^ aSymbolParseVisitor visitSymbolAnnotation: self
]

{ #category : #testing }
LeSymbolAnnotationNode >> hasSymbolNameSpecified [
	^ self symbolNode notNil
]

{ #category : #accessing }
LeSymbolAnnotationNode >> imageObject [
	^ self symbolValue
]

{ #category : #testing }
LeSymbolAnnotationNode >> isDefined [
	| name |
	name := self symbolName.
	name ifNil: [ ^ false ].
	^ Symbol hasInterned: name
]

{ #category : #generated }
LeSymbolAnnotationNode >> nodeVariables [
	^ #(#symbol)
]

{ #category : #accessing }
LeSymbolAnnotationNode >> showSelector [
	"polymorphic"
	^ nil
]

{ #category : #generated }
LeSymbolAnnotationNode >> symbol [
	^ symbol
]

{ #category : #generated }
LeSymbolAnnotationNode >> symbol: aLeSymbolNameNode [
	self symbol notNil ifTrue: [ self symbol parent: nil ].
	symbol := aLeSymbolNameNode.
	self symbol notNil ifTrue: [ self symbol parent: self ]
]

{ #category : #accessing }
LeSymbolAnnotationNode >> symbolName [
	^ self symbolNode ifNotNil: [ :node | node value source ]
]

{ #category : #accessing }
LeSymbolAnnotationNode >> symbolNode [
	^ symbol
]

{ #category : #accessing }
LeSymbolAnnotationNode >> symbolValue [
	^ self symbolName ifNotNil: [ :name | name asSymbol ]
]
