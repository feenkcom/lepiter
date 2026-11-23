Class {
	#name : #LeLocalV3003MigrationExamples,
	#superclass : #LeLocalExamples,
	#category : #'Lepiter-Store-Local-Examples'
}

{ #category : #examples }
LeLocalV3003MigrationExamples >> migrateFromV3 [
	"A 3.3 database: the v4.0 test data with the schema 3.3. Loading it reruns the 3.3 update (LeLocalJsonV4Storage>>#updateDbStore:),
	and LeJsonV3003Updater>>#fileReferenceFor:named: keeps the name of the *.lepiter.links file."

	<gtExample>
	<return: #LeDatabase>
	memStore := FileSystem memory root / 'db'.
	memStore ensureCreateDirectory.
	(self testDataLocation / 'v4.0') files do: [ :aFile |
		(memStore / aFile basename) writeStreamDo: [ :aStream |
			aStream nextPutAll: (aFile contents copyReplaceAll: '"4.0"' with: '"3.3"') ] ].

	database := LeLocalStoreLoad current loadFrom: memStore.

	self assert: database size equals: 5.
	self assert: database explicitLinks size equals: 3.
	self
		assert: (memStore files collect: #extension as: Set)
		equals: #('3bak' '0bak' 'properties' 'lepiter' 'links') asSet.

	^ database
]
