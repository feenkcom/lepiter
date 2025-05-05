Class {
	#name : #LeJavaScriptSnippetUpdateExamples,
	#superclass : #LeSingleSnippetUpdateExamples,
	#category : #'Lepiter-JavaScript-Examples'
}

{ #category : #asserting }
LeJavaScriptSnippetUpdateExamples >> assertModificationAnnouncements: anAnnouncementsCollection [
	self 
		assertOneModificationAnnouncementIn: anAnnouncementsCollection 
		ofType: LeSnippetTextChanged 
		do: [ :anAnnouncement |
			self 
				assert: anAnnouncement snippet string 
				equals: '1+2+3' ]
]

{ #category : #asserting }
LeJavaScriptSnippetUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self assert: targetSnippet code equals: '1+2+3'.
]

{ #category : #'examples - snippets' }
LeJavaScriptSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	<return: #LeJavaScriptSnippet>
	^ LeJavaScriptSnippet code: '1+2'
]

{ #category : #'examples - snippets' }
LeJavaScriptSnippetUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	aTargetSnippet code: '1+2+3'.
	self 
		assert: aTargetSnippet code 
		equals: '1+2+3'.
	^ aTargetSnippet
]
