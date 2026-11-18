"
I present the memory used by the state of the image: all objects that are not code entities, attributed to who holds them.

Code entities (classes, methods, symbols) are measured by {{gtClass:GtMemoryMetrics}}; the walk stops at them. The rest is estimated with a {{gtClass:GtMemorySpaceRootsDefinition}} made of ordered groups of roots (see #newDefinitionFocusedOn:): the GT Book, the code index, the other Lepiter databases, the class-side state of all classes (by package), and the globals, which include the processes and their stacks through Processor. Objects reachable from several groups are counted in the first one. What is reached from none of them is reported as not reached.

To see what a tool or a server holds, add a focus group with #focusOn: (or use #focusedOn:): it is estimated first, and stops at the shared hubs of the image (see #sharedHubClasses), so that it gets its own objects. To see what the instances of some classes keep alive, use #retentionOf:, which estimates the image again while stopping at them ({{gtClass:GtMemorySpaceRetention}}).

To explain the size of the image on disk, compute me in a freshly started image, or in the build just before saving. In a long-running image I describe the current heap, which also holds the objects of the UI and of the user.

For performance reasons the default instance is cached; use #reset to compute again.
"
Class {
	#name : #GtImageStateMemoryMetrics,
	#superclass : #Object,
	#instVars : [
		'definition',
		'estimation',
		'codeEntitiesSize',
		'imageSizeInMemory',
		'imageFileSize',
		'focusGroups'
	],
	#classInstVars : [
		'default'
	],
	#category : #'Lepiter-MemoryMetrics'
}

