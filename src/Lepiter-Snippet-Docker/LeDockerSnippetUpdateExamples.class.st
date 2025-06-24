Class {
	#name : #LeDockerSnippetUpdateExamples,
	#superclass : #LeSingleSnippetUpdateExamples,
	#category : #'Lepiter-Snippet-Docker-Examples'
}

{ #category : #asserting }
LeDockerSnippetUpdateExamples >> assertModificationAnnouncements: anAnnouncementsCollection [
	self 
		assertOneModificationAnnouncementIn: anAnnouncementsCollection 
		ofType: LeDockerSnippetUrlChanged 
		do: [ :anAnnouncement |
			self 
				assert: anAnnouncement snippet url 
				equals: 'www.example.com/docker2' ]
]

{ #category : #asserting }
LeDockerSnippetUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self 
		assert: targetSnippet url
		equals:'www.example.com/docker2'
]

{ #category : #'examples - snippets' }
LeDockerSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	<return: #LeDockerSnippet>
	^ LeDockerSnippet new url: 'www.example.com/docker1'
]

{ #category : #actions }
LeDockerSnippetUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	^ aTargetSnippet url: 'www.example.com/docker2'
]
