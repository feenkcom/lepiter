"
Examples for gtFileReference annotation styler.
"
Class {
	#name : #LeFileReferenceAnnotationStylerExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #examples }
LeFileReferenceAnnotationStylerExamples >> styleReferenceRelativePath [
	<gtExample>
	<return: #FileReference>
	| aString anAst aText aSnippet aViewModel aPage aDatabase aFile aSnippetStyler aVisitor aFileStyler aReference |
	aString := '{{gtFileReference:path=docs/readme.md|label="Read me"}}'.
	aText := aString asRopedText.
	anAst := LeParser parse: aString.

	aDatabase := LeDatabase new.
	aPage := LePage new.
	aPage title: 'File reference'.
	aDatabase addPage: aPage.
	aSnippet := LeTextSnippet new string: aString.
	aPage addSnippet: aSnippet.

	aViewModel := aSnippet asSnippetViewModel.
	aSnippetStyler := LeSnippetStyler new snippetViewModel: aViewModel.
	aVisitor := LeSnippetStylerVisitor new
		styler: aSnippetStyler;
		text: aText.
	aFileStyler := LeFileReferenceAnnotationStyler new composite: aVisitor.

	aFile := (anAst // LeFileReferenceAnnotationNode) anyOne.
	aReference := aFileStyler fileReferenceFor: aFile.
	self assert: (aReference pathString endsWith: 'docs/readme.md').
	^ aReference
]

{ #category : #examples }
LeFileReferenceAnnotationStylerExamples >> styleReferenceWithLabel [
	<gtExample>
	<return: #BlText>
	| aString anAst aText aStyler aSnippet aViewModel aPage aDatabase |
	aString := '{{gtFileReference:path=/tmp/readme.md|label="Read me"}}'.
	aText := aString asRopedText.
	anAst := LeParser parse: aString.

	aDatabase := LeDatabase new.
	aPage := LePage new.
	aPage title: 'File reference'.
	aDatabase addPage: aPage.
	aSnippet := LeTextSnippet new string: aString.
	aPage addSnippet: aSnippet.

	aViewModel := aSnippet asSnippetViewModel.
	aStyler := LeSnippetStyler new snippetViewModel: aViewModel.

	aStyler style: aText ast: anAst.

	self assert: (aText attributesAt: 1) notEmpty.

	^ aText
]

{ #category : #examples }
LeFileReferenceAnnotationStylerExamples >> styler [
	<gtExample>
	<return: #LeFileReferenceAnnotationStyler>
	^ LeFileReferenceAnnotationStyler new
]
