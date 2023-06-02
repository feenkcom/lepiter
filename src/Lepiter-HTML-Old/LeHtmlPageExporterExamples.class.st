"
Demonstrate the operation of {{gtClass:name=LeHtmlPageExporterVisitor}}.

Since there is no database present at this level, links to other pages, etc. can't be resolved.

"
Class {
	#name : #LeHtmlPageExporterExamples,
	#superclass : #Object,
	#instVars : [
		'databases'
	],
	#category : #'Lepiter-HTML-Old-Examples'
}

{ #category : #after }
LeHtmlPageExporterExamples >> addDatabase: aDatabase [
	databases
		ifNil: [ databases := Array with: aDatabase.
			^ self ].

	databases := databases copyWith: aDatabase
]

{ #category : #after }
LeHtmlPageExporterExamples >> cleanUp [
	"We do not remove database root directories as we use predefined samples."

	databases
		ifNotNil: [ :aCollection | 
			databases := nil.
			aCollection do: [ :aDatabase | aDatabase stopMonitoring ] ]
]

{ #category : #private }
LeHtmlPageExporterExamples >> sampleCssFile [
	"Answer the sample css file included in the test data"

	<gtExample>
	| aFile |
	aFile := self testDataLocation / 'html-export'
			/ 'attachments/5btjm1n0n6rsaizw19rtczbv6/sample.css'.

	self assert: aFile exists.

	^ aFile
]

{ #category : #private }
LeHtmlPageExporterExamples >> sampleDatabase [
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
LeHtmlPageExporterExamples >> sampleDatabaseLocation [
	"Answer the sample database for the examples"

	<gtExample>
	| aDirectory |
	aDirectory := self testDataLocation / 'html-export'.

	self assert: aDirectory exists.
	^ aDirectory
]

{ #category : #examples }
LeHtmlPageExporterExamples >> samplePage [
	"Answer the html of a sample page"
	<gtExample>
	| database page |

	database := self sampleDatabase.
	page := database pageNamed: 'HTML Export Sample Page'.

	self assert: page isNotNil.

	^ page
]

{ #category : #examples }
LeHtmlPageExporterExamples >> samplePageExport [
	"Answer the html of a sample page"
	<gtExample>
	| visitor html page |

	page := self samplePage.

	html := String streamContents: [ :stream |
		visitor := LeHtmlPageExporterVisitor new stream: stream.
		visitor addInternalStyle: self sampleCssFile contents.
		page acceptVisitor: visitor ].

	self assert: (html includesSubstring: '<i>italic</i>').
	self assert: (html includesSubstring: '<b>bold</b>').
	self assert: (html includesSubstring: '<code>code</code>').

	^ html
]

{ #category : #examples }
LeHtmlPageExporterExamples >> sampleSnippetsPage [
	"Answer the html of a sample page"
	<gtExample>
	| database page |

	database := self sampleDatabase.
	page := database pageNamed: 'SnippetsToHTML'.
	
	self assert: page isNotNil.

	^ page
]

{ #category : #examples }
LeHtmlPageExporterExamples >> sampleSnippetsPageExport [
	"Answer the html of a sample page"
	<gtExample>
	| visitor html page aResources |

	page := self sampleSnippetsPage.

	html := String streamContents: [ :stream |
		visitor := LeHtmlPageExporterVisitor new stream: stream.
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
LeHtmlPageExporterExamples >> testDataLocation [
	"Answer the location of the test data based on the git repository"

	<gtExample>
	| fileReference |
	fileReference := FileLocator gtResource / 'feenkcom' / 'lepiter' / 'test-data'.
	self assert: fileReference exists.
	^ fileReference
]
