Class {
	#name : #LePictureAnnotationStylerExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Picture-Examples'
}

{ #category : #examples }
LePictureAnnotationStylerExamples >> styleReferenceKeyAndValue [
	<gtExample>
	<return: #LePage>
	| anAst aStyler aText aViewModel aString aPage aSnippet aDatabase aPicture aResult aPictureNode aPictureNodeQuery aSnippetReference |
	aString := '{{gtPictureReference:reference=fig123}}'.
	aText := aString asRopedText.
	anAst := LeParser parse: aString.

	aPictureNodeQuery := anAst // LePictureAnnotationNode.
	self assert: aPictureNodeQuery isEmpty not.
	self assert: aPictureNodeQuery size equals: 1.
	aPictureNode := aPictureNodeQuery anyOne.

	self assert: aPictureNode pictureReference equals: 'fig123'.

	aDatabase := LeDatabase new.
	aPage := LePage new.
	aPage title: 'Picture reference'.
	aDatabase addPage: aPage.
	aPicture := LePictureSnippet new.
	aPicture reference: 'fig123'.
	aPicture caption: 'Picture caption of fig123'.
	aPicture previewHeight: 300.
	aPage addSnippet: aPicture.
	aSnippet := LeTextSnippet new string: aString.
	aPage addSnippet: aSnippet.

	aViewModel := aSnippet asSnippetViewModel.

	aStyler := LeSnippetStyler new snippetViewModel: aViewModel.

	aSnippetReference := aStyler pictureSnippetWithReference: 'fig123'.
	self assert: aSnippetReference snippetModel equals: aPicture.
	self assert: aSnippetReference index equals: 1.
	self assert: aSnippetReference reference equals: 'fig123'.

	aResult := aStyler style: aText ast: anAst.

	^ aPage
]

{ #category : #examples }
LePictureAnnotationStylerExamples >> styler [
	<gtExample>
	<return: #LePictureAnnotationStyler>
	^ LePictureAnnotationStyler new
]
