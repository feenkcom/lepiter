"
{{gtClass:LeEditTextSnippetCommandExamples}}  has examples for editing a text snippet from a page that is contained within a database.
"
Class {
	#name : #LeEditTextSnippetCommandExamples,
	#superclass : #LeEditTextSnippetCommandInStandalonePageExamples,
	#instVars : [
		'theDatabase'
	],
	#category : #'Lepiter-History-Examples'
}

{ #category : #asserting }
LeEditTextSnippetCommandExamples >> assertEditedSnippetMetadataFor: aSnippet [ 
	self assertFullMetadataSetForSnippet: aSnippet 
]

{ #category : #'examples - setup  pages' }
LeEditTextSnippetCommandExamples >> targetDatabase [
	<gtExample>
	
	^ theDatabase ifNil: [
		theDatabase := LeDatabase new. ]
]

{ #category : #'examples - setup  pages' }
LeEditTextSnippetCommandExamples >> targetPage [
	<gtExample>
	
	^ thePage ifNil: [
		thePage := self createTargetPage.
		self targetDatabase addPage: thePage ]
]
