Extension { #name : #LeEditExampleSnippetWithContentCommandExamples }

{ #category : #'*Lepiter-Snippet-Example' }
LeEditExampleSnippetWithContentCommandExamples >> initialModifiedSnippet [
	^ LeExampleSnippet empty 
		exampleBehaviorName: #BlBasicExamples;
		exampleSelector: #ellipse;
		codeExpanded: true;
		noCode: true;
		previewShowSelector: #gtLiveFor:;
		previewExpanded:  false;
		previewHeight: 250
]

{ #category : #'*Lepiter-Snippet-Example' }
LeEditExampleSnippetWithContentCommandExamples >> initialTargetSnippet [
	^ LeExampleSnippet empty 
		exampleBehaviorName: #BlBasicExamples;
		exampleSelector: #circle;
		codeExpanded: false;
		noCode: true;
		previewShowSelector: #gtPreviewFor:;
		previewExpanded:  true;
		previewHeight: 250
]
