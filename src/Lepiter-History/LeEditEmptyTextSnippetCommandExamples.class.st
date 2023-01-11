"
{{gtClass:LeEditTextSnippetCommandExamples}}  has examples for editing a text snippet from a page that is contained within a database.
"
Class {
	#name : #LeEditEmptyTextSnippetCommandExamples,
	#superclass : #LeEditEmptyTextSnippetCommandInStandalonePageExamples,
	#instVars : [
		'theDatabase'
	],
	#category : #'Lepiter-History-Examples'
}

{ #category : #asserting }
LeEditEmptyTextSnippetCommandExamples >> assertEditedSnippetMetadataFor: aSnippet [ 
	self assertFullMetadataSetForSnippet: aSnippet 
]

{ #category : #'examples - setup  pages' }
LeEditEmptyTextSnippetCommandExamples >> targetDatabase [
	<gtExample>
	
	^ theDatabase ifNil: [
		theDatabase := LeDatabase new. ]
]

{ #category : #'examples - setup  pages' }
LeEditEmptyTextSnippetCommandExamples >> targetPage [
	<gtExample>
	
	^ thePage ifNil: [
		thePage := self createTargetPage.
		self targetDatabase addPage: thePage ]
]
