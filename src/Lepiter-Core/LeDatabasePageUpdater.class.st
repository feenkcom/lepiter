"
I update {{gtClass:LePage}}. 
I proceed only permited updates that do not break a whole {{gtClass:LeDatabase}} model.
I execute {{gtMethod:LeDatabasePageUpdater>>#callback:|label=callbacks}} when a change is applied.
## Example 
For a database with two pages: {{gtExample:LeDatabasePageUpdaterExamples>>#databaseWithTwoPages|noCode}}
A page `one` can be renamed to `three`: {{gtExample:LeDatabasePageUpdaterExamples>>#updatePageOneToThree|previewExpanded}}
But it cannot be renamed to `two`: {{gtExample:LeDatabasePageUpdaterExamples>>#updatePageOneToTwo|previewExpanded}}


"
Class {
	#name : #LeDatabasePageUpdater,
	#superclass : #LePageBuilder,
	#traits : 'TLeContentUpdater',
	#classTraits : 'TLeContentUpdater classTrait',
	#instVars : [
		'database',
		'callbacks',
		'isUpdated'
	],
	#category : 'Lepiter-Core-Builders'
}

{ #category : #'private - updating' }
LeDatabasePageUpdater >> beUpdated [
	isUpdated := true
]

{ #category : #'api - configuration' }
LeDatabasePageUpdater >> callback: aCallback [
	"Set a callback that understands #cull: message.
	The callback is executed at the end of changes if any changed is applied.
	The callback receives the updated page."
	callbacks := callbacks copyWith: aCallback
]

{ #category : #'api - accessing' }
LeDatabasePageUpdater >> database [
	<return: #LeDatabase>
	^ database
]

{ #category : #'api - accessing' }
LeDatabasePageUpdater >> database: aDatabase [
	self 
		assert: [ aDatabase isDatabase ] 
		description: [ 'Database must exist' ].
	database := aDatabase.
]

{ #category : #defaults }
LeDatabasePageUpdater >> defaultCallbacks [
	^ #()
]

{ #category : #defaults }
LeDatabasePageUpdater >> defaultContent [
	^ LePage null
]

{ #category : #defaults }
LeDatabasePageUpdater >> defaultDatabase [
	^ LeDatabase null
]

{ #category : #'private - updating' }
LeDatabasePageUpdater >> executeCallbacks [
	self isUpdated ifFalse: [ ^ self ].
	callbacks do: [ :eachCallback | eachCallback cull: self page ].
]

{ #category : #'private - testing' }
LeDatabasePageUpdater >> hasContent [
	^ self page hasTitle
]

{ #category : #initialization }
LeDatabasePageUpdater >> initialize [
	super initialize.
	isUpdated := false.
	callbacks := self defaultCallbacks.
	database := self defaultDatabase.
]

{ #category : #'private - testing' }
LeDatabasePageUpdater >> isTitleAllowed: aString [
	^ self database 
		pageNamed: aString
		ifPresent: [ false ]
		ifAbsent: [ true ]
]

{ #category : #'private - testing' }
LeDatabasePageUpdater >> isUpdated [
	^ isUpdated
]

{ #category : #'api - accessing' }
LeDatabasePageUpdater >> page: aPage [
	content := aPage
]

{ #category : #'api - configuration' }
LeDatabasePageUpdater >> title: aTitle [
	| aString |
	aString := aTitle asString.
	(self isTitleAllowed: aString) ifFalse: [ ^ self ].
	self beUpdated.
	self updateTimeAndEmail.
	super title: aString.
]

{ #category : #'api - updating' }
LeDatabasePageUpdater >> update [
	"Currently we update immediately for individual method calls"
	<return: #LePage>
	self executeCallbacks.
	self updateLinks.
	^ self page
]

{ #category : #'private - updating' }
LeDatabasePageUpdater >> updateLinks [
	| links |
	links := (self page incomingLinks 
		select: [ :each | each isTextualLink ]) 
		groupedBy: [ :each | each origin ].
	links do: [ :blockLinks | 
		(blockLinks
			asSortedCollection: [ :a :b | a node startPosition > b node startPosition ])
			do: [ :eachLink | eachLink renameTargetTo: self page title ] ].
]
