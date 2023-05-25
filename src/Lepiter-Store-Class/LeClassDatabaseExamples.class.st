Class {
	#name : #LeClassDatabaseExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#instVars : [
		'database',
		'memStore'
	],
	#category : #'Lepiter-Store-Class-Examples'
}

{ #category : #accessing }
LeClassDatabaseExamples class >> testDataLocation [
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
LeClassDatabaseExamples >> testDataLocation [

	^ self class testDataLocation
]
