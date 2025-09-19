Class {
	#name : #LeLocalV3001MigrationExamples,
	#superclass : #LeLocalExamples,
	#category : #'Lepiter-Store-Local-Examples'
}

{ #category : #examples }
LeLocalV3001MigrationExamples >> migrateFromV3 [
	<gtExample>
	<return: #LeDatabase>
	| page1 page2 page4 dailyNote snippet link links properties |
	"V3 updates schema in-place, so copy the on-disk db to memory"
	memStore := FileSystem memory root / 'db'.
	self testDataLocation / 'v3.1' copyAllTo: memStore.

	database := LeLocalStoreLoad current loadFrom: memStore.

	properties := STONJSON fromString: (memStore / 'lepiter.properties') contents.
	self
		assert: (properties at: #schema)
		equals: LeLocalJsonV4Storage currentVersionString.

	self assert: database size equals: 5.
	self assert: database linksCount equals: 1.
	page1 := database pageNamed: 'Page 1'.
	page2 := database pageNamed: 'Page 2'.
	links := database scanForLinksTo: page1.
	self assert: links size equals: 1.
	link := links first.
	self assert: link origin equals: page2 children items second.
	self assert: link target equals: page1.
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
