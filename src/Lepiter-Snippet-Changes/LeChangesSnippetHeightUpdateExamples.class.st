Class {
	#name : #LeChangesSnippetHeightUpdateExamples,
	#superclass : #LeSingleSnippetUpdateExamples,
	#category : #'Lepiter-Snippet-Changes-Examples'
}

{ #category : #asserting }
LeChangesSnippetHeightUpdateExamples >> assertModificationAnnouncements: anAnnouncementsCollection [
	self 
		assertOneModificationAnnouncementIn: anAnnouncementsCollection 
		ofType: LeChangesSnippetPreviewHeightChanged 
		do: [ :anAnnouncement |
			self 
				assert: anAnnouncement snippet previewHeight 
				equals: 330 ]
]

{ #category : #asserting }
LeChangesSnippetHeightUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self 
		assert: targetSnippet previewHeight 
		equals: 330
]

{ #category : #'examples - snippets' }
LeChangesSnippetHeightUpdateExamples >> createTargetSnippet [
	<gtExample>
	<return: #LeChangesSnippet>
	^ LeChangesSnippet new
		fileName: 'test.ombu';
		previewHeight: 220
]

{ #category : #'examples - snippets' }
LeChangesSnippetHeightUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	^ aTargetSnippet 
		previewHeight: 330
]
