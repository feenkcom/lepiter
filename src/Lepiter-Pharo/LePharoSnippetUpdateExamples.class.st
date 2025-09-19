Class {
	#name : #LePharoSnippetUpdateExamples,
	#superclass : #LeSingleSnippetUpdateExamples,
	#category : #'Lepiter-Pharo-Examples'
}

{ #category : #asserting }
LePharoSnippetUpdateExamples >> assertModificationAnnouncements: anAnnouncementsCollection [
	self 
		assertOneModificationAnnouncementIn: anAnnouncementsCollection 
		ofType: LeSnippetTextChanged 
		do: [ :anAnnouncement |
			self 
				assert: anAnnouncement snippet string 
				equals: '1+2+3' ]
]

{ #category : #asserting }
LePharoSnippetUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self assert: targetSnippet code equals: '1+2+3'.
]

{ #category : #'examples - snippets' }
LePharoSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	<return: #LePharoSnippet>
	^ LePharoSnippet code: '1+2'
]

{ #category : #'examples - snippets' }
LePharoSnippetUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	aTargetSnippet code: '1+2+3'.
	self 
		assert: aTargetSnippet code 
		equals: '1+2+3'.
	^ aTargetSnippet
]
