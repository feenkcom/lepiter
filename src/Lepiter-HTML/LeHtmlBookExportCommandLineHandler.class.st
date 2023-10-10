Class {
	#name : #LeHtmlBookExportCommandLineHandler,
	#superclass : #CommandLineHandler,
	#category : #'Lepiter-HTML-Command Line'
}

{ #category : #accessing }
LeHtmlBookExportCommandLineHandler class >> commandName [
	^ 'exportgtbook'
]

{ #category : #accessing }
LeHtmlBookExportCommandLineHandler class >> description [
	^ 'export Glamorous Toolkit book into HTML'
]

{ #category : #activation }
LeHtmlBookExportCommandLineHandler >> activate [
	| aBookExporter aGtBook targetDirName targetDir theWorkflowBuilder aMainPage |
	self activateHelp ifTrue: [ ^ self ].

	aGtBook := LeDatabasesRegistry defaultLogicalDatabase
			databaseNamed: 'Glamorous Toolkit Book'.

	self
		assert: [ aGtBook isNotNil ]
		description: [ 'Glamorous Toolkit Book not found' ].
		
	aMainPage := aGtBook pageNamed: 'Glamorous Toolkit'.

	self
		assert: [ aGtBook isNotNil ]
		description: [ 'Glamorous Toolkit main page not found' ].
		
	targetDirName := self
			optionAt: 'target-dir'
			ifPresent: [ :aDir | 
				| aName |
				aName := aDir trimBoth.
				self
					assert: [ aName isNotEmpty ]
					description: [ 'Target directory name must not be empty: `{1}`' 
						format: {aName} ].
				aName ]
			ifAbsent: [ './' ].

	targetDir := targetDirName asFileReference.

	self
		assert: [ targetDir exists ]
		description: [ 'Target directory must exist: `{1}`' format: {targetDir fullName} ].

	theWorkflowBuilder := [ 
		NonInteractiveTranscript stdout
			show: 'Exporting Glamorous Toolkit book into ';
			print: targetDir fullName;
			show: ' directory: '.
	
		aBookExporter := LeHtmlBookExporter new
			database: aGtBook;
			mainPage: aMainPage;
			piece: LeHtmlGtBookPiece gtBook;
			hrefBuilder: LeExportFilenameHypertextReferenceBuilder new;
			integerSequencer;
			addGtBookAssets;
			export;
			saveToRootDirectory: targetDir.
			
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
