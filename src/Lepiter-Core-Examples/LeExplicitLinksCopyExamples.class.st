Class {
	#name : #LeExplicitLinksCopyExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Core-Examples-Links'
}

{ #category : #examples }
LeExplicitLinksCopyExamples >> databaseWithAttachedLinksHasLinksForSaving [
	<gtExample>
	<return: #LeDatabase>
	| database explicitLinksCopy |
	database := LeExplicitlyAttachedLinksExamples new
			databaseWithExplicitLinkBetweenPages.
	explicitLinksCopy := database explicitLinks copyForSavingOnlyWithAttachedLinks.

	self assert: explicitLinksCopy size equals: 1.

	^ database
]

{ #category : #examples }
LeExplicitLinksCopyExamples >> databaseWithTextualPageLinksHasNoLinksForSaving [
	<gtExample>
	<return: #LeDatabase>
	| database explicitLinksCopy |
	database := LeTextualPageLinkWithinSameDatabaseExamples new
			createDatabaseWithTextualLink.
	explicitLinksCopy := database explicitLinks copyForSavingOnlyWithAttachedLinks.

	self assert: explicitLinksCopy isEmpty.

	^ database
]

{ #category : #examples }
LeExplicitLinksCopyExamples >> databaseWithTextualSnippetLinksHasNoLinksForSaving [
	<gtExample>
	<return: #LeDatabase>
	| database explicitLinksCopy |
	database := LeTextualSnippetLinkBetweenChildrenExamples new
			createDatabaseWithTextualLink.
	explicitLinksCopy := database explicitLinks copyForSavingOnlyWithAttachedLinks.

	self assert: explicitLinksCopy isEmpty.

	^ database
]
