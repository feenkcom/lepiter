Class {
	#name : #LeWordSnippetUpdateExamples,
	#superclass : #LeSingleSnippetUpdateExamples,
	#category : #'Lepiter-Snippet-Words-Examples'
}

{ #category : #asserting }
LeWordSnippetUpdateExamples >> assertModificationAnnouncements: anAnnouncementsCollection [
	self 
		assertOneModificationAnnouncementIn: anAnnouncementsCollection 
		ofType: LeWordSnippetWordChangedAnnouncement 
		do: [ :anAnnouncement |
			self 
				assert: anAnnouncement snippet word 
				equals: 'hello2' ]
]

{ #category : #asserting }
LeWordSnippetUpdateExamples >> assertSnippetModifiedFor: aSnippet [ 
	self assert: aSnippet word equals: 'hello2'
]

{ #category : #'examples - snippets' }
LeWordSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	<return: #LeWordSnippet>
	^ LeWordExamples new snippetWithExplanation
]

{ #category : #'examples - snippets' }
LeWordSnippetUpdateExamples >> modifySnippet: aSnippet [ 
	aSnippet word: 'hello2'
]
