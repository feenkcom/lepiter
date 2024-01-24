Extension { #name : #LeEditEmptyExampleSnippetCommandExamples }

{ #category : #'*Lepiter-Snippet-Example' }
LeEditEmptyExampleSnippetCommandExamples >> initialModifiedSnippet [
	^ LeExampleSnippet empty 
		exampleBehaviorName: #BlBasicExamples;
		exampleSelector: #circle;
		codeExpanded: false;
		noCode: true;
		previewShowSelector: #gtPreviewFor:;
		previewShowSelector: #gtRawFor:;
		previewExpanded:  true;
		previewHeight: 250
]

{ #category : #'*Lepiter-Snippet-Example' }
LeEditEmptyExampleSnippetCommandExamples >> initialTargetSnippet [
	^ LeExampleSnippet empty
]
