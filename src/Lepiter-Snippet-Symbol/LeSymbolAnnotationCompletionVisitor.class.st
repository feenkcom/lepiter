"
I complete symbol names in `gtSymbol` annotations ({{gtClass:LeSymbolAnnotationNode}}) with interned symbols.
I am a component visitor of {{gtClass:LeContentCompletionVisitor}}: I register myself in {{gtMethod:LeSymbolAnnotationCompletionVisitor class>>#initialize}} and deregister in {{gtMethod:LeSymbolAnnotationCompletionVisitor class>>#obsolete}}.
See {{gtExample:LeSymbolAnnotationCompletionVisitorExamples>>#completeSymbolName}} and {{gtExample:LeSymbolAnnotationCompletionVisitorExamples>>#completeSymbolAtStart}}.
"
Class {
	#name : #LeSymbolAnnotationCompletionVisitor,
	#superclass : #Object,
	#traits : 'TSmaCCComponentVisitor + (TLeSymbolParseNodeVisitor - {#acceptNode:})',
	#classTraits : 'TSmaCCComponentVisitor classTrait + TLeSymbolParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-Symbol'
}

{ #category : #initialization }
LeSymbolAnnotationCompletionVisitor class >> initialize [
	LeContentCompletionVisitor additionalCompletionVisitors addIfNotPresent: self

]

{ #category : #initialization }
LeSymbolAnnotationCompletionVisitor class >> obsolete [
	LeContentCompletionVisitor additionalCompletionVisitors remove: self ifAbsent: [  ].
	^ super obsolete

]

{ #category : #private }
LeSymbolAnnotationCompletionVisitor >> addStreamFor: aCollectionOfSymbols startingWith: aPrefix [
	^ self composite
		addStream: (aCollectionOfSymbols asAsyncStream
				collect: [ :each | 
					GtInsertTextCompletionAction
						labeled: (self composite strategy labelFor: each asString withSearch: aPrefix)
						completion: (each asString allButFirst: aPrefix size)
						position: self position ])

]

{ #category : #accessing }
LeSymbolAnnotationCompletionVisitor >> position [
	^ self composite position

]

{ #category : #private }
LeSymbolAnnotationCompletionVisitor >> symbolsStartingWith: aPrefix [
	"Answer interned symbols that start with aPrefix and are longer than it.
	Sort them (shorter first) only for a non-empty prefix, sorting all symbols is too slow."

	| theSymbols |
	theSymbols := Symbol allSymbols
			select: [ :each | each size > aPrefix size and: [ each beginsWith: aPrefix ] ].
	aPrefix ifEmpty: [ ^ theSymbols ].

	^ theSymbols
		asSortedCollection: [ :a :b | a size < b size or: [ a size = b size and: [ a <= b ] ] ]

]

{ #category : #accessing }
LeSymbolAnnotationCompletionVisitor >> text [
	^ self composite text

]

{ #category : #visiting }
LeSymbolAnnotationCompletionVisitor >> visitSmaCCError: aSmaCCError [
	"An empty symbol name, e.g. {{gtSymbol:}}, is parsed as an error node"

	| parent |
	parent := aSmaCCError parent.
	((parent isKindOf: LeDocumenterAnnotationNode)
		and: [ parent name source = 'gtSymbol'
				and: [ self position >= parent colon stopPosition
						and: [ parent right isNil or: [ self position <= parent right startPosition ] ] ] ])
		ifTrue: [ ^ self addStreamFor: (self symbolsStartingWith: '') startingWith: '' ].

	^ self visitSmaCCParseNode: aSmaCCError

]

{ #category : #visiting }
LeSymbolAnnotationCompletionVisitor >> visitSymbolName: aSymbolName [
	| aToken aPrefix |
	aToken := aSymbolName value.
	(aToken notNil
		and: [ self position between: aToken startPosition and: aToken stopPosition ])
		ifTrue: [ aPrefix := self text asString copyFrom: aToken startPosition to: self position.
			^ self addStreamFor: (self symbolsStartingWith: aPrefix) startingWith: aPrefix ].

	^ self visitSymbolParse: aSymbolName

]
