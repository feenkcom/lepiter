Class {
	#name : #LeConnectorExamples,
	#superclass : #Object,
	#category : 'Lepiter-UI-Examples'
}

{ #category : #accessing }
LeConnectorExamples >> emptyPageShowsOnlyChildren [
	<gtExample>
	<noTest>
	| lePage pageContainer |
	lePage := LePage named: #EmptyPage.
	pageContainer := LeConnectorPageContainerElement new.
	pageContainer page: lePage.
	^ pageContainer
]
