Class {
	#name : #LeEditExampleSnippetClearContentCommandExamples,
	#superclass : #LeEditExampleSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #accessing }
LeEditExampleSnippetClearContentCommandExamples >> initialModifiedSnippet [
	^ LeExampleSnippet empty
]

{ #category : #accessing }
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
