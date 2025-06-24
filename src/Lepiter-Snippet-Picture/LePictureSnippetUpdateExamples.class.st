Class {
	#name : #LePictureSnippetUpdateExamples,
	#superclass : #LeSingleSnippetUpdateExamples,
	#category : #'Lepiter-Snippet-Picture-Examples'
}

{ #category : #asserting }
LePictureSnippetUpdateExamples >> assertModificationAnnouncements: anAnnouncementsCollection [
	self 
		assertOneModificationAnnouncementIn: anAnnouncementsCollection 
		ofType: LeSnippetContentChanged 
		do: [ :anAnnouncement |
			"Nothing to assert here" ]
]

{ #category : #asserting }
LePictureSnippetUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self 
		assert: targetSnippet urlString 
		equals: 'www.example.com/picture2'
]

{ #category : #'examples - snippets' }
LePictureSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	<return: #LePictureSnippet>
	^ LePictureSnippet new urlString: 'www.example.com/picture1'
]

{ #category : #'examples - snippets' }
LePictureSnippetUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	^ aTargetSnippet urlString: 'www.example.com/picture2'
]
