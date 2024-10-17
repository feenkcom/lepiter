Class {
	#name : #LeDatabaseIndex,
	#superclass : #GtIndex,
	#instVars : [
		'database',
		'titleCache',
		'selectorCache',
		'classCache'
	],
	#category : #'Lepiter-Core-Index'
}

{ #category : #references }
LeDatabaseIndex >> addReferencesFromSnippet: aSnippet [
	^ aSnippet classAndSelectorReferencesPromise
		then: [ :refs | 
			| classes selectors |
			classes := refs first.
			selectors := refs last.
			selectors notEmpty
				ifTrue: [ selectors
						do: [ :each | (self selectorCache add: each weight: 1) addSnippet: aSnippet ].
					aSnippet optionAt: #selectors put: selectors ].
			classes notEmpty
				ifTrue: [ classes
						do: [ :each | (self classCache add: each weight: 1) addSnippet: aSnippet ].
					aSnippet optionAt: #variables put: classes ] ]
]

{ #category : #events }
LeDatabaseIndex >> addTitle: name [
	self
		wordsIn: name
		do: [ :word | (titleCache add: word asLowercase weight: 1) addName: name ]
]

{ #category : #accessing }
LeDatabaseIndex >> asyncSnippetClassReferencesTo: aString [
	| trimmedString |
	self isActive ifFalse: [ self initializeCache ].
	trimmedString := aString trim.
	^ (((self classCache nodeFor: trimmedString)
		ifNil: [ #() ]
		ifNotNil: [ :node | node snippetsCollection asOrderedCollection ])
		asAsyncStream merge: (self asyncSnippetReferencesTo: aString))
		withoutDuplicates
]

{ #category : #accessing }
LeDatabaseIndex >> asyncSnippetReferencesTo: aString [
	| trimmedString |
	self isActive ifFalse: [ self initializeCache ].
	trimmedString := aString trim.
	^ ((self selectorCache nodeFor: trimmedString)
		ifNil: [ #() ]
		ifNotNil: [ :node | node snippetsCollection asOrderedCollection ])
		asAsyncStream
]

{ #category : #accessing }
LeDatabaseIndex >> asyncTitlesForWord: aString [
	| trimmedString |
	self isActive ifFalse: [ self initializeCache ].
	trimmedString := aString trim.
	^ (self asyncOrderedSearchForWords: trimmedString in: titleCache)
		withoutDuplicates
			useContentComparison
]

{ #category : #events }
LeDatabaseIndex >> basicSubscribe [
	database weak
		when: LePageTitleChanged
			send: #pageRenamed:
			to: self;
		when: LeDatabasePageAdded
			send: #pageAdded:
			to: self;
		when: LeDatabasePageRemoved
			send: #pageRemoved:
			to: self;
		when: LeSnippetContentChanged
			send: #snippetContentChanged:
			to: self;
		when: LeContentTreeAdded
			send: #snippetAdded:
			to: self;
		when: LeContentTreeRemoved
			send: #snippetRemoved:
			to: self
]

{ #category : #events }
LeDatabaseIndex >> basicUnsubscribe [
	database unsubscribe: self
]

{ #category : #private }
LeDatabaseIndex >> classCache [
	^ classCache ifNil: [ classCache := LeSnippetPrefixTree new ]
]

{ #category : #accessing }
LeDatabaseIndex >> computeIndex [
	database pagesDo: [ :each | (self processPageAdded: each) do: #wait ].
	self selectorCache allNodesDo: #compressData.
	self classCache allNodesDo: #compressData
]

{ #category : #accessing }
LeDatabaseIndex >> database [
	^ database
]

{ #category : #accessing }
LeDatabaseIndex >> database: aLeDatabase [
	database := aLeDatabase
]

{ #category : #accessing }
LeDatabaseIndex >> initialize [
	super initialize.
	titleCache := GtNamesPrefixTree new
]

{ #category : #events }
LeDatabaseIndex >> pageAdded: anAnnouncement [
	self processPageAdded: anAnnouncement page
]

{ #category : #events }
LeDatabaseIndex >> pageRemoved: anAnnouncement [
	self processPageRemoved: anAnnouncement page
]

{ #category : #events }
LeDatabaseIndex >> pageRenamed: anAnnouncement [
	self removeTitle: anAnnouncement oldTitle.
	self addTitle: anAnnouncement newTitle
]

{ #category : #private }
LeDatabaseIndex >> processPageAdded: each [
	| promises |
	self addTitle: each title.
	promises := OrderedCollection new.
	each
		allChildrenDepthFirstDo: [ :snippet | promises add: (self addReferencesFromSnippet: snippet) ].
	^ promises
]

{ #category : #private }
LeDatabaseIndex >> processPageRemoved: page [
	self removeTitle: page title.
	page allChildrenDepthFirstDo: [ :each | self removeReferencesFromSnippet: each ]
]

{ #category : #accessing }
LeDatabaseIndex >> recomputeIndex [
	titleCache := GtNamesPrefixTree new.
	selectorCache := nil.
	classCache := nil.
	self computeIndex
]

{ #category : #references }
LeDatabaseIndex >> removeReferencesFromSnippet: aSnippet [
	aSnippet
		optionAt: #selectors
		ifPresent: [ :selectors | 
			selectors
				do: [ :each | 
					(self selectorCache remove: each weight: 1)
						ifNotNil: [ :node | node removeSnippet: aSnippet ] ] ]
		ifAbsent: [  ].
	aSnippet clearOption: #selectors ifAbsent: [  ].
	aSnippet
		optionAt: #variables
		ifPresent: [ :classes | 
			classes
				do: [ :each | 
					(self classCache remove: each weight: 1)
						ifNotNil: [ :node | node removeSnippet: aSnippet ] ] ]
		ifAbsent: [  ].
	aSnippet clearOption: #variables ifAbsent: [  ]
]

{ #category : #events }
LeDatabaseIndex >> removeTitle: name [
	self
		wordsIn: name
		do: [ :word | 
			(titleCache remove: word asLowercase weight: 1)
				ifNotNil: [ :node | node removeName: name ] ]
]

{ #category : #private }
LeDatabaseIndex >> selectorCache [
	^ selectorCache ifNil: [ selectorCache := LeSnippetPrefixTree new ]
]

{ #category : #events }
LeDatabaseIndex >> snippetAdded: anAnnouncement [
	anAnnouncement content
		withAllChildrenBreadthFirstDo: [ :aSnippet | self addReferencesFromSnippet: aSnippet ]
]

{ #category : #events }
LeDatabaseIndex >> snippetContentChanged: anAnnouncement [
	self removeReferencesFromSnippet: anAnnouncement snippet.
	self addReferencesFromSnippet: anAnnouncement snippet
]

{ #category : #events }
LeDatabaseIndex >> snippetRemoved: anAnnouncement [
	anAnnouncement content
		withAllChildrenBreadthFirstDo: [ :aSnippet | self removeReferencesFromSnippet: aSnippet ]
]
