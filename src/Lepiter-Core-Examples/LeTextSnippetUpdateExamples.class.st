Class {
	#name : #LeTextSnippetUpdateExamples,
	#superclass : #LeSingleSnippetUpdateExamples,
	#category : #'Lepiter-Core-Examples-Content'
}

{ #category : #accessing }
LeTextSnippetUpdateExamples >> assertModificationAnnouncements: anAnnouncementsCollection [
	self 
		assertOneModificationAnnouncementIn: anAnnouncementsCollection 
		ofType: LeSnippetTextChanged 
		do: [ :anAnnouncement |
			self 
				assert: anAnnouncement snippet string 
				equals: 'modified text v2' ]
]

{ #category : #'examples - snippets' }
LeTextSnippetUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self assert: targetSnippet string equals: 'modified text v2'.
]

{ #category : #'examples - snippets' }
LeTextSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	<return: #LeTextSnippet>
	^ LeTextSnippet string: 'some text v1'
]

{ #category : #'examples - snippets' }
LeTextSnippetUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	aTargetSnippet updateText: 'modified text v2' asRopedText.
	self 
		assert: aTargetSnippet string 
		equals: 'modified text v2'.
	^ aTargetSnippet
]
