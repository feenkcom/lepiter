Extension { #name : #LeEditExampleSnippetClearContentCommandExamples }

{ #category : #'*Lepiter-Snippet-Example' }
LeEditExampleSnippetClearContentCommandExamples >> initialModifiedSnippet [
	^ LeExampleSnippet empty
]

{ #category : #'*Lepiter-Snippet-Example' }
LeEditExampleSnippetClearContentCommandExamples >> initialTargetSnippet [
	^ LeExampleSnippet empty 
		exampleBehaviorName: #BlBasicExamples;
		exampleSelector: #circle;
		codeExpanded: false;
		noCode: true;
		previewShowSelector: #gtPreviewFor:;
		previewExpanded:  true;
		previewHeight: 250
]
