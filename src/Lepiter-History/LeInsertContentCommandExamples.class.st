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

{ #category : #accessing }
LeInsertContentCommandExamples >> targetDatabase [
	<gtExample>
	
	^ theDatabase ifNil: [
		theDatabase := LeDatabase new. ]
]

{ #category : #accessing }
LeInsertContentCommandExamples >> targetPage [
	<gtExample>
	
	^ thePage ifNil: [
		thePage := self createTargetPage.
		self targetDatabase addPage: thePage ]
]
