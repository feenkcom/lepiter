Class {
	#name : #LeEditEmptyExampleSnippetCommandExamples,
	#superclass : #LeEditExampleSnippetCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #accessing }
LeEditEmptyExampleSnippetCommandExamples >> initialModifiedSnippet [
	^ LeExampleSnippet empty 
		exampleBehaviorName: #BlBasicExamples;
		exampleSelector: #circle;
		codeExpanded: false;
		noCode: true;
		previewShowSelector: #gtPreviewFor:;
		previewExpanded:  true;
		previewHeight: 250
]

{ #category : #accessing }
LeEditEmptyExampleSnippetCommandExamples >> initialTargetSnippet [
	^ LeExampleSnippet empty
]
