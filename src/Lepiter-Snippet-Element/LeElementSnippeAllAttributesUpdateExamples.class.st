Class {
	#name : #LeElementSnippeAllAttributesUpdateExamples,
	#superclass : #LeElementSnippeUpdateExamples,
	#category : #'Lepiter-Snippet-Element-Examples'
}

{ #category : #asserting }
LeElementSnippeAllAttributesUpdateExamples >> assertModificationAnnouncements: anAnnouncementsCollection [

	self assert: anAnnouncementsCollection size equals: 4.
	
	self 
		assert: (anAnnouncementsCollection collect: #className) asArray 
		equals: #(
			LeSnippetTextChanged
			LeElementSnippetElementHeightChanged
			LeElementSnippetCodeHeightChanged
			LeElementSnippetCodeVisibilityChanged).
			
	self 
		assert: anAnnouncementsCollection first snippet string 
		equals: self updatedCode.
	self 
		assert: anAnnouncementsCollection second snippet elementHeight 
		equals: 123.
	self 
		assert: anAnnouncementsCollection third snippet codeHeight 
		equals: 57.
	self 
		assert: anAnnouncementsCollection fourth snippet codeVisible 
		equals: false.
]

{ #category : #asserting }
LeElementSnippeAllAttributesUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self 
		assert: targetSnippet code 
		equals: self updatedCode.
		
	self assert: targetSnippet elementHeight equals: 123.
	self assert: targetSnippet codeHeight equals: 57.
	self assert: targetSnippet codeVisible not
]

{ #category : #'examples - snippets' }
LeElementSnippeAllAttributesUpdateExamples >> createTargetSnippet [
	<gtExample>
	<return: #LeElementSnippet>
	| targetSnippet |
	targetSnippet := LeElementSnippet code: 'BlElement new'.

	self assert: targetSnippet elementHeight equals: 100.
	self assert: targetSnippet codeHeight equals: 50.
	self assert: targetSnippet codeVisible.

	^ targetSnippet
]

{ #category : #'examples - snippets' }
LeElementSnippeAllAttributesUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	aTargetSnippet code: self updatedCode.
	
	aTargetSnippet elementHeight: 123.
	aTargetSnippet codeHeight: 57.
	aTargetSnippet codeVisible: false.
	
	^ aTargetSnippet
]

{ #category : #accessing }
LeElementSnippeAllAttributesUpdateExamples >> updatedCode [
	^ 'BlElement new
		background: Color red'
]
