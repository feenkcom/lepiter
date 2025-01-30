Class {
	#name : #LeSmaCCRewriteSnippet,
	#superclass : #LeSnippet,
	#instVars : [
		'search',
		'replace',
		'scope',
		'parser',
		'startingState'
	],
	#category : #'Lepiter-Snippet-SmaCC-Rewrites-Model'
}

{ #category : #'api - accessing menu' }
LeSmaCCRewriteSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: self description
]

{ #category : #'api - accessing menu' }
LeSmaCCRewriteSnippet class >> description [
	^ 'SmaCC rewrite'
]

{ #category : #'instance creation' }
LeSmaCCRewriteSnippet class >> empty [
	^ self new
		search: '';
		replace: '';
		scope: nil;
		yourself
]

{ #category : #'mapping - model' }
LeSmaCCRewriteSnippet class >> leJsonV3AttributeMapping [
	^ super leJsonV3AttributeMapping
		add: #search -> #search;
		add: #replace -> #replace;
		add: #scope -> #scope;
		add: #parser -> #parser;
		add: #startingState -> #startingState;
		yourself
]

{ #category : #'lepiter-store' }
LeSmaCCRewriteSnippet class >> leJsonV3Name [
	^ 'SmaCCRewrite'
]

{ #category : #'mapping - model' }
LeSmaCCRewriteSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: #search -> #search;
		add: #replace -> #replace;
		add: #scope -> #scope;
		add: #parser -> #parser;
		add: #startingState -> #startingState;
		yourself
]

{ #category : #'lepiter-store' }
LeSmaCCRewriteSnippet class >> leJsonV4Name [
	^ 'SmaCCRewrite'
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> asSnippetViewModel [
	^ LeSmaCCRewriteSnippetViewModel new snippetModel: self
]

{ #category : #testing }
LeSmaCCRewriteSnippet >> canMoveToAnotherDatabase [
	^ true
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> contentAsString [
	^ String
		streamContents: [ :stream | 
			stream nextPutAll: 'SmaCCRewrite:'.
			stream
				nextPutAll: 'search=';
				print: (search ifNil: [ '' ]);
				nextPutAll: '|replace=';
				print: (replace ifNil: [ '' ]);
				nextPutAll: '|scope=';
				print: (scope ifNil: [ '' ]);
				nextPutAll: '|parser=';
				print: (parser ifNil: [ '' ]);
				nextPutAll: '|startingState=';
				print: (startingState ifNil: [ '' ]) ]
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> directory [
	
]

{ #category : #actions }
LeSmaCCRewriteSnippet >> executeReplaceIn: fileRefs [
	^ self executeReplaceInFiles: (self fileReferencesIn: fileRefs)
]

{ #category : #actions }
LeSmaCCRewriteSnippet >> executeReplaceInFile: aFileReference for: aRewrite [
	| ast engine source newSource |
	source := self parserClass
			contentsOfFile: aFileReference
			encoding: self parserClass defaultEncoding.
	ast := self parserClass parseWithErrors: source.
	ast filename: aFileReference.
	engine := SmaCCRewriteEngine new rewriteRule: aRewrite.
	engine source: (SmaCCString on: source).
	engine rewrite: ast.
	newSource := engine source.
	^ LeSmaCCRewriteReplaceFileResult new
		file: aFileReference;
		parserClass: self parserClass;
		originalSource: source;
		newSource: (newSource isModified ifTrue: [ newSource asString ]);
		yourself
]

{ #category : #actions }
LeSmaCCRewriteSnippet >> executeReplaceInFiles: anAsyncStream [
	| rewrite |
	rewrite := SmaCCRewriteFile new
			parserClass: self parserClass;
			addTransformation: (SmaCCRewrite
					comment: ''
					match: (SmaCCRewriteTreeMatch new
							startingState: startingState;
							source: self search;
							yourself)
					transformation: (SmaCCRewriteStringTransformation new string: self replace)).
	^ LeSmaCCRewriteReplaceResult new
		fileResultsStream: (anAsyncStream collect: [ :each | self executeReplaceInFile: each for: rewrite ])
]

{ #category : #actions }
LeSmaCCRewriteSnippet >> executeSearchIn: fileRefs [
	| result |
	result := self executeSearchInFiles: (self fileReferencesIn: fileRefs).
	(fileRefs size = 1 and: [ fileRefs first isDirectory ])
		ifTrue: [ result directory: fileRefs first ].
	^ result
]

{ #category : #actions }
LeSmaCCRewriteSnippet >> executeSearchInFile: aFileReference for: patterns [
	| ast |
	ast := self parserClass parseFileWithErrors: aFileReference.
	^ LeSmaCCRewriteSearchFileResult new
		file: aFileReference;
		nodes: (ast asyncWithAllNodesStream
				select: [ :each | patterns anySatisfy: [ :node | node match: each inContext: Dictionary new ] ]);
		yourself
]

{ #category : #actions }
LeSmaCCRewriteSnippet >> executeSearchInFiles: anAsyncStream [
	| patterns searchResult |
	patterns := self searchPatterns.
	searchResult := LeSmaCCRewriteSearchResult new.
	searchResult parser: self parserClass.
	searchResult
		fileResultsStream: (anAsyncStream
				collect: [ :each | 
					(self executeSearchInFile: each for: patterns)
						owner: searchResult;
						yourself ]).
	^ searchResult
]

{ #category : #actions }
LeSmaCCRewriteSnippet >> fileReferencesIn: fileRefs [
	| refs |
	^ self parserClass
		ifNil: [ #() asAsyncStream ]
		ifNotNil: [ :cls | 
			refs := fileRefs isCollection ifTrue: [ fileRefs ] ifFalse: [ {fileRefs} ].
			(refs
				inject: #() asAsyncStream
				into: [ :sum :each | 
					sum
						merge: (each isDirectory
								ifTrue: [ each
										asyncAllFilesWithExtensions: (cls fileExtensions collect: [ :ext | ext allButFirst ]) ]
								ifFalse: [ {each} asAsyncStream ]) ]) withoutDuplicates ]
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> filterDescriptorNamesAndValuesDo: aBlock [
	(scope isNil or: [ scope isEmpty ]) ifTrue: [ ^ self ].
	^ (RBParser parseExpression: scope) value
		do: [ :each | 
			each isString
				ifTrue: [ aBlock cull: each cull: nil ]
				ifFalse: [ aBlock cull: each first cull: each second ] ]
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> filterDescriptorsUsing: aContext [
	| variableBindings descriptors variables snippetContext |
	descriptors := OrderedCollection new.
	snippetContext := aContext ifNil: [ LeSharedSnippetContext new ].
	variableBindings := snippetContext sharedBindings.
	variables := self allSnippetVariables
			select: [ :each | 
				(variableBindings hasBindingOf: each asSymbol) not
					or: [ self isRewritable: (variableBindings bindingOf: each asSymbol) value ] ].
	variables asSortedCollection
		reverseDo: [ :each | 
			descriptors
				addFirst: (GtFilterDescriptor new
						valueNotRequired;
						creator: [ :value | 
							((variableBindings bindingOf: each asSymbol) value
								ifNotNil: [ :obj | (self isRewritable: obj) ifTrue: [ obj ] ])
								ifNil: [ self
										inform: each , ' should be a file reference or a collection of file references.'.
									#() ] ];
						named: each;
						order: 0) ].
	(self isRewritable: snippetContext selfObject)
		ifTrue: [ descriptors
				addFirst: (GtFilterDescriptor new
						valueNotRequired;
						creator: [ :value | snippetContext selfObject ];
						named: 'self';
						order: 0) ].
	^ descriptors
]

{ #category : #testing }
LeSmaCCRewriteSnippet >> isRewritable: anObject [
	(anObject isKindOf: AbstractFileReference) ifTrue: [ ^ anObject exists ].
	^ anObject isCollection
		and: [ anObject allSatisfy: [ :each | self isRewritable: each ] ]
]

{ #category : #'as yet unclassified' }
LeSmaCCRewriteSnippet >> markdownOn: stream level: anInteger [
	"Placeholder. What should we do here?"

	anInteger * 4 timesRepeat: [ stream nextPut: Character space ].
	stream
		cr;
		<< '```';
		cr;
		<< self contentAsString trimBoth;
		cr;
		<< '```';
		cr.
	self
		childrenDo: [ :child | 
			stream cr.
			child markdownOn: stream level: anInteger + 1 ]
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> parser [
	^ parser
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> parser: aString [
	parser := aString ifNotNil: [ aString asSymbol ].
	self
		notifyAnnouncement: (LeSmaCCRewriteSnippetParserChanged new
				source: self;
				snippet: self;
				parser: parser).
	(self parserClass
		ifNil: [ false ]
		ifNotNil: [ self parserClass startingStateNames includes: startingState ])
		ifFalse: [ self startingState: nil ]
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> parserClass [
	^ Smalltalk at: self parser ifAbsent: [  ]
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> replace [
	^ replace
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> replace: aString [
	replace := aString.
	self
		notifyAnnouncement: (LeSmaCCRewriteSnippetReplaceChanged new
				source: self;
				snippet: self;
				replace: aString)
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> scope [
	^ scope
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> scope: aString [
	scope := aString.
	self
		notifyAnnouncement: (LeSmaCCRewriteSnippetScopeChanged new
				source: self;
				snippet: self;
				scope: aString)
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> search [
	^ search
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> search: aString [
	search := aString.
	self
		notifyAnnouncement: (LeSmaCCRewriteSnippetSearchChanged new
				source: self;
				snippet: self;
				search: aString)
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> searchPatterns [
	^ self parserClass
		ifNil: [ #() ]
		ifNotNil: [ :cls | 
			| index |
			index := self startingStateIndex.
			index < 1
				ifTrue: [ cls parseAndCacheAllPossibleStates: self search ]
				ifFalse: [ cls parseAndCacheAll: self search startingAt: index ] ]
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> startingState [
	^ startingState
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> startingState: aString [
	startingState := aString.
	self
		notifyAnnouncement: (LeSmaCCRewriteSnippetStartingStateChanged new
				source: self;
				snippet: self;
				startingState: aString)
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> startingStateIndex [
	^ (startingState
		ifNotNil: [ [ self parserClass perform: ('startingStateFor' , startingState) asSymbol ]
				on: Error
				do: [ :ex | ex return ] ]) ifNil: [ 0 ]
]

{ #category : #accessing }
LeSmaCCRewriteSnippet >> storeOn: aStream [
	aStream << '(' << self className << ' new search: ' << search storeString
		<< '; replace: ' << replace storeString << '; scope: ' << scope storeString
		<< '; parser: ' << parser storeString << '; startingState: '
		<< startingState storeString << '; yourself)'
]
