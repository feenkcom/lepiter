Class {
	#name : #LeEditElementSnippetCodeCommandExamples,
	#superclass : #LeEditCodeSnippetCommandExamples,
	#category : #'Lepiter-Snippet-Element-Examples'
}

{ #category : #testing }
LeEditElementSnippetCodeCommandExamples class >> isAbstract [
	^ self name = #LeEditElementSnippetCodeCommandExamples
]

{ #category : #accessing }
LeEditElementSnippetCodeCommandExamples >> elementSnippetWithString: aString [ 
	^ (LeElementSnippet code: aString)
		uid: LeUID new;
		yourself
]

{ #category : #accessing }
LeEditElementSnippetCodeCommandExamples >> initialTargetSnippet [
	^ self elementSnippetWithString: self initialStringValue
]
