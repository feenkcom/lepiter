Class {
	#name : #LePageTitleLabelBuilderExamples,
	#superclass : #Object,
	#category : #'Lepiter-UI-Utilities-Examples'
}

{ #category : #accessing }
LePageTitleLabelBuilderExamples >> gtBookMainPageLabel [
	"Explicitly give the page title and database."
	<gtExample>
	^ LePageTitleLabelBuilder
		forTitle: 'Glamorous Toolkit'
		andDatabase: LeDatabase gtBook
]

{ #category : #accessing }
LePageTitleLabelBuilderExamples >> gtBookNamedPageLabel [
	"Just reference the page."
	<gtExample>
	^ LePageTitleLabelBuilder
		forPage: (LeDatabase gtBook pageNamed: 'Glamorous Toolkit')
]

{ #category : #accessing }
LePageTitleLabelBuilderExamples >> nonExistentPageLabel [
	"Highlight in pink and don't link to an actual page."
	<gtExample>
	^ LePageTitleLabelBuilder
		forTitle: 'Foo'
		andDatabase: LeDatabase new
]

{ #category : #accessing }
LePageTitleLabelBuilderExamples >> patternPageWithLabel [
	"A label with a category that is not part of the page title."
	<gtExample>
	^ LePageTitleLabelBuilder
		forCategory: '(M) '
		andTitle: 'Moldable Object'
		andDatabase: LeDatabase gtBook
]
