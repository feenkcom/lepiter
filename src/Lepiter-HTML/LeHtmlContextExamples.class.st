"
I have examples of {{gtClass:LeHtmlContext}}, the state that {{gtClass:TLeHtmlPiece}} pieces share while they write one HTML page. I check that a context copied with a new stream really writes to the new stream and not to the stream of the original context.
"
Class {
	#name : #LeHtmlContextExamples,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #examples }
LeHtmlContextExamples >> copyWithNewStreamKeepsPage [
	<gtExample>
	<return: #LeHtmlContext>
	| aPage aContext aCopy |
	aPage := LePage new.
	aPage title: 'Page'.
	aContext := LeHtmlContext new.
	aContext page: aPage.
	aContext newStream: (WriteStream on: String new).

	aCopy := aContext copyWithNewStream: (WriteStream on: String new).

	self
		assert: aCopy page == aPage
		description: [ 'The copy must keep the page of the original context' ].

	^ aCopy
]

{ #category : #examples }
LeHtmlContextExamples >> copyWithNewStreamWritesToNewStream [
	<gtExample>
	<return: #LeHtmlContext>
	| anOriginalStream aCopyStream aContext aCopy |
	anOriginalStream := WriteStream on: String new.
	aCopyStream := WriteStream on: String new.
	aContext := LeHtmlContext new.
	aContext newStream: anOriginalStream.
	"The HTML stream is cached when it is requested for the first time.
	A copy must not reuse it."
	aContext html nextPutAll: 'original'.

	aCopy := aContext copyWithNewStream: aCopyStream.
	aCopy html nextPutAll: 'copy'.
	aContext html nextPutAll: ' again'.

	self
		assert: aCopy ~~ aContext
		description: [ 'A copy must be a different object' ].
	self
		assert: anOriginalStream contents = 'original again'
		description: [ 'The original context must keep writing to its own stream, but it wrote {1}'
				format: {anOriginalStream contents} ].
	self
		assert: aCopyStream contents = 'copy'
		description: [ 'The copy must write to the new stream, but it wrote {1}'
				format: {aCopyStream contents} ].

	^ aCopy
]

{ #category : #examples }
LeHtmlContextExamples >> explicitSiteNameWinsOverDatabaseName [
	<gtExample>
	<return: #LeHtmlContext>
	| someExamples aContext |
	someExamples := LeContentExamples new.
	aContext := LeHtmlContext new.
	[ | aDatabase |
		aDatabase := someExamples basicDatabaseWithMonitor.
		aDatabase databaseName: 'My book'.
		aContext database: aDatabase.
		aContext siteName: 'My Site'.

		self
			assert: aContext siteName = 'My Site'
			description: [ 'The explicit site name must be used, but it is {1}' format: {aContext siteName} ] ]
		ensure: [ someExamples stopDatabaseMonitor ].

	^ aContext
]

{ #category : #examples }
LeHtmlContextExamples >> siteNameAttributePieceEscapesSiteName [
	<gtExample>
	<return: #LeHtmlSiteNameAttributePiece>
	| aStream aContext aPiece |
	aStream := WriteStream on: String new.
	aContext := LeHtmlContext new.
	aContext newStream: aStream.
	aContext siteName: 'Tom & "Jerry"'.
	aPiece := LeHtmlSiteNameAttributePiece new.

	aPiece writeWithContext: aContext.

	self
		assert: aStream contents = 'Tom &amp; &quot;Jerry&quot;'
		description: [ 'The site name must be escaped as an attribute value, but it is {1}'
				format: {aStream contents} ].

	^ aPiece
]

{ #category : #examples }
LeHtmlContextExamples >> siteNameAttributePieceWritesNothingWithoutSiteName [
	<gtExample>
	<return: #LeHtmlSiteNameAttributePiece>
	| aStream aContext aPiece |
	aStream := WriteStream on: String new.
	aContext := LeHtmlContext new.
	aContext newStream: aStream.
	aPiece := LeHtmlSiteNameAttributePiece new.

	aPiece writeWithContext: aContext.

	self
		assert: aStream contents isEmpty
		description: [ 'Nothing must be written without a site name, but it is {1}' format: {aStream contents} ].

	^ aPiece
]

{ #category : #examples }
LeHtmlContextExamples >> siteNameDefaultsToDatabaseName [
	<gtExample>
	<return: #LeHtmlContext>
	| someExamples aContext |
	someExamples := LeContentExamples new.
	aContext := LeHtmlContext new.
	[ | aDatabase |
		aDatabase := someExamples basicDatabaseWithMonitor.
		aDatabase databaseName: 'My book'.
		aContext database: aDatabase.

		self
			assert: aContext siteName = 'My book'
			description: [ 'The site name is the database name, but it is {1}' format: {aContext siteName} ] ]
		ensure: [ someExamples stopDatabaseMonitor ].

	^ aContext
]

{ #category : #examples }
LeHtmlContextExamples >> siteNameIgnoresDatabaseWithoutName [
	<gtExample>
	<return: #LeHtmlContext>
	| aContext |
	"A page that is not in a database has a null database that has an empty name."
	aContext := LeHtmlContext new.
	aContext database: LePage new database.

	self
		assert: aContext siteName isNil
		description: [ 'An empty database name is not a site name, but it is {1}' format: {aContext siteName printString} ].

	^ aContext
]

{ #category : #examples }
LeHtmlContextExamples >> siteNameIsNilWithoutDatabase [
	<gtExample>
	<return: #LeHtmlContext>
	| aContext |
	aContext := LeHtmlContext new.

	self
		assert: aContext siteName isNil
		description: [ 'The site name is not defined without a database' ].

	^ aContext
]

{ #category : #examples }
LeHtmlContextExamples >> unknownPlaceholderWritesNothing [
	<gtExample>
	<return: #LeHtmlGtBookPiece>
	| aStream aContext aPiece |
	"An older exporter does not know a newer placeholder, e.g., siteNameAttribute, and the page is exported without it."
	aStream := WriteStream on: String new.
	aContext := LeHtmlContext new.
	aContext newStream: aStream.
	aPiece := LeHtmlGtBookPiece new template: 'a{{unknownPlaceholder}}b'; yourself.

	aPiece writeWithContext: aContext.

	self
		assert: aStream contents = 'ab'
		description: [ 'An unknown placeholder must write nothing, but the output is {1}' format: {aStream contents} ].

	^ aPiece
]

{ #category : #examples }
LeHtmlContextExamples >> urlAttributePieceEscapesAmpersand [
	<gtExample>
	<return: #LeHtmlPageUrlAttributePiece>
	| aPage aStream aContext aPiece |
	aPage := LePage new.
	aPage title: 'Page'.
	aStream := WriteStream on: String new.
	aContext := LeHtmlContext new.
	aContext page: aPage.
	aContext newStream: aStream.
	aPiece := LeHtmlPageUrlAttributePiece new.
	aPiece baseUrl: 'https://example.org/book?x=1&y=2' asZnUrl.

	aPiece writeWithContext: aContext.

	self
		assert: aStream contents = 'https://example.org/book/index.html?x=1&amp;y=2'
		description: [ 'URL attribute must have an escaped ampersand, but it is {1}'
				format: {aStream contents} ].

	^ aPiece
]

{ #category : #examples }
LeHtmlContextExamples >> urlAttributePieceKeepsDefaultBaseUrl [
	<gtExample>
	<return: #LeHtmlPageUrlAttributePiece>
	| aStream aContext aPiece |
	aStream := WriteStream on: String new.
	aContext := LeHtmlContext new.
	aContext page: (LePage named: 'Page').
	aContext newStream: aStream.
	aPiece := LeHtmlPageUrlAttributePiece new.

	aPiece writeWithContext: aContext.

	self
		assert: aStream contents = 'https://book.gtoolkit.com/index.html'
		description: [ 'The default base URL must be used, but the URL is {1}' format: {aStream contents} ].

	^ aPiece
]

{ #category : #examples }
LeHtmlContextExamples >> urlAttributePieceUsesBaseUrlOfContext [
	<gtExample>
	<return: #LeHtmlPageUrlAttributePiece>
	| aStream aContext aPiece |
	aStream := WriteStream on: String new.
	aContext := LeHtmlContext new.
	aContext page: (LePage named: 'Page').
	aContext newStream: aStream.
	aContext baseUrl: 'https://book.example.org'.
	aPiece := LeHtmlPageUrlAttributePiece new.

	aPiece writeWithContext: aContext.

	self
		assert: aStream contents = 'https://book.example.org/index.html'
		description: [ 'The base URL of the context must be used, but the URL is {1}' format: {aStream contents} ].

	^ aPiece
]
