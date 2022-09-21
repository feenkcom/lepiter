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

{ #category : #actions }
LePharoRewriteSnippet >> executeRewriteUsing: variableBindings [
	| model rewriter potentialMethods |
	model := RBNamespace new.
	rewriter := RBParseTreeRewriter new.
	rewriter replace: self search with: self replace.
	potentialMethods := self potentialMethodsUsing: variableBindings.
	^ (potentialMethods
		do: [ :each | 
			(rewriter executeTree: each ast copy)
				ifTrue: [ (model classFor: each methodClass) compileTree: rewriter tree ] ])
		then: [ :done | model ]
]

{ #category : #actions }
LePharoRewriteSnippet >> executeSearchUsing: variableBindings [
	| astSearchFilter |
	astSearchFilter := self search gtASTMatches.
	^ (self scopeFilterUsing: variableBindings)
		ifNil: [ astSearchFilter ]
		ifNotNil: [ :scopeFilter | scopeFilter & astSearchFilter ]
]

{ #category : #accessing }
LePharoRewriteSnippet >> isEmpty [
	^ search isNil and: [ replace isNil ]
]

{ #category : #private }
LePharoRewriteSnippet >> potentialMethodsUsing: variableBindings [
	| ast literals filter |
	filter := self scopeFilterUsing: variableBindings.
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

{ #category : #private }
LePharoRewriteSnippet >> potentialScopeVariablesUsing: variableBindings [
	^ self potentialScopeVariables
		select: [ :each | 
			(variableBindings hasBindingOf: each asSymbol) not
				or: [ (variableBindings bindingOf: each asSymbol) value isKindOf: GtSearchFilter ] ]
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

{ #category : #actions }
LePharoRewriteSnippet >> scopeFilterUsing: variableBindings [
	| filter |
	(scope isNil or: [ scope trim isEmpty ]) ifTrue: [ ^ nil ].
	(variableBindings hasBindingOf: scope asSymbol)
		ifFalse: [ self inform: scope , ' has no value. Have you evaluated it yet?'.
			^ nil ].
	filter := (variableBindings bindingOf: scope) value.
	(filter isKindOf: GtSearchFilter)
		ifFalse: [ self inform: scope , ' isn''t a search filter -- using all methods instead.'.
			^ nil ].
	^ filter select: [ :each | each isFromTrait not ]
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
