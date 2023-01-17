Class {
	#name : #LeEditExampleSnippetWithContentCommandExamples,
	#superclass : #LeEditExampleSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #accessing }
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

{ #category : #accessing }
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