{ #category : #definition }
GtImageStateMemoryMetrics class >> codeIndexRoots [
	"The code index, without creating it"

	^ (GtPharoIndex instVarNamed: #current)
		ifNil: [ #() ]
		ifNotNil: [ :anIndex | {GtMemorySpaceRoot label: 'GtPharoIndex current' object: anIndex} ]
]

{ #category : #accessing }
GtImageStateMemoryMetrics class >> default [
	<gtExample>
	<noTest>
	^ default
		ifNil: [ default := self new
					compute;
					yourself ]
]

{ #category : #'instance creation' }
GtImageStateMemoryMetrics class >> focusedOn: aRootGroup [
	"Compute the state of the image, with aRootGroup estimated first"

	^ self new
		focusOn: aRootGroup;
		compute;
		yourself
]

{ #category : #definition }
GtImageStateMemoryMetrics class >> gtBookRoots [
	^ (self loadedLepiterDatabases
		select: [ :each | each databaseName = LeDatabase gtBookName ])
		flatCollect: [ :each | self lepiterRootsOf: each ]
]

{ #category : #definition }
GtImageStateMemoryMetrics class >> lepiterAttributionIn: aDefinition named: aCategoryName [
	"Count a database, page or snippet even though the walk stops at them, and what they hold,
	without following their parent and their database"

	^ GtMemorySpaceSlotsAttribution new
		objectCategory: (aDefinition categoryNamed: aCategoryName);
		ignoreSlots: #(parent database);
		yourself
]

{ #category : #definition }
GtImageStateMemoryMetrics class >> lepiterRootsOf: aDatabase [
	"The database, its pages and their snippets"

	^ Array
		streamContents: [ :aStream | 
			aStream
				nextPut: (GtMemorySpaceRoot
						label: (aDatabase databaseName ifNil: [ 'Unnamed database' ])
						object: aDatabase).
			aDatabase
				pagesDo: [ :aPage | 
					aStream
						nextPut: (GtMemorySpaceRoot label: 'page ' , aPage title asString object: aPage).
					aPage
						allChildrenDepthFirstDo: [ :aSnippet | 
							aStream
								nextPut: (GtMemorySpaceRoot
										label: aSnippet class name , ' in ' , aPage title asString
										object: aSnippet) ] ] ]
]

{ #category : #definition }
GtImageStateMemoryMetrics class >> loadedLepiterDatabases [
	"The databases of the default logical database, without loading it"

	| aRegistry |
	aRegistry := LeDatabasesRegistry instVarNamed: #uniqueInstance.
	aRegistry ifNil: [ ^ #() ].
	^ aRegistry currentLoadedDefaultLogicalDatabase
		ifNil: [ #() ]
		ifNotNil: [ :aLogicalDatabase | aLogicalDatabase databases ]
]

{ #category : #definition }
GtImageStateMemoryMetrics class >> newDefinition [
	^ self newDefinitionFocusedOn: #()
]

{ #category : #definition }
GtImageStateMemoryMetrics class >> newDefinitionFocusedOn: aCollectionOfRootGroups [
	"Ordered groups of roots: the focus groups first, then specific holders, 
	then the class-side state of all classes and the globals.
	The walk stops at code entities, measured by GtMemoryMetrics, and at Lepiter databases, pages and snippets:
	they are the roots of the Lepiter groups, so that each database gets its own content and not the content 
	of other databases that it refers to. Focus groups also stop at the shared hubs of the image."

	| aDefinition |
	aDefinition := GtMemorySpaceRootsDefinition new.
	aDefinition
		boundary: (GtMemorySpaceBoundary new
				stopAtCodeEntities;
				stopAtInstancesOf: {LeLogicalDatabase.
						LeDatabase.
						LeContent};
				yourself).
	aCollectionOfRootGroups
		do: [ :aGroup | 
			aGroup
				stopAtInstancesOf: (self sharedHubClasses
						reject: [ :each | aGroup extraStopClasses includes: each ]).
			aDefinition rootGroup: aGroup ].
	(aDefinition roots: 'Lepiter GT Book' are: [ self gtBookRoots ])
		attribution: (self lepiterAttributionIn: aDefinition named: 'Lepiter GT Book').
	aDefinition roots: 'Code index' are: [ self codeIndexRoots ].
	(aDefinition
		roots: 'Other Lepiter databases'
		are: [ self otherLepiterDatabaseRoots ])
		attribution: (self lepiterAttributionIn: aDefinition named: 'Other Lepiter databases').
	aDefinition
		rootGroup: GtMemorySpaceRootGroup classSideState;
		rootGroup: GtMemorySpaceRootGroup globals;
		tag: #string
			instancesOf: {ByteString.
					WideString};
		tag: #bitmap instancesOf: {Bitmap};
		tag: #byteArray instancesOf: {ByteArray};
		tag: #context instancesOf: {Context};
		tag: #block
			classesMatching: [ :aClass | aClass includesBehavior: BlockClosure ];
		expectedObjects: 3000000.
	^ aDefinition
]

{ #category : #definition }
GtImageStateMemoryMetrics class >> otherLepiterDatabaseRoots [
	^ (self loadedLepiterDatabases
		reject: [ :each | each databaseName = LeDatabase gtBookName ])
		flatCollect: [ :each | self lepiterRootsOf: each ]
]

{ #category : #accessing }
GtImageStateMemoryMetrics class >> reset [
	default := nil
]

{ #category : #definition }
GtImageStateMemoryMetrics class >> sharedHubClasses [
	"Objects that connect most parts of a running image. 
	Focus groups stop at them, so that they get their own objects and not the whole image."

	^ {Process.
		BlElement.
		BlSpace.
		AsyncFutureThreadPool}
]

{ #category : #metrics }
GtImageStateMemoryMetrics >> codeEntitiesSize [
	"Classes, methods and symbols, as measured by GtMemoryMetrics"

	^ codeEntitiesSize ifNil: [ 0 ]
]

{ #category : #accessing }
GtImageStateMemoryMetrics >> codeEntitiesSize: aNumberOfBytes [
	"Use a known size of the code entities, instead of computing it with GtMemoryMetrics"

	codeEntitiesSize := aNumberOfBytes
]

{ #category : #metrics }
GtImageStateMemoryMetrics >> computationTime [
	^ estimation ifNotNil: [ estimation computationTime ]
]

{ #category : #computing }
GtImageStateMemoryMetrics >> compute [
	| aCodeMetrics |
	aCodeMetrics := GtMemoryMetrics new.
	codeEntitiesSize
		ifNil: [ codeEntitiesSize := aCodeMetrics totalClassesSize
					+ aCodeMetrics totalMethodsSize + aCodeMetrics totalSymbolsSize ].
	imageFileSize := Smalltalk image imageFile size.
	imageSizeInMemory := aCodeMetrics totalImageSizeInMemory.
	estimation := self definition estimate
]

{ #category : #accessing }
GtImageStateMemoryMetrics >> definition [
	^ definition
		ifNil: [ definition := self class newDefinitionFocusedOn: self focusGroups ]
]

{ #category : #accessing }
GtImageStateMemoryMetrics >> definition: aRootsDefinition [
	"Use another definition, for example a smaller one in examples"

	definition := aRootsDefinition
]

{ #category : #accessing }
GtImageStateMemoryMetrics >> estimate [
	^ estimation ifNotNil: [ estimation estimate ]
]

{ #category : #accessing }
GtImageStateMemoryMetrics >> estimation [
	^ estimation
]

{ #category : #accessing }
GtImageStateMemoryMetrics >> focusGroups [
	^ focusGroups ifNil: [ #() ]
]

{ #category : #accessing }
GtImageStateMemoryMetrics >> focusOn: aRootGroup [
	"Estimate aRootGroup before all other groups, stopping at the shared hubs of the image, 
	to see the memory that it holds, for example the state of a tool or a server"

	focusGroups := self focusGroups , {aRootGroup}.
	definition := nil
]

{ #category : #'gt - extensions' }
GtImageStateMemoryMetrics >> gtViewCategoriesFor: aView [
	<gtView>
	estimation ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Categories';
		priority: 20;
		object: [ self estimate ];
		view: #gtViewCategoriesFor:
]

{ #category : #'gt - extensions' }
GtImageStateMemoryMetrics >> gtViewDefinitionFor: aView [
	<gtView>
	^ aView forward
		title: 'Definition';
		priority: 50;
		object: [ self definition ];
		view: #gtViewRootGroupsFor:
]

{ #category : #'gt - extensions' }
GtImageStateMemoryMetrics >> gtViewRootGroupsFor: aView [
	<gtView>
	estimation ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Root groups';
		priority: 10;
		object: [ self estimate ];
		view: #gtViewRootGroupsFor:
]

{ #category : #'gt - extensions' }
GtImageStateMemoryMetrics >> gtViewRootsFor: aView [
	<gtView>
	estimation ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Roots';
		priority: 30;
		object: [ self estimate ];
		view: #gtViewRootsFor:
]

{ #category : #'gt - extensions' }
GtImageStateMemoryMetrics >> gtViewSummaryFor: aView [
	<gtView>
	estimation ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Summary';
		priority: 5;
		items: [ self summaryItems ];
		column: 'Property'
			text: [ :each | each first ]
			width: 300;
		column: 'Value' text: [ :each | each second ];
		send: [ :each | each third ]
]

{ #category : #'gt - extensions' }
GtImageStateMemoryMetrics >> gtViewTagsFor: aView [
	<gtView>
	estimation ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Tags';
		priority: 40;
		object: [ self estimate ];
		view: #gtViewTagsFor:
]

{ #category : #metrics }
GtImageStateMemoryMetrics >> imageFileSize [
	^ imageFileSize ifNil: [ 0 ]
]

{ #category : #metrics }
GtImageStateMemoryMetrics >> imageSizeInMemory [
	"All objects, after a full garbage collection"

	^ imageSizeInMemory ifNil: [ 0 ]
]

{ #category : #metrics }
GtImageStateMemoryMetrics >> notReachedSize [
	"Objects reached neither from the roots nor counted as code entities, 
	for example objects referenced only by the literals of methods, or by the virtual machine"

	^ self imageSizeInMemory - self codeEntitiesSize - self stateSize
]

{ #category : #printing }
GtImageStateMemoryMetrics >> printOn: aStream [
	super printOn: aStream.
	estimation ifNil: [ ^ self ].
	aStream
		nextPut: $(;
		nextPutAll: self stateSize humanReadableIsqByteSize;
		nextPutAll: ' of state in ';
		nextPutAll: self imageSizeInMemory humanReadableIsqByteSize;
		nextPut: $)
]

{ #category : #computing }
GtImageStateMemoryMetrics >> retentionOf: aCollectionOfClasses [
	"The memory kept alive only by the instances of these classes, 
	by estimating the image again while stopping at them"

	estimation ifNil: [ self compute ].
	^ GtMemorySpaceRetention
		estimation: estimation
		stoppingAtInstancesOf: aCollectionOfClasses
]

{ #category : #metrics }
GtImageStateMemoryMetrics >> stateSize [
	"The objects reached from the roots, which are not code entities"

	^ estimation ifNil: [ 0 ] ifNotNil: [ estimation totalBytes ]
]

{ #category : #accessing }
GtImageStateMemoryMetrics >> summaryItems [
	"Rows of the summary: a label, a value to display, and the object to inspect"

	| aTotal percentage |
	aTotal := self imageSizeInMemory max: 1.
	percentage := [ :aSize | ' (' , (aSize * 100 / aTotal) rounded asString , '%)' ].
	^ {{'Image file'.
			self imageFileSize humanReadableIsqByteSize.
			self imageFileSize}.
		{'Image in memory, after a full garbage collection'.
			self imageSizeInMemory humanReadableIsqByteSize.
			self imageSizeInMemory}.
		{'Code entities (classes, methods, symbols)'.
			self codeEntitiesSize humanReadableIsqByteSize
				, (percentage value: self codeEntitiesSize).
			GtMemoryMetrics}.
		{'State reached from the roots'.
			self stateSize humanReadableIsqByteSize , (percentage value: self stateSize).
			self estimate}.
		{'Not reached'.
			self notReachedSize humanReadableIsqByteSize
				, (percentage value: self notReachedSize).
			self notReachedSize}.
		{'Computation time'.
			self computationTime printString.
			self computationTime}}
]
