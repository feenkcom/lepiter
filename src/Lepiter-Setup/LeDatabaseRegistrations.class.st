Class {
	#name : #LeDatabaseRegistrations,
	#superclass : #Object,
	#category : #'Lepiter-Setup-Core'
}

{ #category : #'accessing - path' }
LeDatabaseRegistrations class >> allDocumentationPaths [
	^ Array streamContents: [ :aStream | 
		self allDocumentationPathsDo: [ :aPath | 
			aStream nextPut: aPath ] ]
]

{ #category : #'accessing - path' }
LeDatabaseRegistrations class >> allDocumentationPathsDo: aBlock [
	| allPragmas |
	allPragmas := self allDocumentationPragmas.

	allPragmas
		do: [ :eachPragma | 
			| aPath |
			aPath := eachPragma method valueWithReceiver: self arguments: {}.
			aPath ifNotNil: [ aBlock cull: aPath cull: eachPragma ] ]
]

{ #category : #'accessing - pragma' }
LeDatabaseRegistrations class >> allDocumentationPragmas [
	^ Pragma
		allNamed: self pragmaSelector
		from: self class
		to: LeDatabaseRegistrations
		sortedByArgument: 1
]

{ #category : #'accessing - path' }
LeDatabaseRegistrations class >> allReverseDocumentationPathsDo: aBlock [
	| allPragmas |
	allPragmas := self allDocumentationPragmas.

	allPragmas
		reverseDo: [ :eachPragma | 
			| aPath |
			aPath := eachPragma method valueWithReceiver: self arguments: {}.
			aPath ifNotNil: [ aBlock cull: aPath cull: eachPragma ] ]
]

{ #category : #'gt - extensions' }
LeDatabaseRegistrations class >> gtAllDocumentationPathsFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedList
		title: 'Lepiter documentation paths';
		priority: 1;
		items: [ Array
				streamContents: [ :aStream | 
					self
						allDocumentationPathsDo: [ :aPath :aPragma | 
							aStream
								nextPut: (LeDatabaseRegistration new
										path: aPath;
										pragma: aPragma) ] ] ];
		column: 'Index'
			text: [ :anItem :anIndex | anIndex ]
			width: 35;
		column: 'Path' text: [ :anItem | anItem directory pathString ];
		column: 'Package' text: [ :anItem | anItem pragma method package ];
		column: 'Exists'
			text: [ :anItem | 
				anItem directory exists
					ifTrue: [ 'yes' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ]
					ifFalse: [ 'no' ] ]
			width: 40;
		actionUpdateButton
]

{ #category : #'building image utilities' }
LeDatabaseRegistrations class >> loadLepiterKnowledgeBases [
	"I am used when an application is build manually"

	self registerLepiterKnowledgeBases.
	LeDatabasesRegistry default defaultLogicalDatabase reload
]

{ #category : #'database initialization' }
LeDatabaseRegistrations class >> logicalDatabaseProperties [
	| databaseProperties propertiesFile |
	propertiesFile := LepiterCoreDefaults
			defaultLocalLogicalDatabasePropertiesFileReference.
	databaseProperties := LeLogicalDatabaseProperties
			forPropertiesFile: propertiesFile
			ifAbsentUse: [ self newLogicalDatabaseProperties ].
	^ databaseProperties
]

{ #category : #'database initialization' }
LeDatabaseRegistrations class >> newLogicalDatabaseProperties [
	| aDatabaseProperties |
	aDatabaseProperties := LeLogicalDatabaseProperties
			withDefaultPrimaryDatabaseAndGlamorousDocumentation.

	self
		allDocumentationPathsDo: [ :aPath | 
			| aFile |
			aFile := LepiterCoreDefaults defaultDocumentationDirectory / aPath pathString.
			aDatabaseProperties addRegisteredDirectory: aFile ].

	^ aDatabaseProperties
]

{ #category : #'accessing - pragma' }
LeDatabaseRegistrations class >> pragmaSelector [
	^ #lepiterPath:
]

{ #category : #'building image utilities' }
LeDatabaseRegistrations class >> registerLepiterKnowledgeBases [
	| aCurrentProperties |
	aCurrentProperties := LeDatabasesRegistry defaultLogicalDatabase properties.
	self registerLepiterKnowledgeBasesInto: aCurrentProperties
]

{ #category : #'building image utilities' }
LeDatabaseRegistrations class >> registerLepiterKnowledgeBasesInto: aLeDatabaseProperties [
	self
		allReverseDocumentationPathsDo: [ :aPath | 
			| aDir |
			aDir := FileLocator gtResource / aPath pathString.
			aLeDatabaseProperties addRegisteredDirectory: aDir ]
]

{ #category : #'database initialization' }
LeDatabaseRegistrations class >> setupDatabasesRegistry [
	<return: #LeLogicalDatabase>
	| databaseProperties |
	databaseProperties := self logicalDatabaseProperties.
	^ LeDatabasesRegistry uniqueInstance
		setupWithLogicalDatabaseProperties: databaseProperties
]

{ #category : #'database initialization' }
LeDatabaseRegistrations class >> setupDatabasesRegistryWithMonitor: isRunningMonitor [
	<return: #LeLogicalDatabase>
	| aDatabaseProperties aDatabase |
	aDatabaseProperties := self logicalDatabaseProperties.
	aDatabase := LeDatabasesRegistry uniqueInstance
			setupWithLogicalDatabaseProperties: aDatabaseProperties.
	isRunningMonitor ifFalse: [ aDatabase stopMonitoring ].
	^ aDatabase
]
