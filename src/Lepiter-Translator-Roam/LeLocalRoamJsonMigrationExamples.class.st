"
Check that the a database loads correcty from a Roam JSON file.

"
Class {
	#name : #LeLocalRoamJsonMigrationExamples,
	#superclass : #LeLocalExamples,
	#category : #'Lepiter-Translator-Roam-Example'
}

{ #category : #tests }
LeLocalRoamJsonMigrationExamples >> loadFromRoamJson [
	<gtExample>
	<return: #LeDatabase>
	| page1 page2 link links |
	"V3 updates schema in-place, so copy the on-disk db to memory"
	memStore := FileSystem memory root / 'db'.
	self testDataLocation / 'v1' copyAllTo: memStore.

	database := LeLocalStoreLoad forRoamJson loadFrom: memStore.

	self assert: database size equals: 3.
	self assert: database linksCount equals: 1.
	page1 := database pageNamed: 'Page 1'.
	page2 := database pageNamed: 'Page 2'.
	links := database scanForLinksTo: page1.
	self assert: links size equals: 1.
	link := links first.
	self assert: link origin equals: page2 children items second.
	self assert: link target equals: page1.

	^ database
]
