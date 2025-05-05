"
I am used by other examples, providing a {{gtClass:LeDatabase}} with {{gtClass:LeLocalStoreMonitor}} that stores database content in a {{gtMethod:FileSystem class>>#memory|label=#selector}}.

"
Class {
	#name : #LeDatabaseWithLocalMonitorExamples,
	#superclass : #Object,
	#category : #'Lepiter-Store-Local-Examples'
}

{ #category : #'examples - database' }
LeDatabaseWithLocalMonitorExamples >> databaseWithMonitor [
	<gtExample>
	<return: #LeDatabase>
	^ self databaseWithMonitorForDirectory: self directory
]

{ #category : #'examples - utility' }
LeDatabaseWithLocalMonitorExamples >> databaseWithMonitorForDirectory: aDirectory [
	<gtExample>
	| aDatabase |
	self assert: aDirectory exists.

	aDatabase := LeLocalStoreLoad current loadAndMonitorFrom: aDirectory saveDelay: 0 seconds.
	
	self assert: aDatabase monitor isNotNil.
	self assert: aDatabase monitor localRoot equals: aDirectory.
	^ aDatabase
]

{ #category : #'examples - database' }
LeDatabaseWithLocalMonitorExamples >> directory [
	<gtExample>
	<return: #FileReference>
	| aDirectory |
	aDirectory := FileSystem memory workingDirectory / 'db'.
	aDirectory ensureCreateDirectory.
	self assert: aDirectory exists.
	^ aDirectory
]

{ #category : #'examples - utility' }
LeDatabaseWithLocalMonitorExamples >> directoryDatabase: aDatabase [
	<gtExample>
	| aDirectory |
	self assert: aDatabase isDatabase.
	self assert: aDatabase monitor isNotNil.

	aDirectory := aDatabase monitor localRoot.
	
	self assert: aDirectory exists.
	^ aDirectory
]
