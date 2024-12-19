Class {
	#name : #LeHtmlBookExportCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #'Lepiter-HTML-Command Line'
}

{ #category : #accessing }
LeHtmlBookExportCommandLineHandler class >> commandName [
	^ 'exportbook'
]

{ #category : #accessing }
LeHtmlBookExportCommandLineHandler class >> description [
	^ 'export a provided book into HTML (Glamorous Toolkit book is exported by default)'
]

{ #category : #activation }
LeHtmlBookExportCommandLineHandler >> activate [
	| aBookExporter aBookName aBook aTargetDirName aTargetDir theWorkflowBuilder aMainPage aPageTemplateFileName aPiece anInputDirName aHrefBuilder |
	self activateHelp ifTrue: [ ^ self ].
	anInputDirName := self optionBookInputDirectoryName.
	anInputDirName ifNotNil: [ self ensureBookLoaded: anInputDirName ].
	aBookName := self optionBookName.
	aBook := self findBookNamed: aBookName.
	aMainPage := self findMainPageInBook: aBook named: aBookName.
	aTargetDirName := self optionTargetDirName.
	aTargetDir := self findTargetDirectoryNamed: aTargetDirName.
	aPageTemplateFileName := self optionPageTemplateFileName.
	aPiece := self findTemplatePieceForFileNamed: aPageTemplateFileName.
	aHrefBuilder := self optionHypertextReferenceBuilder.
	theWorkflowBuilder := [ NonInteractiveTranscript stdout
			show: 'Exporting "';
			show: aBookName;
			show: '" into ';
			print: aTargetDir fullName;
			show: ' directory: '.
		aBookExporter := LeHtmlBookExporter new
				database: aBook;
				mainPage: aMainPage;
				piece: aPiece;
				hrefBuilder: aHrefBuilder;
				integerSequencer;
				addGtBookAssets;
				export;
				saveToRootDirectory: aTargetDir.
		NonInteractiveTranscript stdout
			show: 'DONE.';
			cr ].
	(self hasOption: 'verbose')
		ifTrue: [ TranscriptLogger runDuring: theWorkflowBuilder ]
		ifFalse: theWorkflowBuilder.
	(self hasOption: 'save')
		ifTrue: [ ^ Smalltalk snapshot: true andQuit: (self hasOption: 'no-quit') not ].
	(self hasOption: 'no-quit') ifFalse: [ self quit ]
]

{ #category : #defaults }
LeHtmlBookExportCommandLineHandler >> defaultBookName [
	^ nil
]

{ #category : #defaults }
LeHtmlBookExportCommandLineHandler >> defaultHypertextReferenceBuilder [
	^ LeExportFilenameAndExtensionHypertextReferenceBuilder new
]

{ #category : #defaults }
LeHtmlBookExportCommandLineHandler >> defaultMainPageName [
	^ nil
]

{ #category : #defaults }
LeHtmlBookExportCommandLineHandler >> defaultPageTemplateFileName [
	^ nil
]

{ #category : #activation }
LeHtmlBookExportCommandLineHandler >> defaultTargetDirName [
	^ './'
]

{ #category : #defaults }
LeHtmlBookExportCommandLineHandler >> defaultTemplatePiece [
	^ LeHtmlGtBookPiece gtBook
]

{ #category : #activation }
LeHtmlBookExportCommandLineHandler >> ensureBookLoaded: anInputDirName [
	| anInputDir aResolvedInputDir |
	anInputDir := anInputDirName asFileReference.

	self
		assert: [ anInputDir exists ]
		description: [ 'Book input directory must exist: `{1}`' format: {anInputDir fullName} ].
		
	aResolvedInputDir := anInputDir resolve.
		
	LeDatabasesRegistry defaultLogicalDatabase databasesDo: [ :aDatabase | 
		(aDatabase isKindOf: LeDatabase) ifTrue: [ 
			| aRootDir |
			aRootDir := aDatabase localStoreRootDirectory ifNotNil: #resolve.
			aRootDir = anInputDir ifTrue: [ ^ self ] ] ].
			
	LeDatabasesRegistry defaultLogicalDatabase properties
		addRegisteredDirectory: anInputDir.
	LeDatabasesRegistry default defaultLogicalDatabase reload.
]

{ #category : #accessing }
LeHtmlBookExportCommandLineHandler >> findBookNamed: aBookName [
	| aBook |
	aBook := LeDatabasesRegistry defaultLogicalDatabase databaseNamed: aBookName.

	self
		assert: [ aBook isNotNil ]
		description: [ '"{1}" knowledgebase not found' format: {aBookName} ].
	^ aBook
]

{ #category : #activation }
LeHtmlBookExportCommandLineHandler >> findMainPageInBook: aBook named: aBookName [
	| aMainPage aMainPageName |
	aMainPageName := self optionMainPageName.
	aMainPage := aBook pageNamed: aMainPageName.
	self
		assert: [ aMainPage isNotNil ]
		description: [ '"{1}" does not include "{2}" main page'
				format: {aBookName.
						aMainPageName} ].
	^ aMainPage
]

{ #category : #activation }
LeHtmlBookExportCommandLineHandler >> findTargetDirectoryNamed: aTargetDirName [
	| aTargetDir |
	aTargetDir := aTargetDirName asFileReference.
	self
		assert: [ aTargetDir exists ]
		description: [ 'Target directory must exist: `{1}`' format: {aTargetDir fullName} ].
	^ aTargetDir
]

{ #category : #accessing }
LeHtmlBookExportCommandLineHandler >> findTemplatePieceForFileNamed: aPageTemplateFileName [
	| aPageTemplateFile |
	aPageTemplateFile := nil.
	aPageTemplateFileName
		ifNotNil: [ :aName | 
			aPageTemplateFile := aName asFileReference.
			self
				assert: [ aPageTemplateFile exists ]
				description: [ 'Page template file must exist: `{1}`' format: {aPageTemplateFile fullName} ] ].
	^ aPageTemplateFile
		ifNil: [ self defaultTemplatePiece ]
		ifNotNil: [ :aFile | LeHtmlGtBookPiece fromFile: aFile ]
]

{ #category : #'accessing - arguments' }
LeHtmlBookExportCommandLineHandler >> optionBookInputDirectoryName [
	| anInputDirName |
	anInputDirName := self
		optionAt: 'input-dir'
		ifPresent: [ :anInput | 
			| aName |
			aName := anInput trimBoth.
			self
				assert: [ aName isNotEmpty ]
				description: [ 'Book input directory must not be empty: `{1}`' format: {anInput} ].
			aName ]
		ifAbsent: [ nil ].
	
	^ anInputDirName
]

{ #category : #'accessing - arguments' }
LeHtmlBookExportCommandLineHandler >> optionBookName [
	| aBookName |
	aBookName := self
		optionAt: 'book-name'
		ifPresent: [ :anInput | 
			| aName |
			aName := anInput trimBoth.
			self
				assert: [ aName isNotEmpty ]
				description: [ 'Book name must not be empty: `{1}`' format: {anInput} ].
			aName ]
		ifAbsent: [ self defaultBookName ].
		
	self
		assert: [ aBookName isNotNil ]
		description: [ 'Book name must be defined. Use --book-name option' ].
		
	^ aBookName
]

{ #category : #'accessing - arguments' }
LeHtmlBookExportCommandLineHandler >> optionHypertextReferenceBuilder [
	| aBuilderName |
	aBuilderName := self
			optionAt: 'href-builder'
			ifPresent: [ :anInput |
				| aName |
				aName := anInput trimBoth.
				self
					assert: [ aName isNotEmpty ]
					description: [ 'Hypertext reference builder name must be non-empty: `{1}`' 
						format: {anInput} ].
				aName ]
			ifAbsent: [ nil ].

	aBuilderName ifNotNil: [ 
		TLeExportHypertextReferenceBuilder users do: [ :eachClass | 
			(eachClass optionValue = aBuilderName) ifTrue: [
				^ eachClass new ] ].
		self error: ('Hypertext reference builder named "{1}" does not exist.' format: { aBuilderName }) ].
			
	^ self defaultHypertextReferenceBuilder.
]

{ #category : #'accessing - arguments' }
LeHtmlBookExportCommandLineHandler >> optionMainPageName [
	| aMainPageName |
	aMainPageName := self
			optionAt: 'main-page-name'
			ifPresent: [ :anInput | 
				| aName |
				aName := anInput trimBoth.
				self
					assert: [ aName isNotEmpty ]
					description: [ 'Book name must not be empty: `{1}`' format: {anInput} ].
				aName ]
			ifAbsent: [ self defaultMainPageName ].
			
	self
		assert: [ aMainPageName isNotNil ]
		description: [ 'Main page name must be defined. Use --main-page-name option.' ].
			
	^ aMainPageName
]

{ #category : #'accessing - arguments' }
LeHtmlBookExportCommandLineHandler >> optionPageTemplateFileName [
	| aPageTemplateFileName |
	aPageTemplateFileName := self
			optionAt: 'page-template-file'
			ifPresent: [ :aDir | 
				| aName |
				aName := aDir trimBoth.
				self
					assert: [ aName isNotEmpty ]
					description: [ 'Page template file name must not be empty: `{1}`' format: {aDir} ].
				aName ]
			ifAbsent: [ self defaultPageTemplateFileName ].
	^ aPageTemplateFileName
]

{ #category : #activation }
LeHtmlBookExportCommandLineHandler >> optionTargetDirName [
	| aTargetDirName |
	aTargetDirName := self
			optionAt: 'target-dir'
			ifPresent: [ :aDir | 
				| aName |
				aName := aDir trimBoth.
				self
					assert: [ aName isNotEmpty ]
					description: [ 'Target directory name must not be empty: `{1}`' format: {aDir} ].
				aName ]
			ifAbsent: [ self defaultTargetDirName ].
	^ aTargetDirName
]
