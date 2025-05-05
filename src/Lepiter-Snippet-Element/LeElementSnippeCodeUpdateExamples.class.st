Class {
	#name : #LeElementSnippeCodeUpdateExamples,
	#superclass : #LeElementSnippeUpdateExamples,
	#category : #'Lepiter-Snippet-Element-Examples'
}

{ #category : #asserting }
LeElementSnippeCodeUpdateExamples >> assertModificationAnnouncements: anAnnouncementsCollection [
	self 
		assertOneModificationAnnouncementIn: anAnnouncementsCollection 
		ofType: LeSnippetTextChanged 
		do: [ :anAnnouncement |
			self 
				assert: anAnnouncement snippet string 
				equals: self updatedCode ]
]

{ #category : #asserting }
LeElementSnippeCodeUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self 
		assert: targetSnippet code 
		equals: self updatedCode.
		
	self assert: targetSnippet elementHeight equals: 100.
	self assert: targetSnippet codeHeight equals: 50.
	self assert: targetSnippet codeVisible
]

{ #category : #'examples - snippets' }
LeElementSnippeCodeUpdateExamples >> createTargetSnippet [
	<gtExample>
	<return: #LeElementSnippet>
	^ LeElementSnippet code: 'BlElement new'
]

{ #category : #'examples - snippets' }
LeElementSnippeCodeUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	aTargetSnippet code: self updatedCode.
	
	^ aTargetSnippet
]

{ #category : #accessing }
LeElementSnippeCodeUpdateExamples >> updatedCode [
	^ 'BlElement new
		background: Color red'
]
