Class {
	#name : #LeHtmlBookPageExporterExamples,
	#superclass : #Object,
	#instVars : [
		'databases'
	],
	#category : #'Lepiter-HTML-Old-Examples'
}

{ #category : #after }
LeHtmlBookPageExporterExamples >> addDatabase: aDatabase [
	databases
		ifNil: [ databases := Array with: aDatabase.
			^ self ].

	databases := databases copyWith: aDatabase
]

{ #category : #after }
LeHtmlBookPageExporterExamples >> cleanUp [
	"We do not remove database root directories as we use predefined samples."

	databases
		ifNotNil: [ :aCollection | 
			databases := nil.
			aCollection do: [ :aDatabase | aDatabase stopMonitoring ] ]
]

{ #category : #private }
LeHtmlBookPageExporterExamples >> sampleCssFile [
	"Answer the sample css file included in the test data"

	<gtExample>
	| aFile |
	aFile := self testDataLocation / 'html-export'
			/ 'attachments/5btjm1n0n6rsaizw19rtczbv6/sample.css'.

	self assert: aFile exists.

	^ aFile
]

{ #category : #private }
LeHtmlBookPageExporterExamples >> sampleDatabase [
	"Answer the sample database to be used.
	The database is opened without a monitor, so no changes will be saved"

	<gtExample>
	<after: #cleanUp>
	| aDatabase |
	aDatabase := LeLocalStoreLoad current
			loadAndMonitorFrom: self sampleDatabaseLocation
			saveDelay: 0 seconds.

	self assert: aDatabase isNotNil.

	self addDatabase: aDatabase.

	^ aDatabase
]

{ #category : #private }
LeHtmlBookPageExporterExamples >> sampleDatabaseLocation [
	"Answer the sample database for the examples"

	<gtExample>
	| aDirectory |
	aDirectory := self testDataLocation / 'html-export'.

	self assert: aDirectory exists.
	^ aDirectory
]

{ #category : #examples }
LeHtmlBookPageExporterExamples >> samplePage [
	"Answer the html of a sample page"
	<gtExample>
	| database page |

	database := self sampleDatabase.
	page := database pageNamed: 'HTML Export Sample Page'.

	self assert: page isNotNil.

	^ page
]

{ #category : #examples }
LeHtmlBookPageExporterExamples >> samplePageExport [
	"Answer the html of a sample page"
	<gtExample>
	| visitor html page |

	page := self samplePage.

	html := String streamContents: [ :stream |
		visitor := LeHtmlBookPageExporterVisitor new stream: stream.
		visitor addInternalStyle: self sampleCssFile contents.
		page acceptVisitor: visitor ].

	self assert: (html includesSubstring: '<i>italic</i>').
	self assert: (html includesSubstring: '<b>bold</b>').
	self assert: (html includesSubstring: '<code>code</code>').

	^ html
]

{ #category : #examples }
LeHtmlBookPageExporterExamples >> sampleSnippetsPage [
	"Answer the html of a sample page"
	<gtExample>
	| database page |

	database := self sampleDatabase.
	page := database pageNamed: 'SnippetsToHTML'.
	
	self assert: page isNotNil.

	^ page
]

{ #category : #examples }
LeHtmlBookPageExporterExamples >> sampleSnippetsPageExport [
	"Answer the html of a sample page"
	<gtExample>
	| visitor html page aResources |

	page := self sampleSnippetsPage.

	html := String streamContents: [ :stream |
		visitor := LeHtmlBookPageExporterVisitor new stream: stream.
		visitor externalPicturesWriter: (aResources := LeResourcesExporter new).
		visitor addInternalStyle: self sampleCssFile contents.
		page acceptVisitor: visitor ].

	self assert: (html includesSubstring: '<i>italic text</i>').

	self assert: (html includesSubstring: '<pre class="no_bottom_margin">
1+41
            </pre>').

	^ html
]

{ #category : #tests }
LeHtmlBookPageExporterExamples >> testDataLocation [
	"Answer the location of the test data based on the git repository"

	<gtExample>
	| fileReference |
	fileReference := FileLocator gtResource / 'feenkcom' / 'lepiter' / 'test-data'.
	self assert: fileReference exists.
	^ fileReference
]
