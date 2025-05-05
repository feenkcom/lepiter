Class {
	#name : #LePageBuilderExamples,
	#superclass : #LeContentBuilderExamples,
	#category : #'Lepiter-Core-Examples-Builder'
}

{ #category : #'examples - basic' }
LePageBuilderExamples >> basicBuilder [
	<gtExample>
	<return: #LePageBuilder>
	| aBuilder |
	aBuilder := LePage builder.
	^ aBuilder
]

{ #category : #'examples - pages' }
LePageBuilderExamples >> basicPage [
	<gtExample>
	<return: #LePage>
	| aBuilder aPage |
	aBuilder := self basicBuilder.
	aPage := aBuilder build.
	self assert: aPage class equals: LePage.
	^ aPage
]
