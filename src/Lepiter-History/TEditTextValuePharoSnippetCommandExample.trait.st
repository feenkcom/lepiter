Trait {
	#name : #TEditTextValuePharoSnippetCommandExample,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #accessing }
TEditTextValuePharoSnippetCommandExample >> initialTargetSnippet [
	^ self pharoCodeSnippetWithString: self initialStringValue
]
