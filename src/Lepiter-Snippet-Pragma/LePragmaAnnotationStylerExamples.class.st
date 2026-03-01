"
Examples for gtPragma annotation styling.
"
Class {
	#name : #LePragmaAnnotationStylerExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #examples }
LePragmaAnnotationStylerExamples >> styleExistingPragmaAnnotation [
	<gtExample>
	<return: #BlText>
	| aString anAst aText aStyler aSnippet aViewModel aPage aDatabase anAnnotation |
	aString := '{{gtPragma:gtView}}'.
	aText := aString asRopedText.
	anAst := LeParser parse: aString.

	anAnnotation := (anAst // LePragmaAnnotationNode) anyOne.
	self assert: anAnnotation notNil.

	aDatabase := LeDatabase new.
	aPage := LePage new.
	aPage title: 'Pragma reference'.
	aDatabase addPage: aPage.
	aSnippet := LeTextSnippet new string: aString.
	aPage addSnippet: aSnippet.

	aViewModel := aSnippet asSnippetViewModel.
	aStyler := LeSnippetStyler new snippetViewModel: aViewModel.

	aStyler style: aText ast: anAst.

	self assert: (aText attributesAt: anAnnotation parent startPosition) notEmpty.

	^ aText
]

{ #category : #examples }
LePragmaAnnotationStylerExamples >> styleMissingPragmaAnnotation [
	<gtExample>
	<return: #BlText>
	| aString anAst aText aStyler aSnippet aViewModel aPage aDatabase anAnnotation |

	aString := '{{gtPragma:doesNotExistPragma}}'.
	aText := aString asRopedText.
	anAst := LeParser parse: aString.

	anAnnotation := (anAst // LePragmaAnnotationNode) anyOne.
	self assert: anAnnotation notNil.

	aDatabase := LeDatabase new.
	aPage := LePage new.
	aPage title: 'Pragma reference missing'.
	aDatabase addPage: aPage.
	aSnippet := LeTextSnippet new string: aString.
	aPage addSnippet: aSnippet.

	aViewModel := aSnippet asSnippetViewModel.
	aStyler := LeSnippetStyler new snippetViewModel: aViewModel.

	aStyler style: aText ast: anAst.

	self assert: (aText attributesAt: anAnnotation parent startPosition) notEmpty.

	^ aText
]
