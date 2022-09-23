Class {
	#name : #LePharoRewriteSnippet,
	#superclass : #LeSnippet,
	#instVars : [
		'search',
		'replace',
		'scope'
	],
	#category : #'Lepiter-Snippet-Pharo-Rewrites-Model'
}

{ #category : #'api - accessing menu' }
LePharoRewriteSnippet class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemSpecification new
		snippetClass: self;
		title: 'Pharo rewrite'
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
		yourself
]

{ #category : #'lepiter-store' }
LePharoRewriteSnippet class >> leJsonV4Name [
	^ 'pharoRewrite'
]

{ #category : #accessing }
LePharoRewriteSnippet >> asSnippetViewModel [
	^ LePharoRewriteSnippetViewModel new snippetModel: self
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

{ #category : #accessing }
LePharoRewriteSnippet >> defaultScope [
	^ 'GtSearchImageMethodsFilter allMethods'
]

{ #category : #actions }
LePharoRewriteSnippet >> executeRewriteUsing: snippetContext [
	| model rewriter potentialMethods |
	model := RBNamespace new.
	rewriter := RBParseTreeRewriter new.
	rewriter replace: self search with: self replace.
	potentialMethods := self potentialMethodsUsing: snippetContext.
	^ (potentialMethods
		do: [ :each | 
			(rewriter executeTree: each ast copy)
				ifTrue: [ (model classFor: each methodClass) compileTree: rewriter tree ] ])
		await then: [ :value | model ] otherwise: [ :error | error ]
]

{ #category : #actions }
LePharoRewriteSnippet >> executeSearchUsing: snippetContext [
	| astSearchFilter |
	astSearchFilter := self search gtASTMatches.
	^ (self scopeFilterUsing: snippetContext)
		ifNil: [ astSearchFilter ]
		ifNotNil: [ :scopeFilter | scopeFilter & astSearchFilter ]
]

{ #category : #accessing }
LePharoRewriteSnippet >> isEmpty [
	^ search isNil and: [ replace isNil ]
]

{ #category : #private }
LePharoRewriteSnippet >> potentialMethodsUsing: snippetContext [
	| ast literals filter |
	filter := self scopeFilterUsing: snippetContext.
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
			filter ifNotNil: [ astFilter := astFilter & filter ].
			^ astFilter asAsyncStream ].
	^ filter
		ifNil: [ AsyncImageMethodsStream new ]
		ifNotNil: [ filter asAsyncStream ]
]

{ #category : #private }
LePharoRewriteSnippet >> potentialScopeExpressionsUsing: snippetContext [
	| variableBindings variables |
	variableBindings := snippetContext sharedBindings.
	variables := self potentialScopeVariables
			select: [ :each | 
				(variableBindings hasBindingOf: each asSymbol) not
					or: [ (variableBindings bindingOf: each asSymbol) value isKindOf: GtSearchFilter ] ].
	(snippetContext selfObject isKindOf: GtSearchFilter)
		ifTrue: [ variables add: 'self' ].
	GtSearchFilter allSearchFilterMethods
		do: [ :each | variables add: each methodClass instanceSide name asString , ' ' , each selector ].
	^ variables
]

{ #category : #accessing }
LePharoRewriteSnippet >> potentialScopeVariables [
	| variables |
	variables := Set new.
	self page
		allChildrenDepthFirstDo: [ :each | 
			each isCodeSnippet
				ifTrue: [ variables addAll: each coder implicitVariableNames ] ].
	^ variables
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
	^ (scope isNil or: [ scope isEmpty ])
		ifTrue: [ self defaultScope ]
		ifFalse: [ scope ]
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

{ #category : #private }
LePharoRewriteSnippet >> scopeFilterFor: aString using: snippetContext [
	| filter variableBindings name |
	variableBindings := snippetContext sharedBindings.
	name := (aString isNil or: [ aString isEmpty ])
			ifTrue: [ self defaultScope ]
			ifFalse: [ aString ].
	name = 'self'
		ifTrue: [ filter := snippetContext selfObject ]
		ifFalse: [ (name includes: $ )
				ifTrue: [ | items class selector |
					items := $  split: name.
					items size ~= 2 ifTrue: [ ^ nil ].
					class := self class environment
							at: items first asSymbol
							ifAbsent: [ ^ nil ].
					selector := items last asSymbol.
					(class respondsTo: selector) ifFalse: [ ^ nil ].
					filter := class perform: selector ]
				ifFalse: [ (variableBindings hasBindingOf: name asSymbol) ifFalse: [ ^ nil ].
					filter := (variableBindings bindingOf: name) value ] ].
	(filter isKindOf: GtSearchFilter) ifFalse: [ ^ nil ].
	^ filter
]

{ #category : #private }
LePharoRewriteSnippet >> scopeFilterUsing: snippetContext [
	| filter |
	filter := ([ self scopeFilterFor: self scope using: snippetContext ]
			on: Error
			do: [ :ex | 
				self inform: self scope , ' threw an error (' , ex message , ')'.
				ex return: nil ])
			ifNil: [ self
					inform: self scope , ' doesn''t evaluate to a search filter. Using all methods instead.'.
				GtSearchImageMethodsFilter allMethods ].
	^ filter select: [ :each | each isFromTrait not ]
]

{ #category : #accessing }
LePharoRewriteSnippet >> scopeLabelFor: aString using: snippetContext [
	^ (([ self scopeFilterFor: aString using: snippetContext ]
		on: Error
		do: [ :ex | ex return ]) ifNotNil: [ :filter | filter filterLabel ])
		ifNil: [ aString ]
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
	^ RBParser parseRewriteExpression: self search
]
