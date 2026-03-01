"
Root node for gtPragma annotation values.
"
Class {
	#name : #LePragmaAnnotationNode,
	#superclass : #LePragmaParseNode,
	#instVars : [
		'items',
		'bars'
	],
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #generated }
LePragmaAnnotationNode >> acceptVisitor: aPragmaParseVisitor [
	^ aPragmaParseVisitor visitPragmaAnnotation: self
]

{ #category : #accessing }
LePragmaAnnotationNode >> bars [
	^ bars
]

{ #category : #accessing }
LePragmaAnnotationNode >> bars: aCollection [
	bars := aCollection
]

{ #category : #generated }
LePragmaAnnotationNode >> compositeNodeVariables [
	^ #(#items)
]

{ #category : #generated }
LePragmaAnnotationNode >> compositeTokenVariables [
	^ #(#bars)
]

{ #category : #testing }
LePragmaAnnotationNode >> hasPragmaNameSpecified [
	^ self pragmaNameNode notNil
]

{ #category : #'generated-initialize-release' }
LePragmaAnnotationNode >> initialize [
	super initialize.
	items := OrderedCollection new: 2.
	bars := OrderedCollection new: 2.
]

{ #category : #accessing }
LePragmaAnnotationNode >> items [
	^ items
]

{ #category : #accessing }
LePragmaAnnotationNode >> items: aCollection [
	items := aCollection
]

{ #category : #accessing }
LePragmaAnnotationNode >> pragmaName [
	^ self pragmaNameNode ifNotNil: [ :node | node value source ]
]

{ #category : #accessing }
LePragmaAnnotationNode >> pragmaNameNode [
	^ items detect: [ :each | each isKindOf: LePragmaNameNode ] ifNone: [  ]
]
