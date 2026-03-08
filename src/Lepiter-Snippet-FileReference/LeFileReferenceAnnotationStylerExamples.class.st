"
Examples for gtFileReference annotation styler.
"
Class {
	#name : #LeFileReferenceAnnotationStylerExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #'as yet unclassified' }
LeFileReferenceAnnotationStylerExamples >> assertForegroundOfButtonLabel: text hasColor: color [
	| buttonLabel scripter buttonAttribute buttonElement attributes |
	attributes := text attributesAt: 1.
	buttonAttribute := attributes
			detect: [ :each | each class = GtButtonAttribute ]
			ifNone: [ self assert: false description: 'Missing button attribute' ].
	buttonElement := buttonAttribute stencil asElement.
	scripter := BlScripter new element: buttonElement.
	buttonLabel := scripter elementWithoutParent label.
	self assertForegroundOfText: buttonLabel hasColor: color
]

{ #category : #'as yet unclassified' }
LeFileReferenceAnnotationStylerExamples >> assertForegroundOfText: text hasColor: expectedColor [
	| textColor foregroundAttribute attributes |
	attributes := text attributesAt: 1.
	foregroundAttribute := attributes
			detect: [ :each | each class = BlTextForegroundAttribute ]
			ifNone: [ self assert: false description: 'Missing foreground attribute' ].
	textColor := foregroundAttribute paint.
	self assert: textColor equals: expectedColor
]

{ #category : #examples }
LeFileReferenceAnnotationStylerExamples >> styleExistingRelativePathWithoutLabel [
	<gtExample>
	<return: #FileReference>
	| string ast text snippet snippetViewModel aFile snippetStyler aVisitor aFileStyler aReference |
	string := '{{gtFileReference:path=gtoolkit.yaml}}'.
	snippet := LeTextSnippet new string: string.
	text := snippet text.

	snippetViewModel := snippet asSnippetViewModel.
	snippetStyler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	ast := LeParser parse: string.
	snippetStyler style: text ast: ast.
	
	self assertForegroundOfText: text hasColor: BrGlamorousColors textMarkupColor.
	self assertForegroundOfButtonLabel: text hasColor: BrGlamorousColors linkColor.
	
	aVisitor := LeSnippetStylerVisitor new
			styler: snippetStyler;
			text: text.
	aFileStyler := LeFileReferenceAnnotationStyler new composite: aVisitor.
	aFile := (ast // LeFileReferenceAnnotationNode) anyOne.
	aReference := aFileStyler fileReferenceFor: aFile.
	self assert: aReference basename equals: 'gtoolkit.yaml'.
	self assert: aReference exists.

	^ snippet
]

{ #category : #examples }
LeFileReferenceAnnotationStylerExamples >> styleMissingFullPathWithLabel [
	<gtExample>
	<return: #BlText>
	| string ast text snippetStyler snippet snippetViewModel |
	string := '{{gtFileReference:path=/tmp/readme.md|label="Read me"}}'.
	snippet := LeTextSnippet new string: string.
	text := snippet text.
	
	snippetViewModel := snippet asSnippetViewModel.
	snippetStyler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	ast := LeParser parse: string.
	snippetStyler style: text ast: ast.

	self assertForegroundOfText: text hasColor: BrGlamorousColors textMarkupColor.
	self assertForegroundOfButtonLabel: text hasColor: BrGlamorousColors linkWithErrorColor.

	^ text
]

{ #category : #examples }
LeFileReferenceAnnotationStylerExamples >> styleMissingRelativePathWithLabel [
	<gtExample>
	<return: #FileReference>
	| string anAst text snippet snippetViewModel aFile snippetStyler aVisitor aFileStyler aReference |
	string := '{{gtFileReference:path=docs/readme.md|label="Read me"}}'.
	snippet := LeTextSnippet new string: string.
	snippetViewModel := snippet asSnippetViewModel.
	snippetStyler := LeSnippetStyler new snippetViewModel: snippetViewModel.
	text := snippet text.
	aVisitor := LeSnippetStylerVisitor new
			styler: snippetStyler;
			text: text.
	aFileStyler := LeFileReferenceAnnotationStyler new composite: aVisitor.

	anAst := LeParser parse: string.
	aFile := (anAst // LeFileReferenceAnnotationNode) anyOne.
	aReference := aFileStyler fileReferenceFor: aFile.
	self assert: aReference basename equals: 'readme.md'.
	self assert: aReference parent basename equals: 'docs'.
	^ snippet
]

{ #category : #examples }
LeFileReferenceAnnotationStylerExamples >> styler [
	<gtExample>
	<return: #LeFileReferenceAnnotationStyler>
	^ LeFileReferenceAnnotationStyler new
]
