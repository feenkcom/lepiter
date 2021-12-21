Class {
	#name : #LeWordAnnotationCompletionVisitor,
	#superclass : #Object,
	#traits : 'TSmaCCComponentVisitor + (TLeWordParseNodeVisitor - {#acceptNode:})',
	#classTraits : 'TSmaCCComponentVisitor classTrait + TLeWordParseNodeVisitor classTrait',
	#category : #'Lepiter-Snippet-Words-Annotations'
}

{ #category : #initialization }
LeWordAnnotationCompletionVisitor class >> initialize [
	LeContentCompletionVisitor additionalCompletionVisitors add: self
]

{ #category : #initialization }
LeWordAnnotationCompletionVisitor class >> obsolete [
	LeContentCompletionVisitor additionalCompletionVisitors remove: self ifAbsent: [  ].
	^ super obsolete
]

{ #category : #visiting }
LeWordAnnotationCompletionVisitor >> addStreamFor: words startingWith: prefix [
	^ self composite
		addStream:
			((words asyncStreamStartingWith: prefix)
				collect:
					[ :each | 
					GtInsertTextCompletionAction
						labeled: (self composite strategy labelFor: each withSearch: prefix)
						completion: (each allButFirst: prefix size)
						position: self position ])
]

{ #category : #accessing }
LeWordAnnotationCompletionVisitor >> position [
	^ self composite position
]

{ #category : #generated }
LeWordAnnotationCompletionVisitor >> visitWordAnnotation: aWordAnnotation [
	(aWordAnnotation bars notEmpty and: [ aWordAnnotation bars last stopPosition = self position ])
		ifTrue:
			[ | words |
			words := self wordAttributesFor: aWordAnnotation.
			words notEmpty ifTrue: [ ^ self addStreamFor: words startingWith: '' ] ].
	^ self visitWordParse: aWordAnnotation
]

{ #category : #generated }
LeWordAnnotationCompletionVisitor >> visitWordValue: aWordValue [
	(aWordValue value stopPosition = self position and: [ aWordValue parent wordValueNode ~~ aWordValue ])
		ifTrue:
			[ | words |
			words := self wordAttributesFor: aWordValue parent.
			words notEmpty ifTrue: [ ^ self addStreamFor: words startingWith: aWordValue value source ] ].
	^ self visitWordArgument: aWordValue
]

{ #category : #generated }
LeWordAnnotationCompletionVisitor >> wordAttributesFor: aWordAnnotation [
	| words |
	words := GtPrefixTree new.
	aWordAnnotation hasExpandedSpecified ifFalse: [ words add: 'expanded' ].
	aWordAnnotation hasHeightSpecified ifFalse: [ words add: 'height=' ].
	^ words
]
