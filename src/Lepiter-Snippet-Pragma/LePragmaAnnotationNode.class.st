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

{ #category : #'as yet unclassified' }
LePragmaAnnotationNode >> expanded [
	^ self expandedValue ifNil: [ ^ false ]
]

{ #category : #accessing }
LePragmaAnnotationNode >> expandedArgument [
	| args |
	args := self items select: [ :each |
		(each isKindOf: LePragmaArgumentNode)
			and: [ ((each nameString ifNil: [ each valueString ]) ifNil: [ '' ])
				sameAs: 'expanded' ] ].
	^ args ifEmpty: [ nil ] ifNotEmpty: [ args first ]
]

{ #category : #accessing }
LePragmaAnnotationNode >> expandedValue [
	| arg |
	arg := self expandedArgument.
	arg ifNil: [ ^ nil ].
	arg nameString ifNil: [ ^ true ].
	arg valueString ifNil: [ ^ true ].
	^ arg valueString sameAs: 'true'
]

{ #category : #accessing }
LePragmaAnnotationNode >> expandedValueString [
	^ self expandedArgument ifNil: [ nil ] ifNotNil: [ :argument | argument valueString ]
]

{ #category : #testing }
LePragmaAnnotationNode >> hasExpandedSpecified [
	^ self expandedArgument notNil
]

{ #category : #testing }
LePragmaAnnotationNode >> hasPragmaNameSpecified [
	^ self pragmaNameNode notNil
]

{ #category : #'as yet unclassified' }
LePragmaAnnotationNode >> height [
	"polymorphic"
	^ nil
]

{ #category : #'as yet unclassified' }
LePragmaAnnotationNode >> imageObject [
	^ GtPragmaType new keyword: self pragmaName
]

{ #category : #'generated-initialize-release' }
LePragmaAnnotationNode >> initialize [
	super initialize.
	items := OrderedCollection new: 2.
	bars := OrderedCollection new: 2.
]

{ #category : #testing }
LePragmaAnnotationNode >> isDefined [
	^ self hasPragmaNameSpecified
]

{ #category : #accessing }
LePragmaAnnotationNode >> items [
	^ items
]

{ #category : #accessing }
LePragmaAnnotationNode >> items: aCollection [
	items := aCollection
]

{ #category : #'as yet unclassified' }
LePragmaAnnotationNode >> labelNode [
	"polymorphic"
	^ nil
]

{ #category : #accessing }
LePragmaAnnotationNode >> nameNode [
	"polymorphic method"
	^ self pragmaNameNode
]

{ #category : #accessing }
LePragmaAnnotationNode >> pragmaName [
	^ self pragmaNameNode ifNotNil: [ :node | node value source ]
]

{ #category : #accessing }
LePragmaAnnotationNode >> pragmaNameNode [
	^ items detect: [ :each | each isKindOf: LePragmaNameNode ] ifNone: [  ]
]

{ #category : #'as yet unclassified' }
LePragmaAnnotationNode >> showSelector [
	"polymorphic"
	^ nil
]
