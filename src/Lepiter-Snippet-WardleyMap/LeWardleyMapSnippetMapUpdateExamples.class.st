Class {
	#name : #LeWardleyMapSnippetMapUpdateExamples,
	#superclass : #LeWardleyMapSnippetUpdateExamples,
	#category : #'Lepiter-Snippet-WardleyMap-Examples'
}

{ #category : #asserting }
LeWardleyMapSnippetMapUpdateExamples >> assertModificationAnnouncements: anAnnouncementsCollection [
	self 
		assertOneModificationAnnouncementIn: anAnnouncementsCollection 
		ofType: LeSnippetContentChanged 
		do: [ :anAnnouncement |
			"Nothing to assert for this announcement" ]
]

{ #category : #asserting }
LeWardleyMapSnippetMapUpdateExamples >> assertSnippetModifiedFor: aSnippet [ 
	self 
		assert: aSnippet wardleyMap
		equals: self wardleyMapWithNode.
	self 
		assert: aSnippet height
		equals: LeWardleyMapSnippet defaultHeight
]

{ #category : #'examples - snippets' }
LeWardleyMapSnippetMapUpdateExamples >> createTargetSnippet [
	<gtExample>
	<return: #LeWardleyMapSnippet>
	^ LeWardleyMapSnippetExamples new emptySnippet
]

{ #category : #'examples - snippets' }
LeWardleyMapSnippetMapUpdateExamples >> modifySnippet: aSnippet [ 
	aSnippet wardleyMap 
		addNode: self newWardleyMapNode.
]
