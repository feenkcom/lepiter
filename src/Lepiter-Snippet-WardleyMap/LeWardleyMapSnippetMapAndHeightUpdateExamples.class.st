Class {
	#name : #LeWardleyMapSnippetMapAndHeightUpdateExamples,
	#superclass : #LeWardleyMapSnippetUpdateExamples,
	#category : #'Lepiter-Snippet-WardleyMap-Examples'
}

{ #category : #asserting }
LeWardleyMapSnippetMapAndHeightUpdateExamples >> assertModificationAnnouncements: anAnnouncementsCollection [

	self assert: anAnnouncementsCollection size equals: 2.
	
	self 
		assert: (anAnnouncementsCollection collect: #className) asArray 
		equals: #(
			LeSnippetContentChanged
			LeSnippetHeightChanged).
			
	self 
		assert: anAnnouncementsCollection second snippet height 
		equals: 321.
]

{ #category : #asserting }
LeWardleyMapSnippetMapAndHeightUpdateExamples >> assertSnippetModifiedFor: aSnippet [ 
	self 
		assert: aSnippet wardleyMap
		equals: self wardleyMapWithNode.
	self 
		assert: aSnippet height
		equals: 321
]

{ #category : #'examples - snippets' }
LeWardleyMapSnippetMapAndHeightUpdateExamples >> createTargetSnippet [
	<gtExample>
	<return: #LeWardleyMapSnippet>
	^ LeWardleyMapSnippetExamples new emptySnippet
]

{ #category : #'examples - snippets' }
LeWardleyMapSnippetMapAndHeightUpdateExamples >> modifySnippet: aSnippet [ 
	aSnippet wardleyMap 
		addNode: self newWardleyMapNode.
	aSnippet height: 321
]
