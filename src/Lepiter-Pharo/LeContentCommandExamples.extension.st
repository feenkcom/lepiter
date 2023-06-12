Extension { #name : #LeContentCommandExamples }

{ #category : #'*Lepiter-Pharo' }
LeContentCommandExamples >> pharoCodeSnippetWithString: aString [ 
	^ (LePharoSnippet code: aString)
		uid: LeUID new;
		yourself
]
