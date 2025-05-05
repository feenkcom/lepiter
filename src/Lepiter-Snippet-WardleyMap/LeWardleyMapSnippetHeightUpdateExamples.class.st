Class {
	#name : #LeWardleyMapSnippetHeightUpdateExamples,
	#superclass : #LeWardleyMapSnippetUpdateExamples,
	#category : #'Lepiter-Snippet-WardleyMap-Examples'
}

{ #category : #asserting }
LeWardleyMapSnippetHeightUpdateExamples >> assertModificationAnnouncements: anAnnouncementsCollection [
	self 
		assertOneModificationAnnouncementIn: anAnnouncementsCollection 
		ofType: LeSnippetHeightChanged 
		do: [ :anAnnouncement |
			self 
				assert: anAnnouncement snippet height 
				equals: 321 ]
]

{ #category : #asserting }
LeWardleyMapSnippetHeightUpdateExamples >> assertSnippetModifiedFor: aSnippet [ 
	self 
		assert: aSnippet wardleyMap
		equals: self wardleyMapWithNode.
	self 
		assert: aSnippet height
		equals: 321
]

{ #category : #'examples - snippets' }
LeWardleyMapSnippetHeightUpdateExamples >> createTargetSnippet [
	<gtExample>
	<return: #LeWardleyMapSnippet>
	^ LeWardleyMapSnippet new wardleyMap: self wardleyMapWithNode
]

{ #category : #'examples - snippets' }
LeWardleyMapSnippetHeightUpdateExamples >> modifySnippet: aSnippet [ 
	aSnippet height: 321
]
