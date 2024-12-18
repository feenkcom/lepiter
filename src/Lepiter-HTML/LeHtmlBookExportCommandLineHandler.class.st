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
	| aBookExporter aBookName aBook aTargetDirName aTargetDir theWorkflowBuilder aMainPageName aMainPage aPageTemplateFileName aPiece aPageTemplateFile |
	self activateHelp ifTrue: [ ^ self ].

	aBookName := self
			optionAt: 'book-name'
			ifPresent: [ :anInput | 
				| aName |
				aName := anInput trimBoth.
				self
					assert: [ aName isNotEmpty ]
					description: [ 'Book name must not be empty: `{1}`'
						format: { anInput } ].
				aName ]
			ifAbsent: [ 'Glamorous Toolkit Book' ].
	
	aBook := LeDatabasesRegistry defaultLogicalDatabase
			databaseNamed: aBookName.

	self
		assert: [ aBook isNotNil ]
		description: [ '"{1}" knowledgebase not found' format: { aBookName } ].
		
	aMainPageName := self
			optionAt: 'main-page-name'
			ifPresent: [ :anInput | 
				| aName |
				aName := anInput trimBoth.
				self
					assert: [ aName isNotEmpty ]
					description: [ 'Book name must not be empty: `{1}`'
						format: { anInput } ].
				aName ]
			ifAbsent: [ 'Glamorous Toolkit' ].
		
	aMainPage := aBook pageNamed: aMainPageName.

	self
		assert: [ aMainPage isNotNil ]
		description: [ '"{1}" does not include "{2}" main page not found'
			format: { aBookName. aMainPageName } ].
		
	aTargetDirName := self
			optionAt: 'target-dir'
			ifPresent: [ :aDir | 
				| aName |
				aName := aDir trimBoth.
				self
					assert: [ aName isNotEmpty ]
					description: [ 'Target directory name must not be empty: `{1}`' 
						format: {aDir} ].
				aName ]
			ifAbsent: [ './' ].

	aTargetDir := aTargetDirName asFileReference.

	self
		assert: [ aTargetDir exists ]
		description: [ 'Target directory must exist: `{1}`' format: {aTargetDir fullName} ].
		
	aPageTemplateFileName := self
			optionAt: 'page-template-file'
			ifPresent: [ :aDir | 
				| aName |
				aName := aDir trimBoth.
				self
					assert: [ aName isNotEmpty ]
					description: [ 'Page template file name must not be empty: `{1}`' 
						format: {aDir} ].
				aName ]
			ifAbsent: [ nil ].
			
	aPageTemplateFile := nil.
	aPageTemplateFileName ifNotNil: [ :aName |
		aPageTemplateFile := aName asFileReference.
	
		self
			assert: [ aPageTemplateFile exists ]
			description: [ 'Page template file must exist: `{1}`' format: {aPageTemplateFile fullName} ] ].
			
	aPiece := aPageTemplateFile
		ifNil: [ LeHtmlGtBookPiece gtBook ]
		ifNotNil: [ :aFile |
			LeHtmlGtBookPiece fromFile: aFile ].

	theWorkflowBuilder := [ 
		NonInteractiveTranscript stdout
			show: 'Exporting "';
			show: aBookName; 
			show: '" into ';
			print: aTargetDir fullName;
			show: ' directory: '.
	
		aBookExporter := LeHtmlBookExporter new
			database: aBook;
			mainPage: aMainPage;
			piece: aPiece;
			hrefBuilder: LeExportFilenameHypertextReferenceBuilder new;
			integerSequencer;
			addGtBookAssets;
			export;
			saveToRootDirectory: aTargetDir.
			
		NonInteractiveTranscript stdout
			show: 'DONE.';
			cr. ].
		
	(self hasOption: 'verbose')
		ifTrue: [ TranscriptLogger runDuring: theWorkflowBuilder ]
		ifFalse: theWorkflowBuilder.

	(self hasOption: 'save')
		ifTrue: [ 
			^ Smalltalk 
				snapshot: true 
				andQuit: (self hasOption: 'no-quit') not ].

	(self hasOption: 'no-quit')
		ifFalse: [ self quit ]
]
