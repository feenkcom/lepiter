Class {
	#name : #LeExportSampleData,
	#superclass : #Object,
	#category : #'Lepiter-Export-Examples'
}

{ #category : #'examples - database' }
LeExportSampleData >> sampleDatabase [
	"Answer the sample database to be used.
	The database is opened without a monitor, so no changes will be saved"

	<gtExample>
	<return: #LeDatabase>
	| aDatabase |
	aDatabase := LeLocalStoreLoad current
			onlyLoadReadOnlyFrom: self sampleDatabaseLocation.

	self assert: aDatabase isNotNil.

	^ aDatabase
]

{ #category : #'examples - database' }
LeExportSampleData >> sampleDatabaseLocation [
	"Answer the sample database for the examples"

	<gtExample>
	<return: #FileLocator>
	| aDirectory |
	aDirectory := self testDataLocation / 'html-export'.

	self assert: aDirectory exists.
	^ aDirectory
]

{ #category : #'examples - database' }
LeExportSampleData >> samplePage [
	"Answer the html of a sample page"

	<gtExample>
	<return: #LePage>
	| database page |
	database := self sampleDatabase.
	page := database pageNamed: 'HTML Export Sample Page'.

	self assert: page isNotNil.

	^ page
]

{ #category : #'examples - database' }
LeExportSampleData >> sampleSnippetsPage [
	"Answer the html of a sample page"

	<gtExample>
	<return: #LePage>
	| database page |
	database := self sampleDatabase.
	page := database pageNamed: 'SnippetsToHTML'.

	self assert: page isNotNil.

	^ page
]

{ #category : #'examples - database' }
LeExportSampleData >> testDataLocation [
	"Answer the location of the test data based on the git repository"

	<gtExample>
	<return: #FileLocator>
	| fileReference |
	fileReference := FileLocator gtResource / 'feenkcom' / 'lepiter' / 'test-data'.
	self assert: fileReference exists.
	^ fileReference
]
