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
	| aBookExporter aGtBook targetDirName targetDir |
	self activateHelp ifTrue: [ ^ self ].

	aGtBook := LeDatabasesRegistry defaultLogicalDatabase
			databaseNamed: 'Glamorous Toolkit Book'.

	self
		assert: [ aGtBook isNotNil ]
		description: [ 'Glamorous Toolkit Book not found' ].

	targetDirName := self
			optionAt: 'target-dir'
			ifPresent: [ :aDir | aDir trimBoth ]
			ifAbsent: [ './' ].

	self
		assert: [ targetDirName isNotEmpty ]
		description: [ 'Target directory name must not be empty: `{1}`' format: {targetDirName} ].

	targetDir := targetDirName asFileReference.

	self
		assert: [ targetDir exists ]
		description: [ 'Target directory must exist: `{1}`' format: {targetDir fullName} ].

	NonInteractiveTranscript stdout
		show: 'Exporting Glamorous Toolkit book into ';
		print: targetDir fullName;
		show: ' directory: '.

	aBookExporter := LeHtmlBookExporter new
			database: aGtBook;
			resourcesExporter: LeResourcesExporter new;
			integerGenerator;
			withFileAssets: FileLocator gtResource / 'feenkcom/lepiter/doc/gtbook/assets';
			export;
			saveToRootDirectory: targetDir.

	NonInteractiveTranscript stdout
		show: 'DONE.';
		cr
]
