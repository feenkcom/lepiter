"
Examples and tests for local storage.

The migration examples rely on having test data from each of the previous storage versions at {{gtMethod:name=LeLocalExamples>>#testDataLocation}}.

Prior to introducing a new schema version and snapshot of the current version should be created with: 

``` 
db := LeLocalStoreLoad forJsonV3 loadFrom: LeLocalExamples testDataLocation / 'v3'.
LeLocalStoreExport forJsonV3 export: db to: LeLocalExamples testDataLocation / 'v3.1'.
db.
```

replacing the version numbers as appropriate.



## Internal Representation and Key Implementation Points.

### Instance Variables
	database:		<LeDatabase>
	memStore:		<FileReference>


### Implementation Points

"
Class {
	#name : #LeLocalExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#instVars : [
		'database',
		'memStore'
	],
	#category : 'Lepiter-Store-Local-Examples'
}

{ #category : #accessing }
LeLocalExamples class >> testDataLocation [
	"Answer the location of the test data based on the git repository"
	| fileReference |
	
	fileReference := (GtResourceReference path: Path 
		* 'feenkcom' 
		/ 'lepiter' 
		/ 'test-data') fileReference.
	self assert: fileReference exists.
	^ fileReference.
]

{ #category : #accessing }
LeLocalExamples >> testDataLocation [

	^ self class testDataLocation
]
