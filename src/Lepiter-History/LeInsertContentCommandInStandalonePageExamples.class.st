Class {
	#name : #LeInsertContentCommandInStandalonePageExamples,
	#superclass : #LeInsertContentCommandExamples,
	#traits : 'TLeContentCommandInStandalonePageExamples',
	#classTraits : 'TLeContentCommandInStandalonePageExamples classTrait',
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #asserting }
LeInsertContentCommandInStandalonePageExamples >> assertStructure: aPageStructure forInsertCommandResult: result [ 
	self assertOnlyTimeMetadataSetForSnippet: result insertedSnippet.
	self assertOneEventInPageHistory.
	self 
		assertStructure: aPageStructure 
		forContent: self targetPage.
	self assertTargePageIsSerialisable.
]
