Class {
	#name : #LePythonSnippetUpdateExamples,
	#superclass : #LeSingleSnippetUpdateExamples,
	#category : #'Lepiter-Python-Examples'
}

{ #category : #asserting }
LePythonSnippetUpdateExamples >> assertModificationAnnouncements: anAnnouncementsCollection [
	self 
		assertOneModificationAnnouncementIn: anAnnouncementsCollection 
		ofType: LeSnippetTextChanged 
		do: [ :anAnnouncement |
			self 
				assert: anAnnouncement snippet string 
				equals: '1+2+3' ]
]

{ #category : #asserting }
LePythonSnippetUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self assert: targetSnippet code equals: '1+2+3'.
]

{ #category : #'examples - snippets' }
LePythonSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	<return: #LePythonSnippet>
	^ LePythonSnippet code: '1+2'
]

{ #category : #'examples - snippets' }
LePythonSnippetUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	aTargetSnippet code: '1+2+3'.
	self 
		assert: aTargetSnippet code 
		equals: '1+2+3'.
	^ aTargetSnippet
]
