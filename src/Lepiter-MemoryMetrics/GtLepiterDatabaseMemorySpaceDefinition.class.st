"
I declare how the memory space of a Lepiter database is estimated:
- the categories, with their descriptions (see #initializeCategories);
- how pages and snippets, the coders of code snippets, the options of snippets and the database itself are attributed to these categories (see #newContentAttribution, #newCoderAttribution, #newOptionsAttribution and #newDatabaseAttribution, and the Attributions view);
- the roots: every page and snippet, then the database (see #rootsOf:do:);
- the boundary: walks stop at other pages and snippets, databases, announcement subscriptions and UI objects, and strings and SmaCC objects are tagged (see #newBoundary).

Use #default, and #estimate: with a database. {{gtClass:GtLepiterDatabaseMemoryMetrics}} presents the result.
"
Class {
	#name : #GtLepiterDatabaseMemorySpaceDefinition,
	#superclass : #GtMemorySpaceDefinition,
	#instVars : [
		'contentAttribution',
		'coderAttribution',
		'optionsAttribution',
		'databaseAttribution'
	],
	#classInstVars : [
		'default'
	],
	#category : #'Lepiter-MemoryMetrics'
}

{ #category : #accessing }
GtLepiterDatabaseMemorySpaceDefinition class >> default [
	<gtExample>
	<noTest>
	^ default ifNil: [ default := self new ]
]

{ #category : #accessing }
GtLepiterDatabaseMemorySpaceDefinition class >> reset [
	default := nil
]

{ #category : #accessing }
GtLepiterDatabaseMemorySpaceDefinition >> contentAttribution [
	^ contentAttribution
]

{ #category : #accessing }
GtLepiterDatabaseMemorySpaceDefinition >> databaseAttribution [
	^ databaseAttribution
]

{ #category : #accessing }
GtLepiterDatabaseMemorySpaceDefinition >> expectedObjectsFor: aDatabase [
	"About 150 objects for each page and snippet"

	| count |
	count := 0.
	aDatabase
		pagesDo: [ :aPage | 
			count := count + 1.
			aPage allChildrenDepthFirstDo: [ :aSnippet | count := count + 1 ] ].
	^ count * 150
]

{ #category : #initialization }
GtLepiterDatabaseMemorySpaceDefinition >> initialize [
	super initialize.
	
	self initializeCategories.
	self initializeAttributions
]

{ #category : #initialization }
GtLepiterDatabaseMemorySpaceDefinition >> initializeAttributions [
	"The coder and options attributions are used by the content attribution"

	coderAttribution := self newCoderAttribution.
	optionsAttribution := self newOptionsAttribution.
	contentAttribution := self newContentAttribution.
	databaseAttribution := self newDatabaseAttribution
]

{ #category : #initialization }
GtLepiterDatabaseMemorySpaceDefinition >> initializeCategories [
	self
		category: #pagesAndSnippets
			named: 'Pages and snippets'
			description: 'The page and snippet objects, and the collections of their children.';
		category: #text
			named: 'Text'
			description: 'The text of text, quote and comment snippets: ropes, strings and attributes. The text of code snippets is in Code source.';
		category: #textASTs
			named: 'Text ASTs'
			description: 'The SmaCC parse trees of text snippets. Each tree keeps a copy of the text and a string for every token.';
		category: #codeASTs
			named: 'Code ASTs (coder caches)'
			description: 'The ASTs cached by the coders of code snippets. Indexing the database asks every code snippet for its AST, so after indexing every code snippet keeps one.';
		category: #codeSource
			named: 'Code source'
			description: 'The source code of code snippets, kept by their coders.';
		category: #codeCoders
			named: 'Code coders'
			description: 'The coders of code snippets, without their AST caches, source code and announcers.';
		category: #links
			named: 'Links'
			description: 'Links between pages, kept by the database and in the #incomingLinks option of snippets.';
		category: #index
			named: 'Index'
			description: 'The index of the database (LeDatabaseIndex), with prefix trees for page titles and for the selectors and classes referenced in snippets.';
		category: #indexReferences
			named: 'Index references in snippets'
			description: 'The #selectors and #variables options that indexing stores in snippets.';
		category: #times
			named: 'Times'
			description: 'The creation and edit times of pages and snippets.';
		category: #announcers
			named: 'Announcers'
			description: 'The announcers of pages, snippets, coders and the database.';
		category: #uidsAndEmails
			named: 'UIDs and emails'
			description: 'The uids, and the creation and edit emails, of pages and snippets.';
		category: #options
			named: 'Options'
			description: 'The options of snippets, except links and index references.';
		category: #pageEditHistory
			named: 'Page edit history'
			description: 'The edit history of pages.';
		category: #otherSnippetData
			named: 'Other snippet data'
			description: 'The other slots of pages and snippets, specific to each kind of snippet.';
		category: #databaseStructures
			named: 'Database structures'
			description: 'The database, its dictionaries for looking up pages and snippets, and its store monitor.'
]

{ #category : #accessing }
GtLepiterDatabaseMemorySpaceDefinition >> newBoundary [
	"Stop at objects that do not belong to the database or are shared: 
	other pages and snippets (they are separate roots), databases, 
	announcement subscriptions, and UI objects.
	Tag strings and SmaCC objects (nodes, tokens, intervals, scanner states)."

	^ GtMemorySpaceBoundary default
		stopAtInstancesOf: {LeContent.
				LeDatabase.
				LeLogicalDatabase.
				AbstractAnnouncementSubscription.
				Semaphore.
				BlockClosure.
				BlElement.
				BlSpace};
		tag: #string
			instancesOf: {ByteString.
					WideString};
		tag: #smacc
			classesMatching: [ :aClass | 
				(aClass name beginsWith: 'SmaCC')
					or: [ aClass includesBehavior: SmaCCParseNode ] ];
		yourself
]

{ #category : #initialization }
GtLepiterDatabaseMemorySpaceDefinition >> newCoderAttribution [
	"The coders of code snippets"

	^ GtMemorySpaceSlotsAttribution new
		objectCategory: (self category: #codeCoders);
		slots: #(astCache previousAst astPromise) to: (self category: #codeASTs);
		slot: #sourceCode to: (self category: #codeSource);
		slot: #announcer to: (self category: #announcers);
		yourself
]

{ #category : #initialization }
GtLepiterDatabaseMemorySpaceDefinition >> newContentAttribution [
	"Pages and snippets"

	^ GtMemorySpaceSlotsAttribution new
		objectCategory: (self category: #pagesAndSnippets);
		ignoreSlots: #(parent database);
		slot: #text to: (self category: #text);
		slot: #ast to: (self category: #textASTs);
		slots: #(createTime editTime latestEditTime) to: (self category: #times);
		slots: #(createEmail editEmail uid) to: (self category: #uidsAndEmails);
		slot: #announcer to: (self category: #announcers);
		slot: #children to: (self category: #pagesAndSnippets);
		slot: #editHistory to: (self category: #pageEditHistory);
		slot: #coder by: coderAttribution;
		slot: #options by: optionsAttribution;
		otherSlotsTo: (self category: #otherSnippetData);
		yourself
]

{ #category : #initialization }
GtLepiterDatabaseMemorySpaceDefinition >> newDatabaseAttribution [
	"The database, without its pages"

	^ GtMemorySpaceSlotsAttribution new
		objectCategory: (self category: #databaseStructures);
		slot: #index to: (self category: #index);
		slots: #(explicitLinks contentLinksByOrigin) to: (self category: #links);
		slot: #announcer to: (self category: #announcers);
		yourself
]

{ #category : #initialization }
GtLepiterDatabaseMemorySpaceDefinition >> newOptionsAttribution [
	"The options of snippets"

	^ GtMemorySpaceDictionaryAttribution new
		objectCategory: (self category: #options);
		key: #incomingLinks to: (self category: #links);
		keys: #(selectors variables) to: (self category: #indexReferences);
		yourself
]

{ #category : #accessing }
GtLepiterDatabaseMemorySpaceDefinition >> rootsOf: aDatabase do: aBlock [
	"Every page and snippet, then the database itself"

	aDatabase
		pagesDo: [ :aPage | 
			aBlock value: aPage value: contentAttribution.
			aPage
				allChildrenDepthFirstDo: [ :aSnippet | aBlock value: aSnippet value: contentAttribution ] ].
	aBlock value: aDatabase value: databaseAttribution
]

{ #category : #accessing }
GtLepiterDatabaseMemorySpaceDefinition >> rules [
	^ {GtMemorySpaceRule
			label: 'Pages and snippets'
			attribution: contentAttribution.
		GtMemorySpaceRule label: 'Database' attribution: databaseAttribution}
]
