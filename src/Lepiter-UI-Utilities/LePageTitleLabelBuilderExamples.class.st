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
	<gtExample>
	^ LePageTitleLabelBuilder
		forTitle: 'Foo'
		andDatabase: LeDatabase new
]
