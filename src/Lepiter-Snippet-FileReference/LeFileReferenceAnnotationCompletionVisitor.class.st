"
Completion visitor for gtFileReference annotation.
"
Class {
	#name : #LeFileReferenceAnnotationCompletionVisitor,
	#superclass : #Object,
	#traits : 'TLeFileReferenceParseNodeVisitor',
	#classTraits : 'TLeFileReferenceParseNodeVisitor classTrait',
	#instVars : [
		'composite'
	],
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #'class initialization' }
LeFileReferenceAnnotationCompletionVisitor class >> initialize [
	LeContentCompletionVisitor additionalCompletionVisitors add: self
]

{ #category : #'class initialization' }
LeFileReferenceAnnotationCompletionVisitor class >> obsolete [
	LeContentCompletionVisitor additionalCompletionVisitors remove: self ifAbsent: [  ].
	^ super obsolete
]

{ #category : #private }
LeFileReferenceAnnotationCompletionVisitor >> addStreamFor: words startingWith: prefix [
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

{ #category : #private }
LeFileReferenceAnnotationCompletionVisitor >> attributeCompletionsStartingWith: aPrefix for: aPath [
	| annotation words |
	(aPrefix isNil or: [ aPrefix beginsWith: '"' ]) ifTrue: [ ^ GtPrefixTree new ].
	(aPrefix includes: $/) ifTrue: [ ^ GtPrefixTree new ].

	annotation := aPath parent.
	words := (annotation isNil or: [ (annotation respondsTo: #pathArgument) not ])
		ifTrue: [ self startAttributes ]
		ifFalse: [ self fileReferenceAttributesFor: annotation ].
	^ words
]

{ #category : #accessing }
LeFileReferenceAnnotationCompletionVisitor >> composite [
	^ composite
]

{ #category : #accessing }
LeFileReferenceAnnotationCompletionVisitor >> composite: aComposite [
	composite := aComposite
]

{ #category : #private }
LeFileReferenceAnnotationCompletionVisitor >> fileReferenceAttributesFor: aFileReferenceAnnotation [
	| words |
	words := GtPrefixTree new.
	aFileReferenceAnnotation pathArgument ifNil: [ words add: 'path=' ].
	aFileReferenceAnnotation labelArgument ifNil: [ words add: 'label=' ].
	aFileReferenceAnnotation rangeArgument ifNil: [ words add: 'range=' ].
	aFileReferenceAnnotation expandedArgument ifNil: [ words add: 'expanded=' ].
	aFileReferenceAnnotation heightArgument ifNil: [ words add: 'height=' ].
	^ words
]

{ #category : #private }
LeFileReferenceAnnotationCompletionVisitor >> isCompletionAtAnnotationStart [
	| source prefix start next pos |
	source := self text asString.
	prefix := 'gtFileReference:'.
	start := 0.
	next := source findString: prefix startingAt: 1.
	[ next > 0 ] whileTrue: [
		start := next.
		next := source findString: prefix startingAt: next + 1 ].
	start = 0 ifTrue: [ ^ false ].
	pos := self position.
	^ (pos >= (start + prefix size - 1)) and: [ pos <= (start + prefix size) ]
]

{ #category : #private }
LeFileReferenceAnnotationCompletionVisitor >> isPosition: aPosition insideToken: aToken [
	^ aPosition >= aToken startPosition
		and: [ aPosition <= (aToken stopPosition + 1) ]
]

{ #category : #private }
LeFileReferenceAnnotationCompletionVisitor >> pathCompletionsStartingWith: aPrefix [
	| words quoted normalizedPrefix dirPrefix partial baseDirectory dirReference entries |
	words := GtPrefixTree new.
	aPrefix ifNil: [ ^ words ].

	quoted := aPrefix beginsWith: '"'.
	normalizedPrefix := quoted
		ifTrue: [ (aPrefix copyFrom: 2 to: aPrefix size) copyReplaceAll: '""' with: '"' ]
		ifFalse: [ aPrefix ].
	(normalizedPrefix endsWith: '"') ifTrue: [ normalizedPrefix := normalizedPrefix copyFrom: 1 to: normalizedPrefix size - 1 ].

	dirPrefix := ''.
	partial := normalizedPrefix.
	(normalizedPrefix includes: $/)
		ifTrue: [
			| index |
			index := normalizedPrefix lastIndexOf: $/.
			dirPrefix := normalizedPrefix copyFrom: 1 to: index.
			partial := normalizedPrefix copyFrom: index + 1 to: normalizedPrefix size ].

	baseDirectory := FileSystem disk workingDirectory asFileReference.
	dirPrefix isEmpty
		ifFalse: [
			dirReference := baseDirectory resolveReference: dirPrefix asFileReference.
			(dirReference exists and: [ dirReference isDirectory ]) ifTrue: [ baseDirectory := dirReference ]
			ifFalse: [ ^ words ] ].

	entries := baseDirectory exists
		ifTrue: [ baseDirectory entries ]
		ifFalse: [ #() ].

	entries do: [ :each |
		| name candidate value |
		name := each basename.
		(name beginsWith: partial) ifTrue: [
			value := dirPrefix , name , (each isDirectory ifTrue: [ '/' ] ifFalse: [ '' ]).
			candidate := quoted
				ifTrue: [ '"' , (value copyReplaceAll: '"' with: '""') , '"' ]
				ifFalse: [ value ].
			words add: candidate ] ].

	^ words
]

{ #category : #private }
LeFileReferenceAnnotationCompletionVisitor >> pathPrefixFor: aToken [
	| source start stop |
	source := self text asString.
	start := aToken startPosition.
	stop := self position min: aToken stopPosition.
	stop < start ifTrue: [ ^ '' ].
	^ source copyFrom: start to: stop
]

{ #category : #accessing }
LeFileReferenceAnnotationCompletionVisitor >> position [
	^ self composite position
]

{ #category : #private }
LeFileReferenceAnnotationCompletionVisitor >> startAttributes [
	| words |
	words := GtPrefixTree new.
	words add: 'path='.
	words add: 'label='.
	words add: 'range='.
	words add: 'expanded='.
	words add: 'height='.
	^ words
]

{ #category : #accessing }
LeFileReferenceAnnotationCompletionVisitor >> text [
	^ self composite text
]

{ #category : #visiting }
LeFileReferenceAnnotationCompletionVisitor >> visitFileReferenceAnnotation: anAnnotation [
	(anAnnotation bars notEmpty and: [ anAnnotation bars last stopPosition = self position ])
		ifTrue: [
			| words |
			words := self fileReferenceAttributesFor: anAnnotation.
			words notEmpty ifTrue: [ ^ self addStreamFor: words startingWith: '' ] ].
	^ self visitFileReferenceParse: anAnnotation
]

{ #category : #visiting }
LeFileReferenceAnnotationCompletionVisitor >> visitFileReferencePath: aPath [
	| valueToken prefix pathWords attributeWords words |
	valueToken := aPath value.
	valueToken ifNil: [ ^ self visitFileReferenceArgument: aPath ].
	(self isPosition: self position insideToken: valueToken)
		ifFalse: [ ^ self visitFileReferenceArgument: aPath ].
	prefix := self pathPrefixFor: valueToken.
	pathWords := self pathCompletionsStartingWith: prefix.
	attributeWords := self attributeCompletionsStartingWith: prefix for: aPath.
	words := GtPrefixTree new.
	pathWords do: [ :each | words add: each ].
	attributeWords do: [ :each | words add: each ].
	words isEmpty ifTrue: [ ^ self visitFileReferenceArgument: aPath ].
	^ self addStreamFor: words startingWith: prefix
]

{ #category : #visiting }
LeFileReferenceAnnotationCompletionVisitor >> visitSmaCCError: anError [
	(self isCompletionAtAnnotationStart)
		ifTrue: [ ^ self addStreamFor: self startAttributes startingWith: '' ].
	^ self visitFileReferenceParse: anError
]
