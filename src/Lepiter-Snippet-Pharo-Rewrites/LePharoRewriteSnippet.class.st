Class {
	#name : #LePharoRewriteSnippet,
	#superclass : #LeSnippet,
	#instVars : [
		'search',
		'replace',
		'scope',
		'isMethodPattern'
	],
	#category : #'Lepiter-Snippet-Pharo-Rewrites-Model'
}

{ #category : #'api - accessing menu' }
LePharoRewriteSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: self description
]

{ #category : #'api - accessing menu' }
LePharoRewriteSnippet class >> description [
	^ 'Pharo rewrite'
]

{ #category : #'instance creation' }
LePharoRewriteSnippet class >> empty [
	^ self new
		search: '';
		replace: '';
		scope: nil;
		yourself
]

{ #category : #'mapping - model' }
LePharoRewriteSnippet class >> leJsonV3AttributeMapping [
	^ super leJsonV3AttributeMapping
		add: #search -> #search;
		add: #replace -> #replace;
		add: #scope -> #scope;
		add: #isMethodPattern -> #isMethodPattern;
		yourself
]

{ #category : #'lepiter-store' }
LePharoRewriteSnippet class >> leJsonV3Name [
	^ 'pharoRewrite'
]

{ #category : #'mapping - model' }
LePharoRewriteSnippet class >> leJsonV4AttributeMapping [
	^ super leJsonV4AttributeMapping
		add: #search -> #search;
		add: #replace -> #replace;
		add: #scope -> #scope;
		add: #isMethodPattern -> #isMethodPattern;
		yourself
]

{ #category : #'lepiter-store' }
LePharoRewriteSnippet class >> leJsonV4Name [
	^ 'pharoRewrite'
]

{ #category : #visiting }
LePharoRewriteSnippet >> acceptVisitor: aVisitor [

	^ aVisitor visitPharoRewriteSnippet: self
]

{ #category : #accessing }
LePharoRewriteSnippet >> asSnippetViewModel [
	^ LePharoRewriteSnippetViewModel new snippetModel: self
]

{ #category : #testing }
LePharoRewriteSnippet >> canMoveToAnotherDatabase [
	^ true
]

{ #category : #accessing }
LePharoRewriteSnippet >> contentAsString [
	^ String
		streamContents: [ :stream | 
			stream nextPutAll: 'Rewrite:'.
			stream
				nextPutAll: 'search=';
				print: (search ifNil: [ '' ]);
				nextPutAll: '|replace=';
				print: (replace ifNil: [ '' ]);
				nextPutAll: '|scope=';
				print: (scope ifNil: [ '' ]) ]
]

{ #category : #actions }
LePharoRewriteSnippet >> executeRewriteInFilter: aFilter [
	| model rewriter potentialMethods |
	model := RBNamespace new.
	rewriter := RBParseTreeRewriter new.
	self isMethodPattern
		ifTrue: [ rewriter replaceMethod: self search with: self replace ]
		ifFalse: [ rewriter replace: self search with: self replace ].
	potentialMethods := self potentialMethodsInFilter: aFilter.
	^ (potentialMethods
		do: [ :each | 
			(rewriter executeTree: each ast copy)
				ifTrue: [ (model classFor: each methodClass) compileTree: rewriter tree ] ])
		await then: [ :value | model ] otherwise: [ :error | error ]
]

{ #category : #actions }
LePharoRewriteSnippet >> executeSearchInFilter: aFilter [
	| astSearchFilter |
	astSearchFilter := self isMethodPattern
			ifTrue: [ self search gtASTMethodMatches ]
			ifFalse: [ self search gtASTMatches ].
	^ aFilter ifNil: [ astSearchFilter ] ifNotNil: [ aFilter & astSearchFilter ]
]

{ #category : #accessing }
LePharoRewriteSnippet >> filterDescriptorNamesAndValuesDo: aBlock [
	(scope isNil or: [ scope isEmpty ]) ifTrue: [ ^ self ].
	scope first = $# ifFalse: [ ^ aBlock cull: scope cull: ''	"old format" ].
	^ (RBParser parseExpression: scope) value
		do: [ :each | 
			each isString
				ifTrue: [ aBlock cull: each cull: nil ]
				ifFalse: [ aBlock cull: each first cull: each second ] ]
]

{ #category : #private }
LePharoRewriteSnippet >> filterDescriptorsUsing: snippetContext [
	| variableBindings descriptors variables |
	descriptors := GtSearchFilter globalFilterDescriptors.
	variableBindings := snippetContext 
		ifNil: [ GtSharedVariablesBindings new ]
		ifNotNil: [ :aContext |
			aContext sharedBindings ].
	variables := self allSnippetVariables
			select: [ :each | 
				(variableBindings hasBindingOf: each asSymbol) not
					or: [ (variableBindings bindingOf: each asSymbol) value isKindOf: GtSearchFilter ] ].
	variables asSortedCollection
		reverseDo: [ :each | 
			descriptors
				addFirst: (GtFilterDescriptor new
						valueNotRequired;
						creator: [ :value | 
							((variableBindings bindingOf: each asSymbol) value
								ifNotNil: [ :obj | (obj isKindOf: GtSearchFilter) ifTrue: [ obj ] ])
								ifNil: [ self inform: each , ' is not a search filter. Using all methods instead.'.
									GtSearchImageMethodsFilter forAllMethods ] ];
						named: each;
						order: 0) ].
	(snippetContext notNil and: [ 
		snippetContext selfObject isKindOf: GtSearchFilter])
			ifTrue: [ descriptors
				addFirst: (GtFilterDescriptor new
						valueNotRequired;
						creator: [ :value | snippetContext selfObject ];
						named: 'self';
						order: 0) ].
	^ descriptors
]

{ #category : #accessing }
LePharoRewriteSnippet >> isMethodPattern [
	<return: #Boolean>
	^ isMethodPattern ifNil: [ false ]
]

{ #category : #accessing }
LePharoRewriteSnippet >> isMethodPattern: aBoolean [
	isMethodPattern := aBoolean.
	self
		notifyAnnouncement: (LePharoRewriteSnippetIsMethodPatternChanged new
				source: self;
				snippet: self;
				isMethodPattern: aBoolean)
]

{ #category : #'private - exporting' }
LePharoRewriteSnippet >> markdownOn: stream level: anInteger [
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

{ #category : #private }
LePharoRewriteSnippet >> potentialMethodsInFilter: aFilter [
	| ast literals filter |
	filter := (aFilter ifNil: [ GtSearchImageMethodsFilter forAllMethods ])
			select: [ :each | each isFromTrait not ].
	ast := self searchAST.
	literals := Set withAll: ast sentMessages.
	literals isEmpty
		ifTrue: [ ast
				nodesDo: [ :each | 
					each isVariable
						ifTrue: [ (self class environment bindingOf: each name)
								ifNotNil: [ :binding | 
									(binding value isBehavior and: [ binding name = binding value name ])
										ifTrue: [ literals add: binding ] ] ] ] ].
	literals notEmpty
		ifTrue: [ | astFilter |
			astFilter := (literals
					collect: [ :each | GtSearchReferencesFilter literal: each ])
					reduce: [ :a :b | a & b ].
			astFilter := astFilter & filter.
			^ astFilter asAsyncStream ].
	^ filter asAsyncStream
]

{ #category : #accessing }
LePharoRewriteSnippet >> replace [
	^ replace
]

{ #category : #accessing }
LePharoRewriteSnippet >> replace: aString [
	replace := aString.
	self
		notifyAnnouncement: (LePharoRewriteSnippetReplaceChanged new
				source: self;
				snippet: self;
				replace: aString)
]

{ #category : #accessing }
LePharoRewriteSnippet >> scope [
	^ scope
]

{ #category : #accessing }
LePharoRewriteSnippet >> scope: aString [
	scope := aString.
	self
		notifyAnnouncement: (LePharoRewriteSnippetScopeChanged new
				source: self;
				snippet: self;
				scope: aString)
]

{ #category : #accessing }
LePharoRewriteSnippet >> search [
	^ search
]

{ #category : #accessing }
LePharoRewriteSnippet >> search: aString [
	search := aString.
	self
		notifyAnnouncement: (LePharoRewriteSnippetSearchChanged new
				source: self;
				snippet: self;
				search: aString)
]

{ #category : #accessing }
LePharoRewriteSnippet >> searchAST [
	^ self isMethodPattern
		ifTrue: [ RBParser parseRewriteMethod: self search ]
		ifFalse: [ RBParser parseRewriteExpression: self search ]
]

{ #category : #printing }
LePharoRewriteSnippet >> storeOn: aStream [
	aStream nextPutAll: '(LePharoRewriteSnippet new search: '.
	self search storeOn: aStream.
	aStream nextPutAll: '; replace: '.
	self replace storeOn: aStream.
	aStream nextPutAll: '; yourself)'
]
