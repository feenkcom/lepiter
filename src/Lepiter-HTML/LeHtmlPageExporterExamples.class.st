"
Demonstrate the operation of ${class:name=LeHtmlPageExporterVisitor}$.

Since there is no database present at this level, links to other pages, etc. can't be resolved.
"
Class {
	#name : #LeHtmlPageExporterExamples,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #private }
LeHtmlPageExporterExamples >> sampleCssFile [
	"Answer the sample css file included in the test data"

	^ self testDataLocation / 'html-export' / 'attachments/5btjm1n0n6rsaizw19rtczbv6/sample.css'
]

{ #category : #private }
LeHtmlPageExporterExamples >> sampleDatabase [
	"Answer the sample database to be used.
	The database is opened without a monitor, so no changes will be saved"

	^ LeLocalStoreLoad current loadFrom: self sampleDatabaseLocation
]

{ #category : #private }
LeHtmlPageExporterExamples >> sampleDatabaseLocation [
	"Answer the sample database for the examples"

	^ self testDataLocation / 'html-export'
]

{ #category : #examples }
LeHtmlPageExporterExamples >> samplePage [
	"Answer the html of a sample page"
	<gtExample>
	| database visitor html page |

	database := self sampleDatabase.
	page := database pageNamed: 'HTML Export Sample Page'.

	html := String streamContents: [ :stream |
		visitor := LeHtmlPageExporterVisitor new stream: stream.
		visitor addInternalStyle: self sampleCssFile contents.
		page acceptVisitor: visitor ].

	self assert: (html includesSubstring: '<i>italic</i>').
	self assert: (html includesSubstring: '<b>bold</b>').
	self assert: (html includesSubstring: '<code>code</code>').

	^ html
]

{ #category : #tests }
LeHtmlPageExporterExamples >> testDataLocation [
	"Answer the location of the test data based on the git repository"
	| fileReference |

	fileReference := (GtResourceReference path: Path 
		* 'feenkcom' 
		/ 'lepiter' 
		/ 'test-data') fileReference.
	self assert: fileReference exists.
	^ fileReference.
]
