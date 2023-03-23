Class {
	#name : #LeEditElementSnippetCommandExamples,
	#superclass : #LeEditSnippetStateCommandExamples,
	#category : #'Lepiter-Snippet-Element-Examples'
}

{ #category : #testing }
LeEditElementSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeEditElementSnippetCommandExamples
]

{ #category : #asserting }
LeEditElementSnippetCommandExamples >> assertTargetSnippetContentChanged [
	self assert: (self targetSnippet 
		similarTo: self initialModifiedSnippet)
]

{ #category : #accessing }
LeEditElementSnippetCommandExamples >> changedStateAttributes [
	self subclassResponsibility
]

{ #category : #accessing }
LeEditElementSnippetCommandExamples >> initialModifiedSnippet [
	self subclassResponsibility
]
