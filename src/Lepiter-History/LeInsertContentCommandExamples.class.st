Class {
	#name : #LeInsertContentCommandExamples,
	#superclass : #LeInsertContentCommandInStandalonePageExamples,
	#instVars : [
		'theDatabase'
	],
	#category : #'Lepiter-History-Examples'
}

{ #category : #asserting }
LeInsertContentCommandExamples >> assertStructure: aPageStructure forInsertCommandResult: result [ 
	self assertFullMetadataSetForSnippet: result insertedSnippet.
	self assertOneEventInPageHistory.
	self 
		assertStructure: aPageStructure 
		forContent: self targetPage.
	self assertTargePageIsSerialisable.
]

{ #category : #'examples - setup  pages' }
LeInsertContentCommandExamples >> targetDatabase [
	<gtExample>
	
	^ theDatabase ifNil: [
		theDatabase := LeDatabase new. ]
]

{ #category : #'examples - setup  pages' }
LeInsertContentCommandExamples >> targetPage [
	<gtExample>
	
	^ thePage ifNil: [
		thePage := self createTargetPage.
		self targetDatabase addPage: thePage ]
]
