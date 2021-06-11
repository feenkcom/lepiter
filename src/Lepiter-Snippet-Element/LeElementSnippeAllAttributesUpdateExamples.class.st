Class {
	#name : #LeElementSnippeAllAttributesUpdateExamples,
	#superclass : #LeElementSnippeUpdateExamples,
	#category : #'Lepiter-Snippet-Element-Examples'
}

{ #category : #'examples - snippets' }
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
