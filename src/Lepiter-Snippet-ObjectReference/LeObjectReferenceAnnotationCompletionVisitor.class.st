Class {
	#name : #LeObjectReferenceAnnotationCompletionVisitor,
	#superclass : #Object,
	#traits : 'TSmaCCComponentVisitor + (TLeObjectReferenceParseNodeVisitor - {#acceptNode:})',
	#classTraits : 'TSmaCCComponentVisitor classTrait + TLeObjectReferenceParseNodeVisitor classTrait',
	#instVars : [
		'composite'
	],
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #initialization }
LeObjectReferenceAnnotationCompletionVisitor class >> initialize [
	LeContentCompletionVisitor additionalCompletionVisitors add: self
]

{ #category : #initialization }
LeObjectReferenceAnnotationCompletionVisitor class >> obsolete [
	LeContentCompletionVisitor additionalCompletionVisitors remove: self
		ifAbsent: [].
	super obsolete
]

{ #category : #visiting }
LeObjectReferenceAnnotationCompletionVisitor >> addStreamFor: words startingWith: prefix [
	^self composite
		addStream: ((words asyncStreamStartingWith: prefix) collect: 
					[:each |
					GtInsertTextCompletionAction
						labeled: (self composite strategy labelFor: each withSearch: prefix)
						completion: (each allButFirst: prefix size)
						position: self position])
]

{ #category : #private }
LeObjectReferenceAnnotationCompletionVisitor >> objectReferenceAttributesFor: anAnnotation [
	| words |
	words := GtPrefixTree new.
	anAnnotation hasLabelSpecified ifFalse: [words add: 'label=#'].
	anAnnotation hasExpandedSpecified ifFalse: [words add: 'expanded'].
	anAnnotation hasFallbackLabelSpecified
		ifFalse: [words add: 'fallbackLabelString='''].
	anAnnotation hasShowSpecified ifFalse: [words add: 'show=#'].
	anAnnotation hasHeightSpecified ifFalse: [words add: 'height='].
	^words
]

{ #category : #accessing }
LeObjectReferenceAnnotationCompletionVisitor >> position [
	^self composite position
]

{ #category : #visiting }
LeObjectReferenceAnnotationCompletionVisitor >> visitObjectReferenceAnnotation: anAnnotation [
	(anAnnotation bars notEmpty
		and: [anAnnotation bars last stopPosition = self position])
			ifTrue: 
				[| words |
				words := self objectReferenceAttributesFor: anAnnotation.
				words notEmpty ifTrue: [^self addStreamFor: words startingWith: '']].
	^self visitObjectReferenceParse: anAnnotation
]
