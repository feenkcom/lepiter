Extension { #name : #LeContentCommandExamples }

{ #category : #'*Lepiter-Snippet-Text' }
LeContentCommandExamples >> textSnippetWithString: aString [ 
	^ (LeTextSnippet string: aString)
		uid: LeUID new;
		yourself
]
