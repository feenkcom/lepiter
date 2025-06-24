Extension { #name : #LeExportSnippetExamples }

{ #category : #'*Lepiter-Snippet-Example' }
LeExportSnippetExamples >> exampleSnippetCodeWithPreview [
	<gtExample>
	<return: #LeExampleSnippet>
	| snippet |
	snippet := LeExampleSnippet empty
			exampleBehaviorName: #BlBasicExamples;
			exampleSelector: #circle;
			codeExpanded: true;
			noCode: false;
			previewShowSelector: #gtPreviewFor:;
			previewExpanded: true;
			previewHeight: 250.

	^ snippet
]

{ #category : #'*Lepiter-Snippet-Example' }
LeExportSnippetExamples >> exampleSnippetCodeWithoutPreview [
	<gtExample>
	<return: #LeExampleSnippet>
	| snippet |
	snippet := LeExampleSnippet empty
			exampleBehaviorName: #BlBasicExamples;
			exampleSelector: #circle;
			codeExpanded: true;
			noCode: false;
			previewShowSelector: #gtPreviewFor:;
			previewExpanded: false;
			previewHeight: 250.

	^ snippet
]

{ #category : #'*Lepiter-Snippet-Example' }
LeExportSnippetExamples >> exampleSnippetNoCodeWithPreview [
	<gtExample>
	<return: #LeExampleSnippet>
	| snippet |
	snippet := LeExampleSnippet empty
			exampleBehaviorName: #BlBasicExamples;
			exampleSelector: #circle;
			codeExpanded: false;
			noCode: true;
			previewShowSelector: #gtPreviewFor:;
			previewExpanded: true;
			previewHeight: 250.

	^ snippet
]
