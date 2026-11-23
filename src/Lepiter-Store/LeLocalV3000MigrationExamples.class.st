Class {
	#name : #LeLocalV3000MigrationExamples,
	#superclass : #LeLocalExamples,
	#category : #'Lepiter-Store-Local-Examples'
}

{ #category : #examples }
LeLocalV3000MigrationExamples >> migrateFromV3 [
	"A 3.0 database, built from the v3.1 test data: a named page has the page type defaultType and its title at the top level; a daily note also has a title at the top level.
	LeJsonV3000Updater>>#update: converts the pages, read with String keys and values."

	<gtExample>
	<return: #LeDatabase>
	| page1 page4 dailyNote snippet |
	memStore := FileSystem memory root / 'db'.
	memStore ensureCreateDirectory.
	(memStore / 'db.properties') writeStreamDo: [ :aStream | aStream nextPutAll: '{ "schema" : "3.0" }' ].
	(self testDataLocation / 'v3.1') files do: [ :aFile |
		aFile extension = 'json' ifTrue: [ | json pageType |
			json := STONJSON fromString: aFile contents.
			json at: '__schema' put: '3.0'.
			pageType := json at: 'pageType'.
			(pageType at: '__type') = 'namedPage'
				ifTrue: [
					json at: 'title' put: (pageType at: 'title').
					json at: 'pageType' put: { '__type' -> 'defaultType' } asDictionary ]
				ifFalse: [ json at: 'title' put: 'October 22nd, 2020' ].
			(memStore / aFile basename) writeStreamDo: [ :aStream | STONJSON put: json onStream: aStream ] ] ].

	database := LeLocalStoreLoad current loadFrom: memStore.

	self assert: database size equals: 5.
	self assert: database linksCount equals: 1.
	page1 := database pageNamed: 'Page 1'.
	self assert: page1 incomingLinks size equals: 1.

	page4 := database pageNamed: 'Page 4'.
	self assert: page4 childrenCount equals: 2.
	snippet := page4 children at: 2.
	self assert: snippet code equals: '42 inspect'.

	dailyNote := database pageNamed: 'October 22nd, 2020'.
	self assert: dailyNote childrenCount equals: 2.
	snippet := dailyNote children at: 2.
	self assert: snippet code equals: '4 + 3'.

	^ database
]
