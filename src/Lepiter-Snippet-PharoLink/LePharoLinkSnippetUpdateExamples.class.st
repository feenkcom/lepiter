Class {
	#name : #LePharoLinkSnippetUpdateExamples,
	#superclass : #LeSingleSnippetUpdateExamples,
	#category : #'Lepiter-Snippet-PharoLink-Examples'
}

{ #category : #asserting }
LePharoLinkSnippetUpdateExamples >> assertModificationAnnouncements: anAnnouncementsCollection [
	self 
		assertOneModificationAnnouncementIn: anAnnouncementsCollection 
		ofType: LeSnippetTextChanged 
		do: [ :anAnnouncement |
			self 
				assert: anAnnouncement snippet string 
				equals: '1+2+3' ]
]

{ #category : #asserting }
LePharoLinkSnippetUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self assert: targetSnippet code equals: '1+2+3'.
]

{ #category : #'examples - snippets' }
LePharoLinkSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	<return: #LePharoLinkSnippet>
	^ LePharoLinkSnippet code: '1+2'
]

{ #category : #'examples - snippets' }
LePharoLinkSnippetUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	aTargetSnippet code: '1+2+3'.
	self 
		assert: aTargetSnippet code 
		equals: '1+2+3'.
	^ aTargetSnippet
]
